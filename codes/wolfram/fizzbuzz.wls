Print["\n(* FizzBuzz(n) in Wolfram *)"];

FizzbuzzV1 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        ANumber = 1;
        While[(True),
            If[(Result == ""),
                Result = ToString[ANumber];
                If[(ANumber >= StopNumber), Break[]];
                ANumber += 1;
                Continue[];
            ];
            If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)),
                Result = StringJoin[Result, ", FizzBuzz"];
                If[(ANumber >= StopNumber), Break[]];
                ANumber += 1;
                Continue[];
            ];
            If[(Mod[ANumber, 3] == 0),
                Result = StringJoin[Result, ", Fizz"];
                If[(ANumber >= StopNumber), Break[]];
                ANumber += 1;
                Continue[];
            ];
            If[(Mod[ANumber, 5] == 0),
                Result = StringJoin[Result, ", Buzz"];
                If[(ANumber >= StopNumber), Break[]];
                ANumber += 1;
                Continue[];
            ];
            Result = StringJoin[Result, ", ", ToString[ANumber]];
            If[(ANumber >= StopNumber), Break[]];
            ANumber += 1;
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV2 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        ANumber = 1;
        While[(ANumber <= StopNumber),
            If[(Result == ""),
                Result = ToString[ANumber];
                ANumber += 1;
                Continue[];
            ];
            If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)),
                Result = StringJoin[Result, ", FizzBuzz"];
                ANumber += 1;
                Continue[];
            ];
            If[(Mod[ANumber, 3] == 0),
                Result = StringJoin[Result, ", Fizz"];
                ANumber += 1;
                Continue[];
            ];
            If[(Mod[ANumber, 5] == 0),
                Result = StringJoin[Result, ", Buzz"];
                ANumber += 1;
                Continue[];
            ];
            Result = StringJoin[Result, ", ", ToString[ANumber]];
            ANumber += 1;
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV3 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        ANumber = 1;
        While[(True),
            Result = If[(Result == ""),
                ToString[ANumber],
                If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)),
                    StringJoin[Result, ", FizzBuzz"],
                    If[(Mod[ANumber, 3] == 0),
                        StringJoin[Result, ", Fizz"],
                        If[(Mod[ANumber, 5] == 0),
                            StringJoin[Result, ", Buzz"],
                            StringJoin[Result, ", ", ToString[ANumber]]
                        ]
                    ]
                ]
            ];
            If[(ANumber >= StopNumber), Break[]];
            ANumber += 1;
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV4 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        ANumber = 1;
        While[(ANumber <= StopNumber),
            Result = If[(Result == ""),
                ToString[ANumber],
                If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)),
                    StringJoin[Result, ", FizzBuzz"],
                    If[(Mod[ANumber, 3] == 0),
                        StringJoin[Result, ", Fizz"],
                        If[(Mod[ANumber, 5] == 0),
                            StringJoin[Result, ", Buzz"],
                            StringJoin[Result, ", ", ToString[ANumber]]
                        ]
                    ]
                ]
            ];
            ANumber += 1;
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV5 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        ANumber = 1;
        While[(True),
            Result = If[(Result == ""), ToString[ANumber], If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)), StringJoin[Result, ", FizzBuzz"], If[(Mod[ANumber, 3] == 0), StringJoin[Result, ", Fizz"], If[(Mod[ANumber, 5] == 0), StringJoin[Result, ", Buzz"], StringJoin[Result, ", ", ToString[ANumber]]]]]];
            If[(ANumber >= StopNumber), Break[]];
            ANumber += 1;
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV6 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        ANumber = 1;
        While[(ANumber <= StopNumber),
            Result = If[(Result == ""), ToString[ANumber], If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)), StringJoin[Result, ", FizzBuzz"], If[(Mod[ANumber, 3] == 0), StringJoin[Result, ", Fizz"], If[(Mod[ANumber, 5] == 0), StringJoin[Result, ", Buzz"], StringJoin[Result, ", ", ToString[ANumber]]]]]];
            ANumber += 1;
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV7 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        For[ANumber = 1, (ANumber <= StopNumber), ANumber += 1,
            If[(Result == ""),
                Result = ToString[ANumber];
                Continue[];
            ];
            If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)),
                Result = StringJoin[Result, ", FizzBuzz"];
                Continue[];
            ];
            If[(Mod[ANumber, 3] == 0),
                Result = StringJoin[Result, ", Fizz"];
                Continue[];
            ];
            If[(Mod[ANumber, 5] == 0),
                Result = StringJoin[Result, ", Buzz"];
                Continue[];
            ];
            Result = StringJoin[Result, ", ", ToString[ANumber]];
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV8 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        For[ANumber = 1, (ANumber <= StopNumber), ANumber += 1,
            Result = If[(Result == ""),
                ToString[ANumber],
                If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)),
                    StringJoin[Result, ", FizzBuzz"],
                    If[(Mod[ANumber, 3] == 0),
                        StringJoin[Result, ", Fizz"],
                        If[(Mod[ANumber, 5] == 0),
                            StringJoin[Result, ", Buzz"],
                            StringJoin[Result, ", ", ToString[ANumber]]
                        ]
                    ]
                ]
            ];
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV9 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        For[ANumber = 1, (ANumber <= StopNumber), ANumber += 1,
            Result = If[(Result == ""), ToString[ANumber], If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)), StringJoin[Result, ", FizzBuzz"], If[(Mod[ANumber, 3] == 0), StringJoin[Result, ", Fizz"], If[(Mod[ANumber, 5] == 0), StringJoin[Result, ", Buzz"], StringJoin[Result, ", ", ToString[ANumber]]]]]];
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV9 = (Module[{StopNumber = #, Result},
    If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"]];
    If[(StopNumber < 1), Throw["Argument should be > 0"]];
    Result = "";
    Module[{ANumber},
        For[ANumber = 1, (ANumber <= StopNumber), ANumber += 1,
            Result = If[(Result == ""), ToString[ANumber], If[((Mod[ANumber, 3] == 0) && (Mod[ANumber, 5] == 0)), StringJoin[Result, ", FizzBuzz"], If[(Mod[ANumber, 3] == 0), StringJoin[Result, ", Fizz"], If[(Mod[ANumber, 5] == 0), StringJoin[Result, ", Buzz"], StringJoin[Result, ", ", ToString[ANumber]]]]]];
        ];
    ];
    Return[Result, Module];
] &);

FizzbuzzV10 = (Module[{StopNumber = #, Result}, If[(NumericQ[StopNumber] == False), Throw["Argument should be a number"], If[(StopNumber < 1), Throw["Argument should be > 0"], Return[Fold[(Module[{CurrentResult = #1, CurrentNumber = #2}, If[(CurrentResult == ""), ToString[CurrentNumber], If[((Mod[CurrentNumber, 3] == 0) && (Mod[CurrentNumber, 5] == 0)), StringJoin[CurrentResult, ", FizzBuzz"], If[(Mod[CurrentNumber, 3] == 0), StringJoin[CurrentResult, ", Fizz"], If[(Mod[CurrentNumber, 5] == 0), StringJoin[CurrentResult, ", Buzz"], StringJoin[CurrentResult, ", ", ToString[CurrentNumber]]]]]]] &), "", Range[1, StopNumber, 1]], Module]]]] &);

Print["(* using fizzbuzz function \"FizzbuzzV1\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV1[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV2\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV2[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV3\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV3[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV4\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV4[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV5\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV5[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV6\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV6[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV7\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV7[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV8\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV8[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV9\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV9[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)

Print["(* using fizzbuzz function \"FizzbuzzV10\" *)"];
Print["FizzBuzz(36): ", FizzbuzzV10[36]];
(* FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz *)
