{
    fvScalarMatrix scal3Eqn
    (
        fvm::ddt(rho, scal3) 
      + fvm::div(phi, scal3)
      - fvm::laplacian(turbulence->alphaEff(), scal3)
     ==
        fvOptions(rho, scal3)
    );

    scal3Eqn.relax();

    fvOptions.constrain(scal3Eqn);

    scal3Eqn.solve();

    fvOptions.correct(scal3);

    thermo.correct();
    
}
