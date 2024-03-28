doubleItV1[aNumber_] := Module[
    {},
    If[(aNumber == 0),
        Return[0];
    ];
    Return[(aNumber * 2)];
];
doubleItV2[aNumber_] := If[(aNumber == 0), 0, (aNumber * 2)];
doubleItV3 = Function[{aNumber}, Module[
    {},
    If[(aNumber == 0),
        Return[0, Module];
    ];
    Return[(aNumber * 2), Module];
]];
doubleItV4 = Function[{aNumber}, If[(aNumber == 0), 0, (aNumber * 2)]];
doubleItV5 = (Module[
    {aNumber = #},
    If[(aNumber == 0),
        Return[0, Module];
    ];
    Return[(aNumber * 2), Module];
] &);
doubleItV6 = (Module[{aNumber = #}, If[(aNumber == 0), 0, (aNumber * 2)]] &);

Print["doubleItV1[2]: ", doubleItV1[2]];
Print["doubleItV2[2]: ", doubleItV2[2]];
Print["doubleItV3[2]: ", doubleItV3[2]];
Print["doubleItV4[2]: ", doubleItV4[2]];
Print["doubleItV5[2]: ", doubleItV5[2]];
Print["doubleItV6[2]: ", doubleItV6[2]];
Print["doubleItV1[0]: ", doubleItV1[0]];
Print["doubleItV2[0]: ", doubleItV2[0]];
Print["doubleItV3[0]: ", doubleItV3[0]];
Print["doubleItV4[0]: ", doubleItV4[0]];
Print["doubleItV5[0]: ", doubleItV5[0]];
Print["doubleItV6[0]: ", doubleItV6[0]];

(* #^2 & *)

(* getSumV1[numbers___] := Module[
    {sum = 0}, (
    For[aNumberIndex = 1, aNumberIndex <= Length[{numbers}], aNumberIndex += 1,
        sum += numbers[[aNumberIndex]];
    ];
    Return[sum];
)]; *)
getSumV1[numbers___] := Module[
    {sum = 0},
    For[aNumberIndex = 1, aNumberIndex <= Length[{numbers}], aNumberIndex += 1,
        sum += {numbers}[[aNumberIndex]];
    ];
    Return[sum];
];
Print["getSumV1[1, 2, 3, 4]: ", getSumV1[1, 2, 3, 4]];

getSumV2 = Function[{numbers}, Module[
    {sum = 0},
    For[aNumberIndex = 1, aNumberIndex <= Length[numbers], aNumberIndex += 1,
        sum += numbers[[aNumberIndex]];
    ];
    Return[sum, Module];
]];
Print["getSumV2[1, 2, 3, 4]: ", getSumV2[{1, 2, 3, 4}]];

(* getSumV3 = Function[##, Total[{##}]]; *)
getSumV3 = (Plus[##] &);
Print["getSumV3[1, 2, 3, 4]: ", getSumV3[1, 2, 3, 4]];

getSumV4 = (getSumV1[##] &);
Print["getSumV4[1, 2, 3, 4]: ", getSumV4[1, 2, 3, 4]];

getSumV5 = (Module[
    {numbers = ##,
    sum = 0},
    For[aNumberIndex = 1, aNumberIndex <= Length[{numbers}], aNumberIndex += 1,
        sum += {numbers}[[aNumberIndex]];
    ];
    Return[sum, Module];
] &);
Print["getSumV5[1, 2, 3, 4]: ", getSumV5[1, 2, 3, 4]];

something = {1, 2, 3, (Module[
    {numbers = ##,
    sum = 0},
    For[aNumberIndex = 1, aNumberIndex <= Length[{numbers}], aNumberIndex += 1,
        sum += {numbers}[[aNumberIndex]];
    ];
    Return[sum, Module];
] &), 5};
Print["something[[4]][1, 2, 3, 4]: ", something[[4]][1, 2, 3, 4]];

globalSomething = "asd";
Print["globalSomething: ", globalSomething];
doubleItV1[aNumber_] := Module[
    {},
    globalSomething = "zxc";
];
Print["globalSomething: ", globalSomething];
