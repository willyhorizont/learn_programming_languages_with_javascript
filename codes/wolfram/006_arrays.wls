JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

(* in Wolfram, JavaScript-like Array is called List *)

Fruits = {"apple", "mango", "orange"};
Print["Fruits: ", JsonStringify[Fruits]];

Print["Fruits, length: ", Length[Fruits]];
(* Fruits, length: 3 *)

Print["Fruits, get mango: ", Fruits[[2]]];
(* Fruits, get mango: 3 *)

Print["Fruits, first element: ", Fruits[[1]]];
(* Fruits, first element: apple *)

Print["Fruits, first element: ", First[Fruits]];
(* Fruits, first element: apple *)

Print["Fruits, last element: ", Fruits[[Length[Fruits]]]];
(* last element: orange *)

Print["Fruits, last element: ", Last[Fruits]];
(* last element: orange *)

Print["Fruits, last element: ", Fruits[[-1]]];
(* last element: orange *)

Module[{ArrayItem, ArrayItemIndex},
    For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[Fruits]), ArrayItemIndex += 1,
        ArrayItem = Fruits[[ArrayItemIndex]];
        Print["Fruits, forEach loop v1, index: ", ArrayItemIndex, ", value: ", ArrayItem];
    ];
];
(* Fruits, forEach loop v1, index: 1, value: "apple" *)
(* Fruits, forEach loop v1, index: 2, value: "mango" *)
(* Fruits, forEach loop v1, index: 3, value: "orange" *)

MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]},
    Print["Fruits, forEach loop v2, index: ", ArrayItemIndex, ", value: ", ArrayItem];
] &), Fruits];
(* Fruits, forEach loop v2, index: 1, value: "apple" *)
(* Fruits, forEach loop v2, index: 2, value: "mango" *)
(* Fruits, forEach loop v2, index: 3, value: "orange" *)

(* in Wolfram, JavaScript-like Array of Objects is called List of Associations *)

Products = {
    <|
        "id" -> "P1",
        "name" -> "bubble gum"
    |>,
    <|
        "id" -> "P2",
        "name" -> "potato chips"
    |>
};
Print["Products: ", JsonStringify[Products, "Pretty" -> True]];

Module[{ArrayItem, ArrayItemIndex},
    For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[Products]), ArrayItemIndex += 1,
        ArrayItem = Products[[ArrayItemIndex]];
        Module[{ObjectKeys, ObjectValues, ObjectIterationIndex, ObjectKey, ObjectValue},
            ObjectKeys = Keys[ArrayItem];
            ObjectValues = Values[ArrayItem];
            For[ObjectIterationIndex = 1, (ObjectIterationIndex <= Length[ObjectKeys]), ObjectIterationIndex += 1,
                ObjectKey = ObjectKeys[[ObjectIterationIndex]];
                ObjectValue = ObjectValues[[ObjectIterationIndex]];
                Print["Products, forEach loop v1, array item index: ", ArrayItemIndex, ", object iteration/entry index: ", ObjectIterationIndex, ", key: ", ObjectKey, ", value: ", ObjectValue];
            ];
        ];
    ];
];
(* Products, forEach loop v1, array item index: 1, object iteration/entry index: 1, key: "id", value: "P1" *)
(* Products, forEach loop v1, array item index: 1, object iteration/entry index: 2, key: "name", value: "bubble gum" *)
(* Products, forEach loop v1, array item index: 2, object iteration/entry index: 1, key: "id", value: "P2" *)
(* Products, forEach loop v1, array item index: 2, object iteration/entry index: 2, key: "name", value: "potato chips" *)

MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]},
    Module[{ObjectIterationIndex},
        ObjectIterationIndex = 1;
        KeyValueMap[(Module[{ObjectKey = #1, ObjectValue = #2},
            Print["Products, forEach loop v2, array item index: ", ArrayItemIndex, ", object iteration/entry index: ", ObjectIterationIndex, ", key: ", ObjectKey, ", value: ", ObjectValue];
            ObjectIterationIndex += 1;
        ] &), ArrayItem];
    ];
] &), Products];
(* Products, forEach loop v2, array item index: 1, object iteration/entry index: 1, key: "id", value: "P1" *)
(* Products, forEach loop v2, array item index: 1, object iteration/entry index: 2, key: "name", value: "bubble gum" *)
(* Products, forEach loop v2, array item index: 2, object iteration/entry index: 1, key: "id", value: "P2" *)
(* Products, forEach loop v2, array item index: 2, object iteration/entry index: 2, key: "name", value: "potato chips" *)
