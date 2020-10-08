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

Application
    sonicFoam

Group
    grpCompressibleSolvers

Description
    Transient solver for trans-sonic/supersonic, turbulent flow of a
    compressible gas.

\*---------------------------------------------------------------------------*/

#include "fvCFD.H"
#include "psiThermo.H"
#include "turbulentFluidThermoModel.H"
#include "pimpleControl.H"
#include "fvOptions.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

int main(int argc, char *argv[])
{
    #include "postProcess.H"

    #include "setRootCase.H"
    #include "createTime.H"
    #include "createMesh.H"
    #include "createControl.H"
    #include "createFields.H"
    #include "createFieldRefs.H"
    #include "createFvOptions.H"
    #include "initContinuityErrs.H"

    turbulence->validate();

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

    Info<< "\nStarting time loop\n" << endl;

    while (runTime.loop())
    {
        Info<< "Time = " << runTime.timeName() << nl << endl;

        #include "compressibleCourantNo.H"

        #include "rhoEqn.H"

        // --- Pressure-velocity PIMPLE corrector loop
        while (pimple.loop())
        {
	// CHEMICAL SOURCE TERM - V.ROBIN START
		// Chem table coefficient and variables 
		scal2stoech  = aa1*scal3 + bb1;
		deltaHstoech = aa2*scal3 + bb2;
		//alphastoech  = aa3*scal3 + bb3;
                richlimitfield = richlimit;
                poorlimitfield = poorlimit;
                dilutionlimitfield = dilutionlimit;
                a3=aa3;
                b3=bb3;
                c3=cc3;
                d3=dd3;
                e3=ee3;
		a4=aa4;
                b4=bb4;
                c4=cc4;
                d4=dd4;
                e4=ee4;
                f4=ff4;
                g4=gg4;
                a5=aa5;
                b5=bb5;
                c5=cc5;
                d5=dd5;
                e5=ee5;
                f5=ff5;
                g5=gg5;
                h5=hh5;
                i5=ii5;
		// leading edge limit : fresh gas
		cminfield = exp(-1/(sqrt(Ka)));
		segregfield=Segreg;
		// maximum and minimum value of the progress variable scal1
		scal1max=scal2;
		scal1min=0;
		// loop over cells
		//Info<< "entrée boucle" << Ka << nl << endl;
		//cout<< "entrée boucle cell"; 
		forAll(mesh.C(),cellI)
                {
			scalar epsi = 0.00001;
			//if (scal2[cellI] > 0.04 )
			//cout<< "Vincent dans boucle debut "
			//<< scal1[cellI] <<scal2[cellI] <<scal3[cellI] << nl << endl;
                        //scalar epsi = ROOTVSMALL;
                        //
			// pour sortie logfile :
			//Info<< "Vincent dans boucle small = " << epsi << nl << endl;
			//
			// Calcul scal2adim
			if (scal3[cellI] < dilutionlimitfield[cellI] )
		    	{
			//Info<< "entrée clacul scal2 " << scal2[cellI] << nl << endl;
                        //Info<< "entrée clacul scal3 " << scal3[cellI] << nl << endl;
				scalar ratio  = min(max(epsi,(scal2[cellI]/(1-scal3[cellI]))),1.0-epsi);
                        //Info<< "entrée clacul ratio2 " << ratio << nl << endl;
				scalar ratio2 = min(max(epsi,(scal2stoech[cellI]/(1-scal3[cellI]))),1.0-epsi);
                        //Info<< "entrée clacul ratio2 " << ratio2 << nl << endl;
				scalar power = Foam::log(0.5)/Foam::log(ratio2);
                        //Info<< "entrée clacul power " << power << nl << endl;
				scal2adim[cellI] =  Foam::pow(ratio,power);
                        //Info<< "entrée clacul scal2adim " << scal2adim[cellI] << nl << endl;
                        //Info<< "entrée clacul scal2adim " << scal2adim[cellI] << nl << endl;
                        //Info<< "entrée clacul poor " << poorlimitfield[cellI] << nl << endl;
                        //Info<< "entrée clacul rich " << richlimitfield[cellI] << nl << endl;
			}
			else
			{
				scal2adim[cellI] = 0.0;
			}
                        //Info<< "entrée clacul scal2adim " << scal2adim[cellI] << nl << endl;
                        //Info<< "entrée clacul scal2adim " << poorlimitfield[cellI] << nl << endl;
                        //Info<< "entrée clacul scal2adim " << richlimitfield[cellI] << nl << endl;
			// extinction limits
			if ((scal2adim[cellI] < richlimitfield[cellI])&&(scal2adim[cellI] > poorlimitfield[cellI]))
			{
                                //cout<< "entrée clacul deltaH " << scal2adim[cellI] << deltaHstoech[cellI] << nl << endl;


				deltaHfield[cellI] = (  a4[cellI]*pow(scal2adim[cellI],6) + b4[cellI]*pow(scal2adim[cellI],5)
						      + c4[cellI]*pow(scal2adim[cellI],4) + d4[cellI]*pow(scal2adim[cellI],3)
						      + e4[cellI]*pow(scal2adim[cellI],2) + f4[cellI]*scal2adim[cellI]
						      + g4[cellI] ) * deltaHstoech[cellI];
                                alphastoech[cellI] = ( a3[cellI]*pow(scal3[cellI],4) + b3[cellI]*pow(scal3[cellI],3)
                                                     + c3[cellI]*pow(scal3[cellI],2) + d3[cellI]*scal3[cellI]
                                                     + e3[cellI] );
                                alphafield[cellI] = (  a5[cellI]*pow(scal2adim[cellI],8) + b5[cellI]*pow(scal2adim[cellI],7)
						     + c5[cellI]*pow(scal2adim[cellI],6) + d5[cellI]*pow(scal2adim[cellI],5)
                                                     + e5[cellI]*pow(scal2adim[cellI],4) + f5[cellI]*pow(scal2adim[cellI],3)
                                                     + g5[cellI]*pow(scal2adim[cellI],2) + h5[cellI]*scal2adim[cellI]
						     + i5[cellI] ) * alphastoech[cellI];
                        	//cout<< "Vincent dans boucle deltaHnew = " << deltaHfield[cellI] << nl << endl;
                		//alphafield[cellI] = 4000/(1-segregfield[cellI]);
                		//deltaHfield[cellI] = 2000000;


				if (((scal1max[cellI]-scal1[cellI])/(scal1max[cellI]-scal1min[cellI]))>cminfield[cellI]) // leading edge limit
				{
					// chemical source applied to the progress variable scal1 
					OmegaP[cellI] = alphafield[cellI]*(1-segregfield[cellI])
                                        //OmegaP[cellI] = 4000
							*(scal1max[cellI]-scal1[cellI])*(scal1[cellI]-scal1min[cellI])
							/(scal1max[cellI]-scal1min[cellI]);
                                        // chemical source applied to the sensible total internal energy e : chemical heat release
					OmegaE[cellI]=deltaHfield[cellI]*OmegaP[cellI]/(scal1max[cellI]-scal1min[cellI]);
				}
				else
                        	{
                                	OmegaP[cellI] = 0;
					OmegaE[cellI] = 0;
                        	}
			}
			else
			{
				OmegaP[cellI] = 0;
				OmegaE[cellI] = 0;
			}
			//cout<< "Vincent dans boucle fin " << scal2[cellI] << nl << endl;
                }
                //cout<< "sortie boucle cell";
                // loop over ignition cells to apply the source terms representative of a spark
                // constant to specify : sparktime, sparkdt, sparkeff in constant/CV2param
                spark1field = sparktime;
                spark2field = sparkdt;
                spark3field = sparkdelay;
                const Time& time = mesh.time();
		const labelList& ids = mesh.cellZones().findIndices("allumageZone");
                forAll(ids, i)
                {
                   	const labelList& cells = mesh.cellZones()[ids[i]];
                   	forAll(cells, j)
                   	{
			        scalar epsi = 0.00001;
				label cellI = cells[j];
				// time interval on which the spark continue to have an effect
                                //if ((time.value() > spark1field[cellI])&&(time.value() < (spark1field[cellI]+2*spark2field[cellI])))
                                if (time.value() > spark1field[cellI]&&((scal1max[cellI]-scal1min[cellI])>epsi))
                      		{
					// chemical source applied to the progress variable scal1
                         		//OmegaSpark[cellI] = (scal1[cellI]-spark3field[cellI])/spark2field[cellI];
					OmegaSpark[cellI] = ((scal1[cellI]- scal1min[cellI])/(spark2field[cellI]))*(1-Foam::exp(-pow(((time.value()-spark1field[cellI])/spark3field[cellI]),10)));
                                        // corresponding heat release applied to the sensible total internal energy e
					OmegaE[cellI]=OmegaE[cellI]+deltaHfield[cellI]*OmegaSpark[cellI]/(scal1max[cellI]-scal1min[cellI]);
                      		}
				else
				{
					OmegaSpark[cellI] = 0;
				}
                   	}
                }
		//cout<< "sortie boucle ignit";
	// CHEMICAL SOURCE TERM - V.ROBIN END : ne faut-il pas résoudre les scalaires avant E ?
            #include "UEqn.H"
            #include "EEqn.H"
            #include "scal1Eqn.H"
            #include "scal2Eqn.H"
            #include "scal3Eqn.H"

            // --- Pressure corrector loop
            while (pimple.correct())
            {
                #include "pEqn.H"
            }

            if (pimple.turbCorr())
            {
                turbulence->correct();
            }
        }

        rho = thermo.rho();

        runTime.write();

        Info<< "ExecutionTime = " << runTime.elapsedCpuTime() << " s"
            << "  ClockTime = " << runTime.elapsedClockTime() << " s"
            << nl << endl;
    }

    Info<< "End\n" << endl;

    return 0;
}


// ************************************************************************* //
