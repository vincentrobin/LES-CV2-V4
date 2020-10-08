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

Class
    Foam::compressible::alphatCV2WallFunctionFvPatchScalarField

Group
    grpCmpWallFunctions

Description
    This boundary condition provides a turbulent thermal diffusivity conditon
    when using wall functions
    - replicates OpenFOAM v1.5 (and earlier) behaviour

    The turbulent thermal diffusivity calculated using:

        \f[
            \alpha_t = \frac{\mu_t}{Pr_t}
        \f]

    where

    \vartable
        \alpha_t| turblence thermal diffusivity
        \mu_t   | turblence viscosity
        Pr_t    | turblent Prandtl number
    \endvartable

Usage
    \table
        Property     | Description             | Required    | Default value
        nut          | turbulence viscosity field name | no  | nut
        Prt          | turbulent Prandtl number | no          | 0.85
    \endtable

    Example of the boundary condition specification:
    \verbatim
    <patchName>
    {
        type            alphatCV2WallFunction;
        nut             nut;
        Prt             0.85;
        value           uniform 0; // optional value entry
    }
    \endverbatim

See also
    Foam::fixedValueFvPatchField

SourceFiles
    alphatCV2WallFunctionFvPatchScalarField.C

\*---------------------------------------------------------------------------*/

#ifndef compressibleAlphatCV2WallFunctionFvPatchScalarField_H
#define compressibleAlphatCV2WallFunctionFvPatchScalarField_H

#include "fixedValueFvPatchFields.H"
#include "nutWallFunctionFvPatchScalarField.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
namespace compressible
{

/*---------------------------------------------------------------------------*\
            Class alphatCV2WallFunctionFvPatchScalarField Declaration
\*---------------------------------------------------------------------------*/

class alphatCV2WallFunctionFvPatchScalarField
:
    public fixedValueFvPatchScalarField
{
    // Private data

        //- Turbulent Prandtl number (default = 0.85)
        //scalar Prt_;
        //- Von Karman constant
        scalar kappa_;
        scalar kappaT_;
        //- E coefficient
        scalar E_;

public:

    //- Runtime type information
    TypeName("compressible::alphatCV2WallFunction");


    // Constructors

        //- Construct from patch and internal field
        alphatCV2WallFunctionFvPatchScalarField
        (
            const fvPatch&,
            const DimensionedField<scalar, volMesh>&
        );

        //- Construct from patch, internal field and dictionary
        alphatCV2WallFunctionFvPatchScalarField
        (
            const fvPatch&,
            const DimensionedField<scalar, volMesh>&,
            const dictionary&
        );

        //- Construct by mapping given
        //  alphatCV2WallFunctionFvPatchScalarField
        //  onto a new patch
        alphatCV2WallFunctionFvPatchScalarField
        (
            const alphatCV2WallFunctionFvPatchScalarField&,
            const fvPatch&,
            const DimensionedField<scalar, volMesh>&,
            const fvPatchFieldMapper&
        );

        //- Construct as copy
        alphatCV2WallFunctionFvPatchScalarField
        (
            const alphatCV2WallFunctionFvPatchScalarField&
        );

        //- Construct and return a clone
        virtual tmp<fvPatchScalarField> clone() const
        {
            return tmp<fvPatchScalarField>
            (
                new alphatCV2WallFunctionFvPatchScalarField(*this)
            );
        }

        //- Construct as copy setting internal field reference
        alphatCV2WallFunctionFvPatchScalarField
        (
            const alphatCV2WallFunctionFvPatchScalarField&,
            const DimensionedField<scalar, volMesh>&
        );

        //- Construct and return a clone setting internal field reference
        virtual tmp<fvPatchScalarField> clone
        (
            const DimensionedField<scalar, volMesh>& iF
        ) const
        {
            return tmp<fvPatchScalarField>
            (
                new alphatCV2WallFunctionFvPatchScalarField(*this, iF)
            );
        }


    // Member functions

        // Evaluation functions

            //- Update the coefficients associated with the patch field
            virtual void updateCoeffs();
            
	    //- Calculate and return the yPlus at the boundary
            virtual tmp<scalarField> yPlusT() const;

            //- Calculate and return the yPlus at the boundary
            virtual tmp<scalarField> TPlusT() const;

            //- Calculate and return the yPlus at the boundary
            virtual tmp<scalarField> gammawall() const;

            //- Calculate the friction velocity
            virtual tmp<scalarField> calcYPlusT(const scalarField& magUp) const;

           //- Calculate the Y+ at the edge of the laminar sublayer
            virtual  tmp<scalarField> yPlusLamT() const;

        // I-O

            //- Write
            virtual void write(Ostream&) const;
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace compressible
} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************************************************************* //
