/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2011-2016 OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "nutUCV2WallFunctionFvPatchScalarField.H"
#include "turbulenceModel.H"
#include "compressibleTurbulenceModel.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "addToRunTimeSelectionTable.H"
#include "turbulentFluidThermoModel.H"
//#include "fluidThermo.H"
#include "psiThermo.H"


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
namespace compressible
{

// * * * * * * * * * * * * Protected Member Functions  * * * * * * * * * * * //

tmp<scalarField> nutUCV2WallFunctionFvPatchScalarField::calcNut() const
{
    const label patchi = patch().index();

    const turbulenceModel& turbModel = db().lookupObject<turbulenceModel>
    (
        IOobject::groupName
        (
            turbulenceModel::propertiesName,
            internalField().group()
        )
    );
    const fvPatchVectorField& Uw = turbModel.U().boundaryField()[patchi];
   // const fvPatchScalarField& Tw = turbModel.p().boundaryField()[patchi];
    const scalarField magUp(mag(Uw.patchInternalField() - Uw));
    const tmp<scalarField> tnuw = turbModel.nu(patchi);
    const scalarField& nuw = tnuw();

    tmp<scalarField> tyPlus = calcYPlus(magUp);
    scalarField& yPlus = tyPlus.ref();

    tmp<scalarField> tnutw(new scalarField(patch().size(), 0.0));
    scalarField& nutw = tnutw.ref();

    forAll(yPlus, facei)
    {
	// Vincent : B = log(E/kappa) / kappa
        scalar term1 = (1/kappa_)*log(1+kappa_*yPlus[facei]);
        scalar term2 = (1/kappa_)*log(E_/kappa_)*(1-exp(-yPlus[facei]/11) - yPlus[facei]/11*exp(-yPlus[facei]/3));
        scalar up = term1 + term2;
        nutw[facei] = max(0.0,
            nuw[facei]*(yPlus[facei]/(up + ROOTVSMALL) - 1.0) );
        //if (yPlus[facei] > yPlusLam_)
        //{
        //   nutw[facei] =
        //        nuw[facei]*(yPlus[facei]*kappa_/log(E_*yPlus[facei]) - 1.0);
        //}
    }

    return tnutw;
}


tmp<scalarField> nutUCV2WallFunctionFvPatchScalarField::calcYPlus
(
    const scalarField& magUp
) const
{
    const label patchi = patch().index();
    //const turbulenceModel& turbModel = db().lookupObject<turbulenceModel>
    //(
    //    IOobject::groupName
      //  (
      //      turbulenceModel::propertiesName,
     //       internalField().group()
    //    )
    //);
    const compressible::turbulenceModel& turbModel =
        db().lookupObject<compressible::turbulenceModel>
        (
            IOobject::groupName
            (
                compressible::turbulenceModel::propertiesName,
                internalField().group()
            )
        );
    const scalarField& y = turbModel.y()[patchi];
    const tmp<scalarField> tnuw = turbModel.nu(patchi);
    const scalarField& nuw = tnuw();
    const scalarField& Tw = turbModel.transport().T().boundaryField()[patchi];
    const tmp<volScalarField> tT1 = turbModel.transport().T();
    const volScalarField& T1 = tT1();
//    const scalarField& T1 = turbModel.transport().T();
    //const scalarField& T_bord = patch().lookupPatchField<volScalarField, scalar>("T").patchInternalField();

    tmp<scalarField> tyPlus(new scalarField(patch().size(), 0.0));
    scalarField& yPlus = tyPlus.ref();

    forAll(yPlus, facei)
    {
        label faceCelli = patch().faceCells()[facei];
        //scalar kappaRe = kappa_*magUp[facei]*y[facei]/nuw[facei];

        scalar yp = yPlusLam_;
        scalar ryPlusLam = 1.0/yp;

        //vincentdebut
        //Info<< "Vincent Temp = " << T1[faceCelli] << nl << endl;
        scalar Rey = magUp[facei]*y[facei]/nuw[facei];
        //scalar Rey = (T1[faceCelli]/Tw[facei])*magUp[facei]*y[facei]/nuw[facei];

        //vincent fin

        int iter = 0;
        scalar yPlusLast = 0.0;

        do
        {
            yPlusLast = yp;
            //yp = (kappaRe + yp)/(1.0 + log(E_*yp));
            //vincentdebut
            scalar term1 = (1/kappa_)*log(1+kappa_*yp);
            scalar dypterm1 = yp/(1+kappa_*yp)+term1;
            scalar term2 = (1/kappa_)*log(E_/kappa_)*(1-exp(-yp/11) - yp/11*exp(-yp/3));
            scalar dypterm2 = (1/kappa_)*log(E_/kappa_)*(yp/11)*(-exp(-yp/3) + exp(-yp/11) + yp/3*exp(-yp/3)) + term2;
            //scalar up = (1/kappa_)*log(E_*yp);
            scalar up = term1 + term2;
            scalar f = yp*up-Rey;
            //scalar df = (1/kappa_)*(1+log(E_*yp));
            scalar df = dypterm1 + dypterm2;
	    yp = yp - f/df;
            //vincent fin

        } while (mag(ryPlusLam*(yp - yPlusLast)) > 0.01 && ++iter < 10 );

        yPlus[facei] = max(0.0, yp);
    }

    return tyPlus;
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

nutUCV2WallFunctionFvPatchScalarField::nutUCV2WallFunctionFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF
)
:
    nutWallFunctionFvPatchScalarField(p, iF)
{}


nutUCV2WallFunctionFvPatchScalarField::nutUCV2WallFunctionFvPatchScalarField
(
    const nutUCV2WallFunctionFvPatchScalarField& ptf,
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    nutWallFunctionFvPatchScalarField(ptf, p, iF, mapper)
{}


nutUCV2WallFunctionFvPatchScalarField::nutUCV2WallFunctionFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const dictionary& dict
)
:
    nutWallFunctionFvPatchScalarField(p, iF, dict)
{}


nutUCV2WallFunctionFvPatchScalarField::nutUCV2WallFunctionFvPatchScalarField
(
    const nutUCV2WallFunctionFvPatchScalarField& sawfpsf
)
:
    nutWallFunctionFvPatchScalarField(sawfpsf)
{}


nutUCV2WallFunctionFvPatchScalarField::nutUCV2WallFunctionFvPatchScalarField
(
    const nutUCV2WallFunctionFvPatchScalarField& sawfpsf,
    const DimensionedField<scalar, volMesh>& iF
)
:
    nutWallFunctionFvPatchScalarField(sawfpsf, iF)
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

tmp<scalarField> nutUCV2WallFunctionFvPatchScalarField::yPlus() const
{
    const label patchi = patch().index();
    const turbulenceModel& turbModel = db().lookupObject<turbulenceModel>
    (
        IOobject::groupName
        (
            turbulenceModel::propertiesName,
            internalField().group()
        )
    );
    const fvPatchVectorField& Uw = turbModel.U().boundaryField()[patchi];
    const scalarField magUp(mag(Uw.patchInternalField() - Uw));

    return calcYPlus(magUp);
}


void nutUCV2WallFunctionFvPatchScalarField::write(Ostream& os) const
{
    fvPatchField<scalar>::write(os);
    writeLocalEntries(os);
    writeEntry("value", os);
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

makePatchTypeField
(
    fvPatchScalarField,
    nutUCV2WallFunctionFvPatchScalarField
);

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace compressible
} // End namespace Foam

// ************************************************************************* //
