Print["\n(* Factorial(n) in Wolfram *)"];

FactorialV1 = (Module[{ANumber = #, Result},
    If[(NumericQ[ANumber] == False), Throw["Argument should be a number"]];
    If[(ANumber < 0), Throw["Argument should be >= 0"]];
    If[(ANumber == 0), Return[1, Module]];
    Result = 1;
    Module[{J},
        J = ANumber;
        While[(True),
            Result *= J;
            If[J <= 1, Break[]];
            J -= 1;
        ];
    ];
    Return[Result, Module];
] &);

FactorialV2 = (Module[{ANumber = #, Result},
    If[(NumericQ[ANumber] == False), Throw["Argument should be a number"]];
    If[(ANumber < 0), Throw["Argument should be >= 0"]];
    If[(ANumber == 0), Return[1, Module]];
    Result = 1;
    Module[{J},
        J = ANumber;
        While[(J >= 1),
            Result *= J;
            J -= 1;
        ];
    ];
    Return[Result, Module];
] &);

FactorialV3 = (Module[{ANumber = #, Result},
    If[(NumericQ[ANumber] == False), Throw["Argument should be a number"]];
    If[(ANumber < 0), Throw["Argument should be >= 0"]];
    If[(ANumber == 0), Return[1, Module]];
    Result = 1;
    Module[{J},
        For[J = ANumber, (J >= 1), J -= 1,
            Result *= J;
        ];
    ];
    Return[Result, Module];
] &);

FactorialV4 = (Module[{ANumber = #, Result},
    If[(NumericQ[ANumber] == False), Throw["Argument should be a number"]];
    If[(ANumber < 0), Throw["Argument should be >= 0"]];
    If[(ANumber == 0), Return[1, Module]];
    Return[ANumber * FactorialV4[(ANumber - 1)], Module];
] &);

FactorialV5 = (Module[{ANumber = #, Result}, If[(NumericQ[ANumber] == False), Throw["Argument should be a number"], If[(ANumber < 0), Throw["Argument should be >= 0"], If[(ANumber == 0), Return[1, Module], Return[ANumber * FactorialV4[(ANumber - 1)], Module]]]]] &);

Print["(* using factorial function \"FactorialV1\" *)"];
Print["Factorial(5): ", FactorialV1[5]];
(* Factorial(5): 120 *)

Print["(* using factorial function \"FactorialV2\" *)"];
Print["Factorial(5): ", FactorialV2[5]];
(* Factorial(5): 120 *)

Print["(* using factorial function \"FactorialV3\" *)"];
Print["Factorial(5): ", FactorialV3[5]];
(* Factorial(5): 120 *)

Print["(* using factorial function \"FactorialV4\" *)"];
Print["Factorial(5): ", FactorialV4[5]];
(* Factorial(5): 120 *)

Print["(* using factorial function \"FactorialV5\" *)"];
Print["Factorial(5): ", FactorialV5[5]];
(* Factorial(5): 120 *)
