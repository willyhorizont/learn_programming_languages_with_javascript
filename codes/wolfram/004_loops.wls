(* while loop *)

Module[{J},
    J = 1;
    While[(True),
        If[(J == 2),
            If[J >= 5, Break[]];
            J += 1;
            Continue[];
        ];
        Print["while loop v1, J is ", J];
        If[J >= 5, Break[]];
        J += 1;
    ];
];

Module[{J},
    J = 1;
    While[(J <= 5),
        If[(J == 2),
            J += 1;
            Continue[];
        ];
        Print["while loop v2, J is ", J];
        J += 1;
    ];
];

(* for loop *)

Module[{J},
    For[J = 1, (J <= 10), J += 1,
        If[(J > 5), Break[]];
        If[(J == 2), Continue[]];
        Print["for loop, J is ", J];
    ];
];

(* foreach loop *)

Module[{J},
    For[J = 1, (J <= Length[Range[1, 10, 1]]), J += 1,
        If[(J > 5), Break[]];
        If[(J == 2), Continue[]];
        Print["foreach loop v1, J is ", J];
    ];
];

Map[(Module[{J = #},
    If[(J > 5), Return[Null, Module]];
    If[(J == 2), Return[Null, Module]];
    Print["foreach loop v2 ascending, J is ", J];
] &), Range[1, 10, 1]]; (* [start, stop, step] *)

Map[(Module[{J = #},
    If[(J <= 5), Return[Null, Module]];
    If[(J == 9), Return[Null, Module]];
    Print["foreach loop v2 descending, J is ", J];
] &), Range[10, 1, -1]]; (* [start, stop, step] *)
