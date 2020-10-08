Info<< "Reading thermophysical properties\n" << endl;

autoPtr<psiThermo> pThermo
(
    psiThermo::New(mesh)
);
psiThermo& thermo = pThermo();
thermo.validate(args.executable(), "e");

volScalarField& p = thermo.p();

volScalarField rho
(
    IOobject
    (
        "rho",
        runTime.timeName(),
        mesh
    ),
    thermo.rho()
);

Info<< "Reading field U\n" << endl;
volVectorField U
(
    IOobject
    (
        "U",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);
//
// DECLARE VARIABLES AND CONSTANT : V ROBIN START
//
Info<< "Reading field scal1\n" << endl;
volScalarField scal1
(
    IOobject
    (
        "scal1",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

Info<< "Reading field scal2\n" << endl;
volScalarField scal2
(
    IOobject
    (
        "scal2",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

Info<< "Reading field scal3\n" << endl;
volScalarField scal3
(
    IOobject
    (
        "scal3",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

Info<< "Reading field OmegaP\n" << endl;
volScalarField OmegaP
(
    IOobject
    (
        "OmegaP",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("OmegaP", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field OmegaE\n" << endl;
volScalarField OmegaE
(
    IOobject
    (
        "OmegaE",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("OmegaE", dimensionSet(0,2,-3,0,0,0,0), 0.0)
);

Info<< "Reading field OmegaSpark\n" << endl;
volScalarField OmegaSpark
(
    IOobject
    (
        "OmegaSpark",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("OmegaSpark", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field scal1min\n" << endl;
volScalarField scal1min
(
    IOobject
    (
        "scal1min",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("scal1min", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field scal1max\n" << endl;
volScalarField scal1max
(
    IOobject
    (
        "scal1max",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("scal1max", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field scal2stoech\n" << endl;
volScalarField scal2stoech
(
    IOobject
    (
        "scal2stoech",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("scal2stoech", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field scal2adim\n" << endl;
volScalarField scal2adim
(
    IOobject
    (
        "scal2adim",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("scal2adim", dimensionSet(0,0,0,0,0,0,0), 0.0)
);


Info<< "Reading field deltaHstoech\n" << endl;
volScalarField deltaHstoech
(
    IOobject
    (
        "deltaHstoech",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("deltaHstoech", dimensionSet(0,2,-2,0,0,0,0), 0.0)
);

Info<< "Reading field alphastoech\n" << endl;
volScalarField alphastoech
(
    IOobject
    (
        "alphastoech",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("alphastoech", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field cminfield\n" << endl;
volScalarField cminfield
(
    IOobject
    (
        "cminfield",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("cminfield", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field deltaHfield\n" << endl;
volScalarField deltaHfield
(
    IOobject
    (
        "deltaHfield",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("deltaHfield", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field alphafield\n" << endl;
volScalarField alphafield
(
    IOobject
    (
        "alphafield",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("alphafield", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field spark1field\n" << endl;
volScalarField spark1field
(
    IOobject
    (
        "spark1field",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("spark1field", dimensionSet(0,0,1,0,0,0,0), 0.0)
);

Info<< "Reading field spark2field\n" << endl;
volScalarField spark2field
(
    IOobject
    (
        "spark2field",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("spark2field", dimensionSet(0,0,1,0,0,0,0), 0.0)
);

Info<< "Reading field spark3field\n" << endl;
volScalarField spark3field
(
    IOobject
    (
        "spark3field",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("spark3field", dimensionSet(0,0,1,0,0,0,0), 0.0)
);

Info<< "Reading field richlimitfield\n" << endl;
volScalarField richlimitfield
(
    IOobject
    (
        "richlimitfield",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("richlimitfield", dimensionSet(0,0,0,0,0,0,0), 0.0)
);
Info<< "Reading field poorlimitfield\n" << endl;
volScalarField poorlimitfield
(
    IOobject
    (
        "poorlimitfield",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("poorlimitfield", dimensionSet(0,0,0,0,0,0,0), 0.0)
);
Info<< "Reading field dilutionlimitfield\n" << endl;
volScalarField dilutionlimitfield
(
    IOobject
    (
        "dilutionlimitfield",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("dilutionlimitfield", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field segregfield\n" << endl;
volScalarField segregfield
(
    IOobject
    (
        "segregfield",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("segregfield", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field a3\n" << endl;
volScalarField a3
(
    IOobject
    (
        "a3",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("a3", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field b3\n" << endl;
volScalarField b3
(
    IOobject
    (
        "b3",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("b3", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field c3\n" << endl;
volScalarField c3
(
    IOobject
    (
        "c3",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("c3", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field d3\n" << endl;
volScalarField d3
(
    IOobject
    (
        "d3",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("d3", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field e3\n" << endl;
volScalarField e3
(
    IOobject
    (
        "e3",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("e3", dimensionSet(0,0,-1,0,0,0,0), 0.0)
);

Info<< "Reading field a4\n" << endl;
volScalarField a4
(
    IOobject
    (
        "a4",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("a4", dimensionSet(0,0,0,0,0,0,0), 0.0)
);


Info<< "Reading field b4\n" << endl;
volScalarField b4
(
    IOobject
    (
        "b4",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("b4", dimensionSet(0,0,0,0,0,0,0), 0.0)
);


Info<< "Reading field c4\n" << endl;
volScalarField c4
(
    IOobject
    (
        "c4",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("c4", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field d4\n" << endl;
volScalarField d4
(
    IOobject
    (
        "d4",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("d4", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field e4\n" << endl;
volScalarField e4
(
    IOobject
    (
        "e4",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("e4", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field f4\n" << endl;
volScalarField f4
(
    IOobject
    (
        "f4",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("f4", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field g4\n" << endl;
volScalarField g4
(
    IOobject
    (
        "g4",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("g4", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field a5\n" << endl;
volScalarField a5
(
    IOobject
    (
        "a5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("a5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field b5\n" << endl;
volScalarField b5
(
    IOobject
    (
        "b5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("b5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field c5\n" << endl;
volScalarField c5
(
    IOobject
    (
        "c5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("c5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field d5\n" << endl;
volScalarField d5
(
    IOobject
    (
        "d5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("d5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field e5\n" << endl;
volScalarField e5
(
    IOobject
    (
        "e5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("e5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field f5\n" << endl;
volScalarField f5
(
    IOobject
    (
        "f5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("f5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field g5\n" << endl;
volScalarField g5
(
    IOobject
    (
        "g5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("g5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field h5\n" << endl;
volScalarField h5
(
    IOobject
    (
        "h5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("h5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);

Info<< "Reading field i5\n" << endl;
volScalarField i5
(
    IOobject
    (
        "i5",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar("i5", dimensionSet(0,0,0,0,0,0,0), 0.0)
);


IOdictionary CV2param
(
    IOobject
    (
        "CV2param",
        runTime.constant(),
        mesh,
        IOobject::MUST_READ_IF_MODIFIED,
        IOobject::AUTO_WRITE,
        true
    )
);

dimensionedScalar Segreg
(
    "Segreg",
    CV2param.lookup("Segreg")
);
dimensionedScalar Ka
(
    "Ka",
    CV2param.lookup("Ka")
);
dimensionedScalar sparktime
(
    "sparktime",
    CV2param.lookup("sparktime")
);
dimensionedScalar sparkdt
(
    "sparkdt",
    CV2param.lookup("sparkdt")
);
dimensionedScalar sparkdelay
(
    "sparkdelay",
    CV2param.lookup("sparkdelay")
);
dimensionedScalar richlimit
(
    "richlimit",
    CV2param.lookup("richlimit")
);
dimensionedScalar poorlimit
(
    "poorlimit",
    CV2param.lookup("poorlimit")
);
dimensionedScalar dilutionlimit
(
    "dilutionlimit",
    CV2param.lookup("dilutionlimit")
);
dimensionedScalar aa1
(
    "aa1",
    CV2param.lookup("aa1")
);
dimensionedScalar bb1
(
    "bb1",
    CV2param.lookup("bb1")
);
dimensionedScalar aa2
(
    "aa2",
    CV2param.lookup("aa2")
);
dimensionedScalar bb2
(
    "bb2",
    CV2param.lookup("bb2")
);
dimensionedScalar aa3
(
    "aa3",
    CV2param.lookup("aa3")
);
dimensionedScalar bb3
(
    "bb3",
    CV2param.lookup("bb3")
);
dimensionedScalar cc3
(
    "cc3",
    CV2param.lookup("cc3")
);
dimensionedScalar dd3
(
    "dd3",
    CV2param.lookup("dd3")
);
dimensionedScalar ee3
(
    "ee3",
    CV2param.lookup("ee3")
);

dimensionedScalar aa4
(
    "aa4",
    CV2param.lookup("aa4")
);
dimensionedScalar bb4
(
    "bb4",
    CV2param.lookup("bb4")
);
dimensionedScalar cc4
(
    "cc4",
    CV2param.lookup("cc4")
);
dimensionedScalar dd4
(
    "dd4",
    CV2param.lookup("dd4")
);
dimensionedScalar ee4
(
    "ee4",
    CV2param.lookup("ee4")
);
dimensionedScalar ff4
(
    "ff4",
    CV2param.lookup("ff4")
);
dimensionedScalar gg4
(
    "gg4",
    CV2param.lookup("gg4")
);
dimensionedScalar aa5
(
    "aa5",
    CV2param.lookup("aa5")
);
dimensionedScalar bb5
(
    "bb5",
    CV2param.lookup("bb5")
);
dimensionedScalar cc5
(
    "cc5",
    CV2param.lookup("cc5")
);
dimensionedScalar dd5
(
    "dd5",
    CV2param.lookup("dd5")
);
dimensionedScalar ee5
(
    "ee5",
    CV2param.lookup("ee5")
);
dimensionedScalar ff5
(
    "ff5",
    CV2param.lookup("ff5")
);
dimensionedScalar gg5
(
    "gg5",
    CV2param.lookup("gg5")
);
dimensionedScalar hh5
(
    "hh5",
    CV2param.lookup("hh5")
);
dimensionedScalar ii5
(
    "ii5",
    CV2param.lookup("ii5")
);

//
//// DECLARE VARIABLES AND CONSTANT : V ROBIN END
////
#include "compressibleCreatePhi.H"

mesh.setFluxRequired(p.name());

Info<< "Creating turbulence model\n" << endl;
autoPtr<compressible::turbulenceModel> turbulence
(
    compressible::turbulenceModel::New
    (
        rho,
        U,
        phi,
        thermo
    )
);

Info<< "Creating field kinetic energy K\n" << endl;
volScalarField K("K", 0.5*magSqr(U));

#include "createMRF.H"
