{
    fvScalarMatrix scal1Eqn
    (
        fvm::ddt(rho, scal1) 
      + fvm::div(phi, scal1)
      - fvm::laplacian(turbulence->alphaEff(), scal1)
     ==
        fvOptions(rho, scal1)
       - rho*OmegaP
       - rho*OmegaSpark
    );

    scal1Eqn.relax();

    fvOptions.constrain(scal1Eqn);

    scal1Eqn.solve();

    fvOptions.correct(scal1);

    thermo.correct();
    
}
