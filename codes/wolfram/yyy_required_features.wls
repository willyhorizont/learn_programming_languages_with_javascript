JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

(*
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
*)
Something = "foo";
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = 123;
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = True;
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = Null;
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = {1, 2, 3};
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = <|"foo" -> "bar"|>;
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];

(*
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
*)
GetModifiedIndentLevel = (Module[{IndentLevel},
    IndentLevel = 0;
    ChangeIndentLevel = (Module[{},
        IndentLevel += 1;
        If[(IndentLevel < 5), ChangeIndentLevel[]];
        Return[IndentLevel, Module];
    ] &);
    Return[ChangeIndentLevel[], Module];
] &);
Print["GetModifiedIndentLevel(): ", GetModifiedIndentLevel[]];
CreateNewGame := (Module[{InitialCredit = #, CurrentCredit},
    CurrentCredit = InitialCredit;
    Print["initial credit: ", InitialCredit];
    Return[(Module[{},
        CurrentCredit -= 1;
        If[(CurrentCredit == 0),
            Print["not enough credits"];
            Return[Null, Module];
        ];
        Print["playing game, ", CurrentCredit, " credit(s) remaining"];
    ] &), Module];
] &);
PlayGame = CreateNewGame[3];
PlayGame[];
PlayGame[];
PlayGame[];

(*
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
*)
MyObject = <|
    "my_string" -> "foo",
    "my_number" -> 123,
    "my_boolean" -> True,
    "my_null" -> Null,
    "my_array" -> {1, 2, 3},
    "my_object" -> <|
        "foo" -> "bar"
    |>
|>;
Print["MyObject: ", JsonStringify[MyObject, "Pretty" -> True]];

(*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
*)
MyArray = {"foo", 123, True, Null, {1, 2, 3}, <|"foo" -> "bar"|>};
Print["MyArray: ", JsonStringify[MyArray, "Pretty" -> True]];

(*
x. support passing functions as arguments to other functions
*)
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

(*
x. support returning functions as values from other functions
*)
Multiply = (Module[{A = #},
    Return[(Module[{B = #},
        Return[(A * B), Module];
    ] &), Module];
] &);
MultiplyBy2 = Multiply[2];
MultiplyBy2Result = MultiplyBy2[10];
Print["MultiplyBy2Result: ", MultiplyBy2Result];

(*
x. support assigning functions to variables
*)
GetRectangleAreaV1 = (Module[{RectangleWidth = #1, RectangleLength = #2},
    Return[(RectangleWidth * RectangleLength), Module];
] &);
Print["GetRectangleAreaV1[7, 5]: ", GetRectangleAreaV1[7, 5]];
GetRectangleAreaV2 = (Module[{RectangleWidth = #1, RectangleLength = #2}, (RectangleWidth * RectangleLength)] &);
Print["GetRectangleAreaV2[7, 5]: ", GetRectangleAreaV2[7, 5]];

(*
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
*)
MyArray2 = {
    (Module[{A = #1, B = #2},
        Return[(A * B), Module];
    ] &),
    "foo",
    123,
    True,
    Null,
    {1, 2, 3},
    <|"foo" -> "bar"|>
};
Print["myArray2[0](7, 5): ", MyArray2[[1]][7, 5]];
MyObject = <|
    "my_function" -> (Module[{A = #1, B = #2},
        Return[(A * B), Module];
    ] &),
    "my_string" -> "foo",
    "my_number" -> 123,
    "my_boolean" -> True,
    "my_null" -> Null,
    "my_array" -> {1, 2, 3},
    "my_object" -> <|
        "foo" -> "bar"
    |>
|>;
Print["myObject2[\"my_function\"](7, 5): ", MyObject[["my_function"]][7, 5]];
