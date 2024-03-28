For[i = 1, i <= 5, i++,
    Print["Iteration ", i]
]

i = 1;
While[i <= 5,
    Print["Iteration ", i];
    i++
]

doubleItV1[aNumber_] := (
    If[aNumber === 0,
        0,
        aNumber * 2
    ]
)
doubleItV2[aNumber_] := If[aNumber === 0, 0, aNumber * 2]
doubleItV3 = Function[{aNumber},
    If[aNumber === 0, 0, aNumber * 2]
];
doubleItV4 = Function[{RectangleWidth, RectangleLength}, If[aNumber === 0, 0, aNumber * 2]];

GetRectangleAreaV1[RectangleWidth_, RectangleLength_] := (
    Print("Hello");
    Return[(RectangleWidth * RectangleLength)];
);
(* GetRectangleAreaV2 = Function[{RectangleWidth, RectangleLength}, (
    Print("Hello");
    Return[(RectangleWidth * RectangleLength)];
)]; *)
GetRectangleAreaV2 = Function[{RectangleWidth, RectangleLength},
  Module[{Result},
    Result = RectangleWidth * RectangleLength;
    Result
  ]
]
(* GetRectangleAreaV3 = Function[{RectangleWidth, RectangleLength},
  Module[{Something}
    Return[(RectangleWidth * RectangleLength)];
  ]
] *)
GetRectangleAreaV4[RectangleWidth_, RectangleLength_] := (RectangleWidth * RectangleLength);
GetRectangleAreaV5 = Function[{RectangleWidth, RectangleLength}, (RectangleWidth * RectangleLength)];
Print["GetRectangleAreaV1[7, 5]", GetRectangleAreaV1[7, 5]];
Print["GetRectangleAreaV2[7, 5]", GetRectangleAreaV2[7, 5]];
(* Print["GetRectangleAreaV3[7, 5]", GetRectangleAreaV3[7, 5]]; *)
Print["GetRectangleAreaV4[7, 5]", GetRectangleAreaV4[7, 5]];
Print["GetRectangleAreaV5[7, 5]", GetRectangleAreaV5[7, 5]];

(* i = 1;
While[i <= 10,
  If[i == 5, Return[]]; (* Exit the loop if i is 5 *)
  Print[i];
  i++
]

i = 1;
While[i <= 10,
  If[i == 5, i++; Continue[]]; (* Skip iteration if i is 5 *)
  Print[i];
  i++
]

i = 1;
While[True,
  If[i == 5, Break[]]; (* Exit the loop if i is 5 *)
  Print[i];
  i++
] *)
Print["================================="];

i1 = 1;
While[True,
    If[i1 == 2,
        If[i1 >= 5,
            Break[];
        ];
        i1 += 1;
        Continue[];
    ];
    Print["while loop v1, i1 is ", i1];
    If[i1 >= 5,
        Break[];
    ];
    i1 += 1
];

(* For[i2 = 0, i2 < 4, i2++, Print[i2]] *)
For[i2 = 1, i2 <= 5, i2 += 1,
    If[i2 == 2,
        Continue[];
    ];
    Print["for loop, i2 is ", i2];
];
