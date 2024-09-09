JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

(* There's no JavaScript-like Object.entries() in Wolfram. *)
(* But, we can create our own function to mimic it in Wolfram. *)

ObjectEntries = (Module[{AnObject = #1, NewArray},
    (* JavaScript-like Object.entries() function *)
    NewArray = {};
    Module[{ObjectKeys, ObjectValues, ObjectIterationIndex, ObjectKey, ObjectValue},
        ObjectKeys = Keys[Friend];
        ObjectValues = Values[Friend];
        For[ObjectIterationIndex = 1, (ObjectIterationIndex <= Length[ObjectKeys]), ObjectIterationIndex += 1,
            ObjectKey = ObjectKeys[[ObjectIterationIndex]];
            ObjectValue = ObjectValues[[ObjectIterationIndex]];
            NewArray = Append[NewArray, {ObjectKey, ObjectValue}];
        ];
    ];
    Return[NewArray, Module];
] &);

Print["\n(* JavaScript-like Object.entries() in in Wolfram Association *)"];

Friend = <|
    "name" -> "Alisa",
    "country" -> "Finland",
    "age" -> 25
|>;
Print["Friend: ", JsonStringify[Friend, "Pretty" -> True]];

Print["(* using JavaScript-like Object.entries() function \"ObjectEntries\" *)"];

Print["friend entries: ", JsonStringify[ObjectEntries[Friend]]];
(* friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]] *)
