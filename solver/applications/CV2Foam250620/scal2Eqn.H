{
    fvScalarMatrix scal2Eqn
    (
        fvm::ddt(rho, scal2) 
      + fvm::div(phi, scal2)
      - fvm::laplacian(turbulence->alphaEff(), scal2)
     ==
        fvOptions(rho, scal2)
    );

    scal2Eqn.relax();

    fvOptions.constrain(scal2Eqn);

    scal2Eqn.solve();

    fvOptions.correct(scal2);

    thermo.correct();
    
}
