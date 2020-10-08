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
#include "nutWallFunctionFvPatchScalarField.H"
#include "alphatCV2WallFunctionFvPatchScalarField.H"
#include "turbulenceModel.H"
#include "compressibleTurbulenceModel.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "addToRunTimeSelectionTable.H"
#include "turbulentFluidThermoModel.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
namespace compressible
{

// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

alphatCV2WallFunctionFvPatchScalarField::alphatCV2WallFunctionFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF
)
:
    fixedValueFvPatchScalarField(p, iF),
    // V. Robin : kappa and E are the modeling parameters of the velocity boundary layer : same than nutWallfunction
    // kappaT is the termal boundary layer parameter
    //Prt_(0.85)
    kappa_(0.41),
    kappaT_(0.47),
    E_(8.6)
{}


alphatCV2WallFunctionFvPatchScalarField::alphatCV2WallFunctionFvPatchScalarField
(
    const alphatCV2WallFunctionFvPatchScalarField& ptf,
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    fixedValueFvPatchScalarField(ptf, p, iF, mapper),
    //Prt_(ptf.Prt_)
    kappa_(ptf.kappa_),
    kappaT_(ptf.kappaT_),
    E_(ptf.E_)
{}


alphatCV2WallFunctionFvPatchScalarField::alphatCV2WallFunctionFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const dictionary& dict
)
:
    fixedValueFvPatchScalarField(p, iF, dict),
    //Prt_(dict.lookupOrDefault<scalar>("Prt", 0.85))
    kappa_(dict.lookupOrDefault<scalar>("kappa", 0.41)),
    kappaT_(dict.lookupOrDefault<scalar>("kappaT", 0.47)),
    E_(dict.lookupOrDefault<scalar>("E", 8.6))
{}


alphatCV2WallFunctionFvPatchScalarField::alphatCV2WallFunctionFvPatchScalarField
(
    const alphatCV2WallFunctionFvPatchScalarField& awfpsf
)
:
    fixedValueFvPatchScalarField(awfpsf),
    //Prt_(awfpsf.Prt_)
    kappa_(awfpsf.kappa_),
    kappaT_(awfpsf.kappaT_),
    E_(awfpsf.E_)
{}


alphatCV2WallFunctionFvPatchScalarField::alphatCV2WallFunctionFvPatchScalarField
(
    const alphatCV2WallFunctionFvPatchScalarField& awfpsf,
    const DimensionedField<scalar, volMesh>& iF
)
:
    fixedValueFvPatchScalarField(awfpsf, iF),
    //Prt_(awfpsf.Prt_)
    kappa_(awfpsf.kappa_),
    kappaT_(awfpsf.kappaT_),
    E_(awfpsf.E_)
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //


tmp<scalarField> alphatCV2WallFunctionFvPatchScalarField::calcYPlusT
(
    const scalarField& magUp
) const
{
    const label patchi = patch().index();
//
// V. Robin : this subfunction calculate y+ identically than in nutwallfunction : based on the velocity boundary layer
//
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
    const tmp<scalarField> tyPlam = yPlusLamT();
    const scalarField& yPlam = tyPlam.ref();

    tmp<scalarField> tyPlus(new scalarField(patch().size(), 0.0));
    scalarField& yPlus = tyPlus.ref();

    forAll(yPlus, facei)
    {
        label faceCelli = patch().faceCells()[facei];
        scalar yp = yPlam[facei];
        scalar ryPlusLam = 1.0/yp;

        scalar Rey = magUp[facei]*y[facei]/nuw[facei];

        int iter = 0;
        scalar yPlusLast = 0.0;

        do
        {
            yPlusLast = yp;
            scalar term1 = (1/kappa_)*log(1+kappa_*yp);
            scalar dypterm1 = yp/(1+kappa_*yp)+term1;
            scalar term2 = (1/kappa_)*log(E_/kappa_)*(1-exp(-yp/11) - yp/11*exp(-yp/3));
            scalar dypterm2 = (1/kappa_)*log(E_/kappa_)*(yp/11)*(-exp(-yp/3) + exp(-yp/11) + yp/3*exp(-yp/3)) + term2;
            scalar up = term1 + term2;
            scalar f = yp * up - Rey;
            scalar df = dypterm1 + dypterm2;
            yp = yp - f/df;

        } while (mag(ryPlusLam*(yp - yPlusLast)) > 0.01 && ++iter < 10 );

        yPlus[facei] = max(0.0, yp);
    }

    return tyPlus;
}


tmp<scalarField> alphatCV2WallFunctionFvPatchScalarField::yPlusT() const
{
//
// V. Robin : this subfunction retunr y+ value to used it in other subfunctions
//
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

    return calcYPlusT(magUp);
}

tmp<scalarField> alphatCV2WallFunctionFvPatchScalarField::TPlusT() const
{
    const label patchi = patch().index();

    const compressible::turbulenceModel& turbModel =
        db().lookupObject<compressible::turbulenceModel>
        (
            IOobject::groupName
            (
                compressible::turbulenceModel::propertiesName,
                internalField().group()
            )
        );


    const tmp<scalarField> tyPlus = yPlusT();
    const scalarField& yPlus = tyPlus.ref();
    const tmp<scalarField> tyPluslam = yPlusLamT();
    const scalarField& yPluslam = tyPluslam.ref();


    const tmp<scalarField> tmuw = turbModel.mu(patchi);
    const scalarField& muw = tmuw();
    const tmp<scalarField> talphaw = turbModel.alpha(patchi);
    const scalarField& alphaw = talphaw();


    tmp<scalarField> tTPlus(new scalarField(patch().size(), 0.0));
    scalarField& TPlus = tTPlus.ref();

    forAll(TPlus, facei)
    {
        //scalar kappaRe = kappa_*magUp[facei]*y[facei]/nuw[facei];
        //scalar yp = yPlusLamT(kappa_, E_);
        //scalar ryPlusLam = 1.0/yp;
        //scalar Rey = magUp[facei]*y[facei]/nuw[facei];
        //yPlusLast = yp;
        //scalar term1 = (1/kappa_)*log(1+kappa_*yp);
        //scalar dypterm1 = yp/(1+kappa_*yp)+term1;
        //scalar term2 = (1/kappa_)*log(E_/kappa_)*(1-exp(-yp/11) - yp/11*exp(-yp/3));
        //scalar dypterm2 = (1/kappa_)*log(E_/kappa_)*(yp/11)*(-exp(-yp/3) + exp(-yp/11) + yp/3*exp(-yp/3)) + term2;
        //scalar up = term1 + term2;
        //scalar f = yp * up - Rey;
        //scalar df = dypterm1 + dypterm2;
        //yp = yp - f/df;
        scalar yp = yPlus[facei];
        scalar yplam = yPluslam[facei];
	scalar Pr = muw[facei]/alphaw[facei];
        scalar beta=pow((3.85*pow(Pr,0.333) - 1.3),2)+log(Pr)/kappaT_;
	scalar term1 = (Pr/kappaT_)*log(1+kappaT_*yp);
        scalar term2 = (beta-(Pr/kappaT_)*log(kappaT_)+((1-Pr)/kappaT_)*log(1+yp));
        scalar termdamp =(1-exp(-yp/yplam) - yp/yplam*exp(-5*yp/yplam)); 

        TPlus[facei] = muw[facei]*(yp/(term1+term2*termdamp + ROOTVSMALL)-1);
    }

    return tTPlus;
}

tmp<scalarField> alphatCV2WallFunctionFvPatchScalarField::yPlusLamT()  const
{
    const label patchi = patch().index();
    const compressible::turbulenceModel& turbModel =
        db().lookupObject<compressible::turbulenceModel>
        (
            IOobject::groupName
            (
                compressible::turbulenceModel::propertiesName,
                internalField().group()
            )
        );

    const tmp<scalarField> tmuw = turbModel.mu(patchi);
    const scalarField& muw = tmuw();
    const tmp<scalarField> talphaw = turbModel.alpha(patchi);
    const scalarField& alphaw = talphaw();

    tmp<scalarField> typlam(new scalarField(patch().size(), 0.0));
    scalarField& yplam = typlam.ref();

    forAll(yplam, facei)
    {
    	scalar ypl = 1.0;
    	scalar Pr = muw[facei]/alphaw[facei];
        scalar beta=pow((3.85*pow(Pr,0.333) - 1.3),2)+log(Pr)/kappaT_;
	for (int i=0; i<10; i++)
    	{
       		//ypl = log(max(E*ypl, 1))/kappa;
       	 	ypl = log(1+kappaT_*ypl)/(kappaT_*Pr)+beta/Pr;
    	}
        yplam[facei]=ypl;
        //Info<< "Vincent yplam = " << yplam[facei] << nl << endl;
    }
    return typlam;
}


tmp<scalarField> alphatCV2WallFunctionFvPatchScalarField::gammawall() const
{
    const label patchi = patch().index();

//    const turbulenceModel& turbModel = db().lookupObject<turbulenceModel>
//    (
//        IOobject::groupName
//        (
//            turbulenceModel::propertiesName,
//            internalField().group()
//        )
//    );
    const compressible::turbulenceModel& turbModel =
        db().lookupObject<compressible::turbulenceModel>
        (
            IOobject::groupName
            (
                compressible::turbulenceModel::propertiesName,
                internalField().group()
            )
        );
    const tmp<scalarField> tmuw = turbModel.mu(patchi);
    const scalarField& muw = tmuw();
    const tmp<scalarField> talphaw = turbModel.alpha(patchi);
    const scalarField& alphaw = talphaw();


    //return y*calcUTauT(mag(Uw.snGrad()))/nuw;
    return 0.01*pow(muw/alphaw*yPlusT(),4)/(1+5*pow(muw/alphaw,3)*yPlusT());
}


void alphatCV2WallFunctionFvPatchScalarField::updateCoeffs()
{
    if (updated())
    {
        return;
    }

    const label patchi = patch().index();

    // Retrieve turbulence properties from model
//    const compressibleTurbulenceModel& turbModel =
//        db().lookupObject<compressibleTurbulenceModel>
//        (
//            IOobject::groupName
//            (
//                compressibleTurbulenceModel::propertiesName,
//                internalField().group()
//            )
//        );
    const compressible::turbulenceModel& turbModel =
        db().lookupObject<compressible::turbulenceModel>
        (
            IOobject::groupName
            (
                compressible::turbulenceModel::propertiesName,
                internalField().group()
            )
        );

    const scalarField& rhow = turbModel.rho().boundaryField()[patchi];
    const tmp<scalarField> tnutw = turbModel.nut(patchi);
    const tmp<scalarField> tnuw = turbModel.nu(patchi);
    const scalarField& nuw = tnuw();
    const tmp<scalarField> tmuw = turbModel.mu(patchi);
    const scalarField& muw = tmuw();
    const tmp<scalarField> talphaw = turbModel.alpha(patchi);
    const scalarField& alphaw = talphaw();

    const tmp<scalarField> talphat = TPlusT();
    const scalarField& alphat = talphat.ref();

// Molecular Prandtl number
//    scalar Pr = muw[facei]/alphaw[facei];

//    operator==(rhow*tnutw/Prt_);
//    operator==(rhow*tnutw/kappa_);
//    operator==(rhow*nuw*yPlus()/(2.1*log(yPlus())+2.5));
//    operator==((muw*yPlusT()/((muw/alphaw)*yPlusT()*exp(-gammawall())+((1/0.47)*log(yPlusT()+1)+pow((3.85*pow((muw/alphaw),(1/3)) - 1.3),2) + (1/0.47)*log(muw/alphaw))*exp(-1/gammawall()))) - muw);

    operator==(TPlusT());

    fixedValueFvPatchScalarField::updateCoeffs();
}


void alphatCV2WallFunctionFvPatchScalarField::write(Ostream& os) const
{
    fvPatchField<scalar>::write(os);
    //os.writeKeyword("Prt") << Prt_ << token::END_STATEMENT << nl;
    os.writeKeyword("kappa") << kappa_ << token::END_STATEMENT << nl;
    os.writeKeyword("kappaT") << kappaT_ << token::END_STATEMENT << nl;
    os.writeKeyword("E") << E_ << token::END_STATEMENT << nl;
    writeEntry("value", os);
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

makePatchTypeField
(
    fvPatchScalarField,
    alphatCV2WallFunctionFvPatchScalarField
);

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace compressible
} // End namespace Foam

// ************************************************************************* //
