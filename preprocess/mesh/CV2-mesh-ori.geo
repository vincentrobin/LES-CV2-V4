//Gmsh project created on 10-11-2017 [Updated on 21-11-2017]

//CVC with structured mesh and four injector modules

coeff=1.0;
refin=1.0;

a=0.9;//for regular lines along y- & z-axis
b=0.9;//for regular lines along x-axis

x=0.9;//concentric divisions in radial direction for INLET/OUTLET blocks
y=0.9;//concentric divisions in radial direction for INJECTOR blocks

//Inlet side
Point(1) = {0.0,0.0,0.0,refin};
Point(30) = {0.0,0.00932,0.0,refin};
Point(2) = {0.0,0.01868,0.0,refin};
Point(3) = {0.0,0.03132,0.0,refin};
Point(31) = {0.0,0.04068,0.0,refin};
Point(4) = {0.0,0.05,0.0,refin};
Point(5) = {0.0,0.05,0.01868,refin};
Point(6) = {0.0,0.05,0.03132,refin};
Point(7) = {0.0,0.05,0.05,refin};
Point(32) = {0.0,0.04068,0.05,refin};
Point(8) = {0.0,0.03132,0.05,refin};
Point(9) = {0.0,0.01868,0.05,refin};
Point(33) = {0.0,0.00932,0.05,refin};
Point(10) = {0.0,0.0,0.05,refin};
Point(11) = {0.0,0.0,0.03132,refin};
Point(12) = {0.0,0.0,0.01868,refin};

Point(13) = {0.0,0.01868,0.01868,refin};
Point(14) = {0.0,0.03132,0.01868,refin};
Point(15) = {0.0,0.03132,0.03132,refin};
Point(16) = {0.0,0.01868,0.03132,refin};

Point(17) = {0.0,0.02076,0.02076,refin};
Point(18) = {0.0,0.02924,0.02076,refin};
Point(19) = {0.0,0.02924,0.02924,refin};
Point(20) = {0.0,0.02076,0.02924,refin};

Point(21) = {0.0,0.02146,0.02146,refin};
Point(22) = {0.0,0.02854,0.02146,refin};
Point(23) = {0.0,0.02854,0.02854,refin};
Point(24) = {0.0,0.02146,0.02854,refin};

Point(25) = {0.0,0.025,0.025,refin};

Point(26) = {0.0,0.023,0.023,refin};
Point(27) = {0.0,0.027,0.023,refin};
Point(28) = {0.0,0.027,0.027,refin};
Point(29) = {0.0,0.023,0.027,refin};

Point(34) = {0.0,0.04068,0.01868,refin};
Point(35) = {0.0,0.04068,0.03132,refin};
Point(36) = {0.0,0.00932,0.03132,refin};
Point(37) = {0.0,0.00932,0.01868,refin};


//Inlet side
Line(1) = {1,30};
Line(49) = {30,2};
Line(2) = {2,3};
Line(3) = {3,31};
Line(50) = {31,4};
Line(4) = {4,5};
Line(5) = {5,6};
Line(6) = {6,7};
Line(7) = {7,32};
Line(51) = {32,8};
Line(8) = {8,9};
Line(9) = {9,33};
Line(52) = {33,10};
Line(10) = {10,11};
Line(11) = {11,12};
Line(12) = {12,1};

Line(13) = {13,2};
Line(14) = {13,37};
Line(53) = {37,12};
Line(15) = {14,34};
Line(54) = {34,5};
Line(16) = {14,3};
Line(17) = {15,35};
Line(55) = {35,6};
Line(18) = {15,8};
Line(19) = {16,9};
Line(20) = {16,36};
Line(56) = {36,11};
Line(21) = {13,14};
Line(22) = {14,15};
Line(23) = {15,16};
Line(24) = {16,13};

Circle(25)={17,25,18};
Circle(26)={18,25,19};
Circle(27)={19,25,20};
Circle(28)={20,25,17};
Circle(29)={21,25,22};
Circle(30)={22,25,23};
Circle(31)={23,25,24};
Circle(32)={24,25,21};

Line(33) = {26,27};
Line(34) = {27,28};
Line(35) = {28,29};
Line(36) = {29,26};

Line(37) = {26,21};
Line(38) = {27,22};
Line(39) = {28,23};
Line(40) = {29,24};
Line(41) = {21,17};
Line(42) = {22,18};
Line(43) = {23,19};
Line(44) = {24,20};
Line(45) = {17,13};
Line(46) = {18,14};
Line(47) = {19,15};
Line(48) = {20,16};

Line(57) = {37,30};
Line(58) = {31,34};
Line(59) = {34,35};
Line(60) = {35,32};
Line(61) = {33,36};
Line(62) = {36,37};


//Inlet side
Transfinite Line {1,50,-54,53,-56,55,7,52} = 9.32*a Using Progression 1.0;
Transfinite Line {49,3,-15,14,-20,17,51,9} = 9.36*a Using Progression 1.0;
Transfinite Line {10,12,-57,-61,-19,13,-16,18,-60,-58,4,6} = 18.68*a Using Progression 1.0;

Transfinite Line {2,21} = 12.64*a Using Progression 1.0;
Transfinite Line {5,-59,22} = 12.64*a Using Progression 1.0;
Transfinite Line {8,23} = 12.64*a Using Progression 1.0;
Transfinite Line {11,-62,24} = 12.64*a Using Progression 1.0;

Transfinite Line {45,46,47,48} = 4*x Using Progression 1.0;
Transfinite Line {41,42,43,44} = 3*x Using Progression 1.0;
Transfinite Line {37,38,39,40} = 4*x Using Progression 1.0;

Transfinite Line {21,25} = 12.64*a Using Progression 1.0;
Transfinite Line {25,29} = 12.64*a Using Progression 1.0;
Transfinite Line {29,33} = 12.64*a Using Progression 1.0;

Transfinite Line {22,26} = 12.64*a Using Progression 1.0;
Transfinite Line {26,30} = 12.64*a Using Progression 1.0;
Transfinite Line {30,34} = 12.64*a Using Progression 1.0;

Transfinite Line {23,27} = 12.64*a Using Progression 1.0;
Transfinite Line {27,31} = 12.64*a Using Progression 1.0;
Transfinite Line {31,35} = 12.64*a Using Progression 1.0;

Transfinite Line {24,28} = 12.64*a Using Progression 1.0;
Transfinite Line {28,32} = 12.64*a Using Progression 1.0;
Transfinite Line {32,36} = 12.64*a Using Progression 1.0;


//INLET-side
Line Loop(200) = {1,-57,53,12};
Plane Surface(201) = {200};
Transfinite Surface {201} = {1,30,37,12};
Recombine Surface {201};

Line Loop(202) = {13,2,-16,-21};
Plane Surface(203) = {202};
Transfinite Surface {203} = {2,3,14,13};
Recombine Surface {203};

Line Loop(204) = {50,4,-54,-58};
Plane Surface(205) = {204};
Transfinite Surface {205} = {31,4,5,34};
Recombine Surface {205};

Line Loop(206) = {54,5,-55,-59};
Plane Surface(207) = {206};
Transfinite Surface {207} = {34,5,6,35};
Recombine Surface {207};

Line Loop(208) = {11,-53,-62,56};
Plane Surface(209) = {208};
Transfinite Surface {209} = {11,12,37,36};
Recombine Surface {209};

Line Loop(210) = {6,7,-60,55};
Plane Surface(211) = {210};
Transfinite Surface {211} = {6,7,32,35};
Recombine Surface {211};

Line Loop(212) = {18,8,-19,-23};
Plane Surface(213) = {212};
Transfinite Surface {213} = {15,8,9,16};
Recombine Surface {213};

Line Loop(214) = {52,10,-56,-61};
Plane Surface(215) = {214};
Transfinite Surface {215} = {33,10,11,36};
Recombine Surface {215};


Line Loop(216) = {21,-46,-25,45};
Plane Surface(217) = {216};
Transfinite Surface {217} = {13,14,18,17};
Recombine Surface {217};

Line Loop(218) = {22,-47,-26,46};
Plane Surface(219) = {218};
Transfinite Surface {219} = {14,15,19,18};
Recombine Surface {219};

Line Loop(220) = {23,-48,-27,47};
Plane Surface(221) = {220};
Transfinite Surface {221} = {15,16,20,19};
Recombine Surface {221};

Line Loop(222) = {24,-45,-28,48};
Plane Surface(223) = {222};
Transfinite Surface {223} = {16,13,17,20};
Recombine Surface {223};


Line Loop(224) = {25,-42,-29,41};
Plane Surface(225) = {224};
Transfinite Surface {225} = {17,18,22,21};
Recombine Surface {225};

Line Loop(226) = {26,-43,-30,42};
Plane Surface(227) = {226};
Transfinite Surface {227} = {18,19,23,22};
Recombine Surface {227};

Line Loop(228) = {27,-44,-31,43};
Plane Surface(229) = {228};
Transfinite Surface {229} = {19,20,24,23};
Recombine Surface {229};

Line Loop(230) = {28,-41,-32,44};
Plane Surface(231) = {230};
Transfinite Surface {231} = {20,17,21,24};
Recombine Surface {231};


Line Loop(232) = {29,-38,-33,37};
Plane Surface(233) = {232};
Transfinite Surface {233} = {21,22,27,26};
Recombine Surface {233};

Line Loop(234) = {30,-39,-34,38};
Plane Surface(235) = {234};
Transfinite Surface {235} = {22,23,28,27};
Recombine Surface {235};

Line Loop(236) = {31,-40,-35,39};
Plane Surface(237) = {236};
Transfinite Surface {237} = {23,24,29,28};
Recombine Surface {237};

Line Loop(238) = {32,-37,-36,40};
Plane Surface(239) = {238};
Transfinite Surface {239} = {24,21,26,29};
Recombine Surface {239};


Line Loop(240) = {33,34,35,36};
Plane Surface(241) = {240};
Transfinite Surface {241} = {26,27,28,29};
Recombine Surface {241};


Line Loop(242) = {57,49,-13,14};
Plane Surface(243) = {242};
Transfinite Surface {243} = {37,30,2,13};
Recombine Surface {243};

Line Loop(244) = {16,3,58,-15};
Plane Surface(245) = {244};
Transfinite Surface {245} = {14,3,31,34};
Recombine Surface {245};

Line Loop(246) = {15,59,-17,-22};
Plane Surface(247) = {246};
Transfinite Surface {247} = {14,34,35,15};
Recombine Surface {247};

Line Loop(248) = {17,60,51,-18};
Plane Surface(249) = {248};
Transfinite Surface {249} = {15,35,32,8};
Recombine Surface {249};

Line Loop(250) = {19,9,61,-20};
Plane Surface(251) = {250};
Transfinite Surface {251} = {16,9,33,36};
Recombine Surface {251};

Line Loop(252) = {20,62,-14,-24};
Plane Surface(253) = {252};
Transfinite Surface {253} = {16,36,37,13};
Recombine Surface {253};



//Inlet-side section connected to injector modules
i=0.02032; 
slices1=20.32*b;

Extrude Surface {243, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {245, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {247, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};

Extrude Surface {249, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {251, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {253, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};



//INJECTOR modules near INLET section

Point(40) = {0.025,0.014,0.05,refin};//INJECTOR 1

Point(41) = {0.0227514,0.0117514,0.05,refin};//outer circle
Point(42) = {0.0227517,0.0162486,0.05,refin};
Point(44) = {0.0272486,0.0162486,0.05,refin};
Point(45) = {0.0272486,0.0117514,0.05,refin};

Point(46) = {0.0230908,0.0120908,0.05,refin};//inner circle
Point(50) = {0.0230908,0.0159092,0.05,refin};
Point(51) = {0.0269092,0.0159092,0.05,refin};
Point(52) = {0.0269092,0.0120908,0.05,refin};

Point(54) = {0.025,0.036,0.05,refin};//INJECTOR 2

Point(55) = {0.0227514,0.0337514,0.05,refin};
Point(56) = {0.0227517,0.0382486,0.05,refin};
Point(58) = {0.0272486,0.0382486,0.05,refin};
Point(59) = {0.0272486,0.0337514,0.05,refin};

Point(60) = {0.0230908,0.0340908,0.05,refin};
Point(61) = {0.0230908,0.0379092,0.05,refin};
Point(62) = {0.0269092,0.0379092,0.05,refin};
Point(64) = {0.0269092,0.0340908,0.05,refin};


Point(65) = {0.02968,0.00932,0.05,refin};//outer square
Point(66) = {0.02968,0.01868,0.05,refin};

Point(68) = {0.02968,0.03132,0.05,refin};
Point(69) = {0.02968,0.04068,0.05,refin};

Point(70) = {0.0240908,0.0130908,0.05,refin};//inner square
Point(71) = {0.0240908,0.0149092,0.05,refin};
Point(72) = {0.0259092,0.0149092,0.05,refin};
Point(74) = {0.0259092,0.0130908,0.05,refin};

Point(75) = {0.0240908,0.0350908,0.05,refin};
Point(76) = {0.0240908,0.0369092,0.05,refin};
Point(80) = {0.0259092,0.0369092,0.05,refin};
Point(81) = {0.0259092,0.0350908,0.05,refin};


Line(63) = {79,66};//outer square lines
Line(64) = {66,65};
Line(65) = {65,83};

Line(66) = {73,69};
Line(67) = {69,68};
Line(68) = {68,77};

Circle(69)={41,40,42};//injector rings
Circle(70)={42,40,44};
Circle(71)={44,40,45};
Circle(72)={45,40,41};
Circle(73)={46,40,50};
Circle(74)={50,40,51};
Circle(75)={51,40,52};
Circle(76)={52,40,46};

Circle(77)={55,54,56};
Circle(78)={56,54,58};
Circle(79)={58,54,59};
Circle(80)={59,54,55};
Circle(81)={60,54,61};
Circle(82)={61,54,62};
Circle(83)={62,54,64};
Circle(84)={64,54,60};

Line(85) = {70,71};//inner square lines
Line(86) = {71,72};
Line(87) = {72,74};
Line(88) = {74,70};

Line(89) = {75,76};
Line(90) = {76,80};
Line(91) = {80,81};
Line(92) = {81,75};

Line(93) = {75,60};//diagonal connecting lines
Line(94) = {76,61};
Line(95) = {80,62};
Line(96) = {81,64};
Line(97) = {60,55};
Line(98) = {61,56};
Line(99) = {62,58};
Line(100) = {64,59};
Line(101) = {55,77};
Line(102) = {56,73};
Line(103) = {58,69};
Line(104) = {59,68};

Line(105) = {70,46};
Line(106) = {71,50};
Line(107) = {72,51};
Line(108) = {74,52};
Line(109) = {46,41};
Line(110) = {50,42};
Line(111) = {51,44};
Line(112) = {52,45};
Line(113) = {41,83};
Line(114) = {42,79};
Line(115) = {44,66};
Line(116) = {45,65};



//INJECTOR 1

Transfinite Line {-344,69} = 9.36*a Using Progression 1.0;
Transfinite Line {69,73} = 9.36*a Using Progression 1.0;
Transfinite Line {73,85} = 9.36*a Using Progression 1.0;

Transfinite Line {63,70} = 9.36*b Using Progression 1.0;
Transfinite Line {70,74} = 9.36*b Using Progression 1.0;
Transfinite Line {74,86} = 9.36*b Using Progression 1.0;

Transfinite Line {64,71} = 9.36*a Using Progression 1.0;
Transfinite Line {71,75} = 9.36*a Using Progression 1.0;
Transfinite Line {75,87} = 9.36*a Using Progression 1.0;

Transfinite Line {65,72} = 9.36*b Using Progression 1.0;
Transfinite Line {72,76} = 9.36*b Using Progression 1.0;
Transfinite Line {76,88} = 9.36*b Using Progression 1.0;

Transfinite Line {113,114,115,116} = 4*y Using Progression 1.2;
Transfinite Line {109,110,111,112} = 3*y Using Progression 1.0;
Transfinite Line {105,106,107,108} = 4*y Using Progression 0.8;


Line Loop(254) = {-344,-114,-69,113};
Plane Surface(255) = {254};
Transfinite Surface {255} = {83,79,42,41};
Recombine Surface {255};

Line Loop(256) = {63,-115,-70,114};
Plane Surface(257) = {256};
Transfinite Surface {257} = {79,66,44,42};
Recombine Surface {257};

Line Loop(258) = {64,-116,-71,115};
Plane Surface(259) = {258};
Transfinite Surface {259} = {66,65,45,44};
Recombine Surface {259};

Line Loop(260) = {65,-113,-72,116};
Plane Surface(261) = {260};
Transfinite Surface {261} = {65,83,41,45};
Recombine Surface {261};


Line Loop(262) = {69,-110,-73,109};
Plane Surface(263) = {262};
Transfinite Surface {263} = {41,42,50,46};
Recombine Surface {263};

Line Loop(264) = {70,-111,-74,110};
Plane Surface(265) = {264};
Transfinite Surface {265} = {42,44,51,50};
Recombine Surface {265};

Line Loop(266) = {71,-112,-75,111};
Plane Surface(267) = {266};
Transfinite Surface {267} = {44,45,52,51};
Recombine Surface {267};

Line Loop(268) = {72,-109,-76,112};
Plane Surface(269) = {268};
Transfinite Surface {269} = {45,41,46,52};
Recombine Surface {269};


Line Loop(270) = {73,-106,-85,105};
Plane Surface(271) = {270};
Transfinite Surface {271} = {46,50,71,70};
Recombine Surface {271};

Line Loop(272) = {74,-107,-86,106};
Plane Surface(273) = {272};
Transfinite Surface {273} = {50,51,72,71};
Recombine Surface {273};

Line Loop(276) = {75,-108,-87,107};
Plane Surface(277) = {276};
Transfinite Surface {277} = {51,52,74,72};
Recombine Surface {277};

Line Loop(278) = {76,-105,-88,108};
Plane Surface(279) = {278};
Transfinite Surface {279} = {52,46,70,74};
Recombine Surface {279};


Line Loop(280) = {85,86,87,88};
Plane Surface(281) = {280};
Transfinite Surface {281} = {70,71,72,74};
Recombine Surface {281};



//INJECTOR 2

Transfinite Line {-323,77} = 9.36*a Using Progression 1.0;
Transfinite Line {77,81} = 9.36*a Using Progression 1.0;
Transfinite Line {81,89} = 9.36*a Using Progression 1.0;

Transfinite Line {66,78} = 9.36*b Using Progression 1.0;
Transfinite Line {78,82} = 9.36*b Using Progression 1.0;
Transfinite Line {82,90} = 9.36*b Using Progression 1.0;

Transfinite Line {67,79} = 9.36*a Using Progression 1.0;
Transfinite Line {79,83} = 9.36*a Using Progression 1.0;
Transfinite Line {83,91} = 9.36*a Using Progression 1.0;

Transfinite Line {68,80} = 9.36*b Using Progression 1.0;
Transfinite Line {80,84} = 9.36*b Using Progression 1.0;
Transfinite Line {84,92} = 9.36*b Using Progression 1.0;

Transfinite Line {101,102,103,104} = 4*y Using Progression 1.2;
Transfinite Line {97,98,99,100} = 3*y Using Progression 1.0;
Transfinite Line {93,94,95,96} = 4*y Using Progression 0.8;


Line Loop(282) = {-323,-102,-77,101};
Plane Surface(283) = {282};
Transfinite Surface {283} = {77,73,56,55};
Recombine Surface {283};

Line Loop(284) = {66,-103,-78,102};
Plane Surface(285) = {284};
Transfinite Surface {285} = {73,69,58,56};
Recombine Surface {285};

Line Loop(286) = {67,-104,-79,103};
Plane Surface(287) = {286};
Transfinite Surface {287} = {69,68,59,58};
Recombine Surface {287};

Line Loop(288) = {68,-101,-80,104};
Plane Surface(289) = {288};
Transfinite Surface {289} = {68,77,55,59};
Recombine Surface {289};


Line Loop(290) = {77,-98,-81,97};
Plane Surface(291) = {290};
Transfinite Surface {291} = {55,56,61,60};
Recombine Surface {291};

Line Loop(292) = {78,-99,-82,98};
Plane Surface(293) = {292};
Transfinite Surface {293} = {56,58,62,61};
Recombine Surface {293};

Line Loop(294) = {79,-100,-83,99};
Plane Surface(295) = {294};
Transfinite Surface {295} = {58,59,64,62};
Recombine Surface {295};

Line Loop(298) = {80,-97,-84,100};
Plane Surface(299) = {298};
Transfinite Surface {299} = {59,55,60,64};
Recombine Surface {299};


Line Loop(300) = {81,-94,-89,93};
Plane Surface(301) = {300};
Transfinite Surface {301} = {60,61,76,75};
Recombine Surface {301};

Line Loop(302) = {82,-95,-90,94};
Plane Surface(303) = {302};
Transfinite Surface {303} = {61,62,80,76};
Recombine Surface {303};

Line Loop(306) = {83,-96,-91,95};
Plane Surface(307) = {306};
Transfinite Surface {307} = {62,64,81,80};
Recombine Surface {307};

Line Loop(308) = {84,-93,-92,96};
Plane Surface(309) = {308};
Transfinite Surface {309} = {64,60,75,81};
Recombine Surface {309};


Line Loop(310) = {89,90,91,92};
Plane Surface(311) = {310};
Transfinite Surface {311} = {75,76,80,81};
Recombine Surface {311};


//INJECTOR modules near OUTLET section

Point(82) = {0.075,0.014,0.05,refin};//INJECTOR 3

Point(84) = {0.0727514,0.0117514,0.05,refin};//outer circle
Point(85) = {0.0727517,0.0162486,0.05,refin};
Point(86) = {0.0772486,0.0162486,0.05,refin};
Point(88) = {0.0772486,0.0117514,0.05,refin};

Point(89) = {0.0730908,0.0120908,0.05,refin};//inner circle
Point(90) = {0.0730908,0.0159092,0.05,refin};
Point(91) = {0.0769092,0.0159092,0.05,refin};
Point(92) = {0.0769092,0.0120908,0.05,refin};

Point(93) = {0.075,0.036,0.05,refin};//INJECTOR 4

Point(94) = {0.0727514,0.0337514,0.05,refin};
Point(95) = {0.0727517,0.0382486,0.05,refin};
Point(96) = {0.0772486,0.0382486,0.05,refin};
Point(97) = {0.0772486,0.0337514,0.05,refin};

Point(98) = {0.0730908,0.0340908,0.05,refin};
Point(99) = {0.0730908,0.0379092,0.05,refin};
Point(100) = {0.0769092,0.0379092,0.05,refin};
Point(101) = {0.0769092,0.0340908,0.05,refin};


Point(102) = {0.07032,0.00932,0.05,refin};//outer square
Point(103) = {0.07032,0.01868,0.05,refin};
Point(104) = {0.07968,0.01868,0.05,refin};
Point(105) = {0.07968,0.00932,0.05,refin};

Point(106) = {0.07032,0.03132,0.05,refin};
Point(107) = {0.07032,0.04068,0.05,refin};
Point(108) = {0.07968,0.04068,0.05,refin};
Point(109) = {0.07968,0.03132,0.05,refin};


Point(110) = {0.0740908,0.0130908,0.05,refin};//inner square
Point(111) = {0.0740908,0.0149092,0.05,refin};
Point(112) = {0.0759092,0.0149092,0.05,refin};
Point(113) = {0.0759092,0.0130908,0.05,refin};

Point(114) = {0.0740908,0.0350908,0.05,refin};
Point(115) = {0.0740908,0.0369092,0.05,refin};
Point(116) = {0.0759092,0.0369092,0.05,refin};
Point(117) = {0.0759092,0.0350908,0.05,refin};


Line(117) = {103,102};//outer square lines
Line(118) = {103,104};
Line(119) = {104,105};
Line(120) = {105,102};

Line(121) = {107,106};
Line(122) = {107,108};
Line(123) = {108,109};
Line(124) = {109,106};

Circle(125)={84,82,85};//injector rings
Circle(126)={85,82,86};
Circle(127)={86,82,88};
Circle(128)={88,82,84};
Circle(129)={89,82,90};
Circle(130)={90,82,91};
Circle(131)={91,82,92};
Circle(132)={92,82,89};

Circle(133)={94,93,95};
Circle(134)={95,93,96};
Circle(135)={96,93,97};
Circle(136)={97,93,94};
Circle(137)={98,93,99};
Circle(138)={99,93,100};
Circle(139)={100,93,101};
Circle(140)={101,93,98};

Line(141) = {110,111};//inner square lines
Line(142) = {111,112};
Line(143) = {112,113};
Line(144) = {113,110};

Line(145) = {114,115};
Line(146) = {115,116};
Line(147) = {116,117};
Line(148) = {117,114};

Line(149) = {114,98};//diagonal connecting lines
Line(150) = {115,99};
Line(151) = {116,100};
Line(152) = {117,101};
Line(153) = {98,94};
Line(154) = {99,95};
Line(155) = {100,96};
Line(156) = {101,97};
Line(157) = {94,106};
Line(158) = {95,107};
Line(159) = {96,108};
Line(160) = {97,109};

Line(161) = {110,89};
Line(162) = {111,90};
Line(163) = {112,91};
Line(164) = {113,92};
Line(165) = {89,84};
Line(166) = {90,85};
Line(167) = {91,86};
Line(168) = {92,88};
Line(169) = {84,102};
Line(170) = {85,103};
Line(171) = {86,104};
Line(172) = {88,105};



//INJECTOR 3

Transfinite Line {-117,125} = 9.36*a Using Progression 1.0;
Transfinite Line {125,129} = 9.36*a Using Progression 1.0;
Transfinite Line {129,141} = 9.36*a Using Progression 1.0;

Transfinite Line {118,126} = 9.36*b Using Progression 1.0;
Transfinite Line {126,130} = 9.36*b Using Progression 1.0;
Transfinite Line {130,142} = 9.36*b Using Progression 1.0;

Transfinite Line {119,127} = 9.36*a Using Progression 1.0;
Transfinite Line {127,131} = 9.36*a Using Progression 1.0;
Transfinite Line {131,143} = 9.36*a Using Progression 1.0;

Transfinite Line {120,128} = 9.36*b Using Progression 1.0;
Transfinite Line {128,132} = 9.36*b Using Progression 1.0;
Transfinite Line {132,144} = 9.36*b Using Progression 1.0;

Transfinite Line {169,170,171,172} = 4*y Using Progression 1.2;
Transfinite Line {165,166,167,168} = 3*y Using Progression 1.0;
Transfinite Line {161,162,163,164} = 4*y Using Progression 0.8;


Line Loop(312) = {-117,-170,-125,169};
Plane Surface(313) = {312};
Transfinite Surface {313} = {102,103,85,84};
Recombine Surface {313};

Line Loop(314) = {118,-171,-126,170};
Plane Surface(315) = {314};
Transfinite Surface {315} = {103,104,86,85};
Recombine Surface {315};

Line Loop(316) = {119,-172,-127,171};
Plane Surface(317) = {316};
Transfinite Surface {317} = {104,105,88,86};
Recombine Surface {317};

Line Loop(320) = {120,-169,-128,172};
Plane Surface(321) = {320};
Transfinite Surface {321} = {105,102,84,88};
Recombine Surface {321};


Line Loop(322) = {125,-166,-129,165};
Plane Surface(323) = {322};
Transfinite Surface {323} = {84,85,90,89};
Recombine Surface {323};

Line Loop(324) = {126,-167,-130,166};
Plane Surface(325) = {324};
Transfinite Surface {325} = {85,86,91,90};
Recombine Surface {325};

Line Loop(326) = {127,-168,-131,167};
Plane Surface(327) = {326};
Transfinite Surface {327} = {86,88,92,91};
Recombine Surface {327};

Line Loop(328) = {128,-165,-132,168};
Plane Surface(329) = {328};
Transfinite Surface {329} = {88,84,89,92};
Recombine Surface {329};


Line Loop(330) = {129,-162,-141,161};
Plane Surface(331) = {330};
Transfinite Surface {331} = {89,90,111,110};
Recombine Surface {331};

Line Loop(332) = {130,-163,-142,162};
Plane Surface(333) = {332};
Transfinite Surface {333} = {90,91,112,111};
Recombine Surface {333};

Line Loop(334) = {131,-164,-143,163};
Plane Surface(335) = {334};
Transfinite Surface {335} = {91,92,113,112};
Recombine Surface {335};

Line Loop(336) = {132,-161,-144,164};
Plane Surface(337) = {336};
Transfinite Surface {337} = {92,89,110,113};
Recombine Surface {337};


Line Loop(338) = {141,142,143,144};
Plane Surface(339) = {338};
Transfinite Surface {339} = {110,111,112,113};
Recombine Surface {339};



//INJECTOR 4

Transfinite Line {-121,133} = 9.36*a Using Progression 1.0;
Transfinite Line {133,137} = 9.36*a Using Progression 1.0;
Transfinite Line {137,145} = 9.36*a Using Progression 1.0;

Transfinite Line {122,134} = 9.36*b Using Progression 1.0;
Transfinite Line {134,138} = 9.36*b Using Progression 1.0;
Transfinite Line {138,146} = 9.36*b Using Progression 1.0;

Transfinite Line {123,135} = 9.36*a Using Progression 1.0;
Transfinite Line {135,139} = 9.36*a Using Progression 1.0;
Transfinite Line {139,147} = 9.36*a Using Progression 1.0;

Transfinite Line {124,136} = 9.36*b Using Progression 1.0;
Transfinite Line {136,140} = 9.36*b Using Progression 1.0;
Transfinite Line {140,148} = 9.36*b Using Progression 1.0;

Transfinite Line {157,158,159,160} = 4*y Using Progression 1.2;
Transfinite Line {153,154,155,156} = 3*y Using Progression 1.0;
Transfinite Line {149,150,151,152} = 4*y Using Progression 0.8;


Line Loop(342) = {-121,-158,-133,157};
Plane Surface(343) = {342};
Transfinite Surface {343} = {106,107,95,94};
Recombine Surface {343};

Line Loop(344) = {122,-159,-134,158};
Plane Surface(345) = {344};
Transfinite Surface {345} = {107,108,96,95};
Recombine Surface {345};

Line Loop(346) = {123,-160,-135,159};
Plane Surface(347) = {346};
Transfinite Surface {347} = {108,109,97,96};
Recombine Surface {347};

Line Loop(348) = {124,-157,-136,160};
Plane Surface(349) = {348};
Transfinite Surface {349} = {109,106,94,97};
Recombine Surface {349};


Line Loop(350) = {133,-154,-137,153};
Plane Surface(351) = {350};
Transfinite Surface {351} = {94,95,99,98};
Recombine Surface {351};

Line Loop(352) = {134,-155,-138,154};
Plane Surface(353) = {352};
Transfinite Surface {353} = {95,96,100,99};
Recombine Surface {353};

Line Loop(354) = {135,-156,-139,155};
Plane Surface(355) = {354};
Transfinite Surface {355} = {96,97,101,100};
Recombine Surface {355};

Line Loop(356) = {136,-153,-140,156};
Plane Surface(357) = {356};
Transfinite Surface {357} = {97,94,98,101};
Recombine Surface {357};


Line Loop(358) = {137,-150,-145,149};
Plane Surface(359) = {358};
Transfinite Surface {359} = {98,99,115,114};
Recombine Surface {359};

Line Loop(360) = {138,-151,-146,150};
Plane Surface(361) = {360};
Transfinite Surface {361} = {99,100,116,115};
Recombine Surface {361};

Line Loop(364) = {139,-152,-147,151};
Plane Surface(365) = {364};
Transfinite Surface {365} = {100,101,117,116};
Recombine Surface {365};

Line Loop(366) = {140,-149,-148,152};
Plane Surface(367) = {366};
Transfinite Surface {367} = {101,98,114,117};
Recombine Surface {367};

Line Loop(368) = {145,146,147,148};
Plane Surface(369) = {368};
Transfinite Surface {369} = {114,115,116,117};
Recombine Surface {369};



//Extrude INJECTOR modules
i=-0.01868; //peripheral section, z-direction
slices2i=(18.68*a)-1;

j=-0.01264; //middle section, z-direction
slices2j=(12.64*a)-1;

Extrude Surface {255, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};//INJECTOR 1
Extrude Surface {257, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {259, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {261, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {263, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {265, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {267, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {269, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {271, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {273, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {277, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {279, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {281, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};

Extrude Surface {407, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {473, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {451, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {429, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {495, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {561, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {539, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {517, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {583, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {649, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {627, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {605, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {671, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};

Extrude Surface {693, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {715, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {737, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {759, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {781, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {803, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {825, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {847, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {869, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {891, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {913, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {935, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {957, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};


Extrude Surface {283, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};//INJECTOR 2
Extrude Surface {285, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {287, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {289, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {291, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {293, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {295, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {299, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {301, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {303, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {307, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {309, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {311, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};

Extrude Surface {1265, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1331, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1309, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1287, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1353, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1419, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1397, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1375, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1441, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1507, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1485, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1463, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {1529, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};

Extrude Surface {1551, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1573, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1595, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1617, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1639, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1661, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1683, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1705, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1727, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1749, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1771, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1793, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {1815, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};


Extrude Surface {313, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};//INJECTOR 3
Extrude Surface {315, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {317, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {321, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {323, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {325, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {327, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {329, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {331, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {333, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {335, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {337, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {339, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};

Extrude Surface {2123, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2145, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2167, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2189, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2211, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2233, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2255, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2277, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2299, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2321, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2343, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2365, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {2387, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};

Extrude Surface {2409, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2431, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2453, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2475, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2497, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2519, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2541, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2563, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2585, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2607, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2629, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2651, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {2673, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};


Extrude Surface {343, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};//INJECTOR 4
Extrude Surface {345, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {347, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {349, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {351, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {353, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {355, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {357, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {359, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {361, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {365, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {367, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {369, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};

Extrude Surface {2981, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3003, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3025, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3047, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3069, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3091, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3113, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3135, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3157, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3179, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3201, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3223, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};
Extrude Surface {3245, {0.0,0.0,j}}{Layers{slices2j,1};Recombine;};

Extrude Surface {3267, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3289, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3311, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3333, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3355, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3377, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3399, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3421, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3443, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3465, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3487, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3509, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};
Extrude Surface {3531, {0.0,0.0,i}}{Layers{slices2i,1};Recombine;};


//Mid sections between INJECTOR blocks
i=0.04064; 
slices3=40.64*b;

Extrude Surface {438, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {724, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {1010, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};

Extrude Surface {1296, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {1582, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {1868, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};



//Outlet section connected to injector modules
i=0.02032; 
slices1=20.32*b;
Extrude Surface {2154, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {2440, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {2726, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};

Extrude Surface {3012, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {3298, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {3584, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};



//Remaining peripheral and mid sections connecting Inlet and Outlet ends

Extrude Surface {201, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {209, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {215, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};

Extrude Surface {203, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {217, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};//INLET block
Extrude Surface {219, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {221, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {223, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {225, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {227, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {229, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {231, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {233, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {235, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {237, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {239, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {241, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {213, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};

Extrude Surface {205, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {207, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {211, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};

i=0.00936;
slices4=(9.36*b)-1;

Extrude Surface {4097, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4119, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4141, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};

Extrude Surface {4163, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4185, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4251, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4229, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4207, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4273, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4339, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4317, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4295, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4361, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4427, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4405, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4383, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4449, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4471, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};

Extrude Surface {4493, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4515, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {4537, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};

i=0.04064; 

Extrude Surface {4559, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4581, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4603, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};

Extrude Surface {4625, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4647, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4669, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4691, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4713, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4735, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4757, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4779, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4801, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4823, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4845, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4867, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4889, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4911, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4933, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};

Extrude Surface {4955, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4977, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};
Extrude Surface {4999, {i,0.0,0.0}}{Layers{slices3,1};Recombine;};

i=0.00936;
slices4=(9.36*b)-1;

Extrude Surface {5021, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5043, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5065, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};

Extrude Surface {5087, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5109, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5131, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5153, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5175, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5197, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5219, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5241, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5263, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5285, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5307, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5329, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5351, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5373, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5395, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};

Extrude Surface {5417, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5439, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};
Extrude Surface {5461, {i,0.0,0.0}}{Layers{slices4,1};Recombine;};

i=0.02032; 
slices1=20.32*b;

Extrude Surface {5483, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5505, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5527, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};

Extrude Surface {5549, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5571, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};//OUTLET block
Extrude Surface {5593, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5615, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5637, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5659, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5681, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5703, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5725, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5747, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5769, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5791, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5813, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5835, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5857, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};

Extrude Surface {5879, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5901, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};
Extrude Surface {5923, {i,0.0,0.0}}{Layers{slices1,1};Recombine;};



//CHAMBER TUBES

Inlet_Length=-0.118;
Outlet_Length=0.168;
slices=118*3;//236;
slicesx=168*3;//336;

Extrude Surface {225, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};
Extrude Surface {227, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};
Extrude Surface {229, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};
Extrude Surface {231, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};
Extrude Surface {233, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};
Extrude Surface {235, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};
Extrude Surface {237, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};
Extrude Surface {239, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};
Extrude Surface {241, {Inlet_Length,0.0,0.0}}{Layers{slices,1};Recombine;};

Extrude Surface {6121, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};
Extrude Surface {6143, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};
Extrude Surface {6165, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};
Extrude Surface {6187, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};
Extrude Surface {6209, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};
Extrude Surface {6231, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};
Extrude Surface {6253, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};
Extrude Surface {6275, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};
Extrude Surface {6297, {Outlet_Length,0.0,0.0}}{Layers{slicesx,1};Recombine;};



//INLET & OUTLET TUBES

Inlet_Length=-0.110;
Outlet_Length=0.110;
slicest=110*3;


Extrude Surface {6495, {Inlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};
Extrude Surface {6517, {Inlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};
Extrude Surface {6539, {Inlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};
Extrude Surface {6561, {Inlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};
Extrude Surface {6583, {Inlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};


Extrude Surface {6693, {Outlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};
Extrude Surface {6759, {Outlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};
Extrude Surface {6737, {Outlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};
Extrude Surface {6715, {Outlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};
Extrude Surface {6781, {Outlet_Length,0.0,0.0}}{Layers{slicest,1};Recombine;};



Physical Surface("inlet") = {6803,6825,6847,6869,6891}; //inlet
Physical Surface("injector1") = {263,265,267,269}; //injector ring 1
Physical Surface("injector2") = {291,293,295,299}; //injector ring 2
Physical Surface("injector3") = {323,325,327,329}; //injector ring 3
Physical Surface("injector4") = {351,353,355,357}; //injector ring 4
Physical Surface("outlet") = {6913,6935,6957,6979,7001}; //outlet

Physical Surface("wall") = {6790,6812,6834,6856,6407,6429,6451,6473,6394,6416,6438,6460,201,243,203,245,205,207,247,253,209,211,
249,213,251,215,217,219,221,223,4484,4506,4524,4946,4968,4986,5408,5430,5448,5870,5892,5910,6332,6354
,6372,4096,4106,4132,4558,4568,4594,5020,5030,5056,5482,5492,5518,5944,5954,5980,4084,4546,5008,5470,
5932,1001,1089,1177,266,2761,979,1067,1155,1243,1199,1111,1023,2849,2937,3876,1221,2695,1133,2783,
2871,2959,2915,2827,2739,4004,1045,2893,2805,2717,4154,4616,5078,5540,6002,288,1859,1947,2035,2079,
1991,1903,3939,3619,3707,3795,3751,3663,3575,4070,1837,1925,2013,2101,2057,1969,1881,3553,3641,3729,
3817,3773,3685,3597,4480,4942,5404,5866,6328,6341,6363,6385,4075,4053,4031,4009,3987,3965,5945,5967,
5989,6319,6011,6077,6099,6033,6055,6658,6592,6614,6636,6671,6605,6627,6649,6900,6922,6944,6966,5976,
5514,5052,4590,4128,3952,3826,354,6310,5848,5386,4924,4462,4018,3889,336,6376,5914,5452,4990,4528,255
,257,259,261,271,273,277,279,281,283,285,287,289,301,303,307,309,311,313,315,317,321,331,333,335,337,
339,343,345,347,349,359,361,365,367,369};
//walls including injector blocks (towards the end)


Physical Volume(1) = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,
37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,
70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,
101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,
121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,
141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,
181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,
201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,
221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,
241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,
261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,
281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,
301,302,303,304,305,306,307};

/*Hide "*";
Show {
Point{13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29};
Line{21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48};
Surface{217,219,221,223,225,227,229,231,233,235,237,239,241};
}*/

