(* ? function statement or function declaration *)
(* ! this type of function can't have local variable, can't have multiline body *)
GetRectangleAreaV1[RectangleWidth_, RectangleLength_] := (RectangleWidth * RectangleLength);
(* call the function example: GetRectangleAreaV1[7, 5] *)

(* ? function statement or function declaration + "Module" to make it can have local variable and multiline body *)
GetRectangleAreaV2[RectangleWidth_, RectangleLength_] := Module[{},
    Return[(RectangleWidth * RectangleLength)];
];
(* call the function example: GetRectangleAreaV2[7, 5] *)

(* ? function expression using pure function "Function" *)
(* ! this type of function can't be variadic 🤮, can't have local variable, can't have multiline body *)
GetRectangleAreaV3 = Function[{RectangleWidth, RectangleLength}, (RectangleWidth * RectangleLength)];
(* call the function example: GetRectangleAreaV3[7, 5] *)

(* ? function expression using pure function "Function" + "Module" to make it can have local variable and multiline body *)
(* ! this type of function can't be variadic 🤮 *)
GetRectangleAreaV5 = Function[{RectangleWidth, RectangleLength}, Module[{},
    Return[(RectangleWidth * RectangleLength), Module];
]];
(* call the function example: GetRectangleAreaV5[7, 5] *)

(* ? function expression using pure function shorthand notation (() &) *)
(* this type of function can't have local variable, can't have multiline body *)
(* use #1, #2, #3 and so on to access AParameters in each order, use # to acces single AParameter, use {##} for variadic function *)
GetRectangleAreaV5 = ((#1 * #2) &);
(* call the function example: GetRectangleAreaV5[7, 5] *)

(* ? function expression using pure function shorthand notation (() &) + "Module" to make it can have local variable and multiline body *)
(* use #1, #2, #3 and so on to access AParameters in each order, use # to acces single AParameter, use {##} for variadic function *)
GetRectangleAreaV6 = (Module[{RectangleWidth = #1, RectangleLength = #2},
    Return[(RectangleWidth * RectangleLength), Module];
] &);
(* call the function example: GetRectangleAreaV6[7, 5] *)

(* ? function expression using pure function shorthand notation (() &) + "Module" to make it can have local variable and multiline body *)
(* use #1, #2, #3 and so on to access AParameters in each order, use # to acces single AParameter, use {##} for variadic function *)
GetRectangleAreaV7 = (Module[{RectangleWidth = #1, RectangleLength = #2}, (RectangleWidth * RectangleLength)] &);
(* call the function example: GetRectangleAreaV7[7, 5] *)

(* ? anonymous function *)
(* ! this type of function can't be variadic 🤮, can't have local variable, can't have multiline body *)
(* Function[{RectangleWidth, RectangleLength}, (RectangleWidth * RectangleLength)] *)
(* ! this type of function can't be variadic 🤮 *)
(*
Function[{RectangleWidth, RectangleLength}, Module[{},
    Return[(RectangleWidth * RectangleLength), Module];
]]
*)
(* ((#1 * #2) &) *)
(*
(Module[{RectangleWidth = #1, RectangleLength = #2},
    Return[(RectangleWidth * RectangleLength), Module];
] &)
*)
(* (Module[{RectangleWidth = #1, RectangleLength = #2}, (RectangleWidth * RectangleLength)] &) *)

(* ? Passing functions as arguments to other functions *)
SayHello[CallbackFunction_] := Module[{},
    Print["hello"];
    CallbackFunction[];
];

SayHowAreYou[] := Module[{},
    Print["how are you?"];
];

SayHello[SayHowAreYou];

SayHello[(Module[{},
    Print["how are you?"];
] &)];

SayHello[(Module[{}, Print["how are you?"]] &)];

(* ? Assigning functions to variables or storing them in data structures *)

GetRectangleAreaV5 = ((#1 * #2) &);

GetRectangleAreaV6 = (Module[{RectangleWidth = #1, RectangleLength = #2},
    Return[(RectangleWidth * RectangleLength), Module];
] &);

GetRectangleAreaV7 = (Module[{RectangleWidth = #1, RectangleLength = #2}, (RectangleWidth * RectangleLength)] &);

MyArrayOfGetRectangleAreaFunctions = {
    GetRectangleAreaV1,
    GetRectangleAreaV2,
    ((#1 * #2) &),
    (Module[{RectangleWidth = #1, RectangleLength = #2},
        Return[(RectangleWidth * RectangleLength), Module];
    ] &),
    (Module[{RectangleWidth = #1, RectangleLength = #2}, (RectangleWidth * RectangleLength)] &)
};
GetRectangleAreaFunctionResult1 = MyArrayOfGetRectangleAreaFunctions[[1]][7, 5];
GetRectangleAreaFunctionResult2 = MyArrayOfGetRectangleAreaFunctions[[2]][7, 5];
GetRectangleAreaFunctionResult3 = MyArrayOfGetRectangleAreaFunctions[[3]][7, 5];
GetRectangleAreaFunctionResult4 = MyArrayOfGetRectangleAreaFunctions[[4]][7, 5];
GetRectangleAreaFunctionResult5 = MyArrayOfGetRectangleAreaFunctions[[5]][7, 5];

Exponentiation[A_, B_] := Module[{},
    Return[(A ^ B)];
];

SimpleCalculator = <|
    "exponentiation" -> Exponentiation,
    "multiplication" -> ((#1 * #2) &),
    "addition" -> (Module[{A = #1, B = #2},
        Return[(A + B), Module];
    ] &),
    "subtraction" -> (Module[{A = #1, B = #2}, (A - B)] &)
|>;
SimpleCalculatorResult1 = SimpleCalculator[["exponentiation"]][2, 4];
SimpleCalculatorResult2 = SimpleCalculator[["multiplication"]][7, 5];
SimpleCalculatorResult3 = SimpleCalculator[["addition"]][9, 3];
SimpleCalculatorResult4 = SimpleCalculator[["subtraction"]][35, 8];

(* ? Returning functions as values from other functions *)

MultiplyV1 = (Module[{A = #},
    MultiplyBy = (Module[{B = #},
        Return[(A * B), Module];
    ] &);
    Return[MultiplyBy, Module];
] &);
MultiplyBy2 = MultiplyV1[2];
MultiplyBy2Result = MultiplyBy2[10]; (* 20 *)

MultiplyV2 = (Module[{A = #},
    Return[(Module[{B = #},
        Return[(A * B), Module];
    ] &), Module];
] &);
MultiplyBy3 = MultiplyV2[3];
MultiplyBy3Result = MultiplyBy3[10]; (* 30 *)

MultiplyV3 = (Module[{A = #},
    Return[(Module[{B = #}, (A * B)] &), Module];
] &);
MultiplyBy4 = MultiplyV3[4];
MultiplyBy4Result = MultiplyBy4[10]; (* 40 *)

MultiplyV4 = (Module[{A = #}, (Module[{B = #}, (A * B)] &)] &);
MultiplyBy5 = MultiplyV4[5];
MultiplyBy5Result = MultiplyBy5[10]; (* 50 *)
