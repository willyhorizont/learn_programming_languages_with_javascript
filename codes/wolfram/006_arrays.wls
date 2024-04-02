PrettyJsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> "    "]] &);

JsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

SPrint = (Module[{AParameters = {##}}, Print[StringJoin[MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]}, If[((ArrayQ[ArrayItem] == True) && Length[ArrayItem] == 1), JsonStringify[ArrayItem[[1]]], If[(StringQ[ArrayItem] == True), ArrayItem, ""]]] &), AParameters]]]] &);

(* in Wolfram, JavaScript-like Array is called List *)

Fruits = {"apple", "mango", "orange"};
SPrint["Fruits: ", {Fruits}];

SPrint["Fruits, length: ", {Length[Fruits]}];
(* Fruits, length: 3 *)

SPrint["Fruits, get mango: ", {Fruits[[2]]}];
(* Fruits, get mango: 3 *)

SPrint["Fruits, first element: ", {Fruits[[1]]}];
(* Fruits, first element: apple *)

SPrint["Fruits, first element: ", {First[Fruits]}];
(* Fruits, first element: apple *)

SPrint["Fruits, last element: ", {Fruits[[Length[Fruits]]]}];
(* last element: orange *)

SPrint["Fruits, last element: ", {Last[Fruits]}];
(* last element: orange *)

SPrint["Fruits, last element: ", {Fruits[[-1]]}];
(* last element: orange *)

Module[{ArrayItem, ArrayItemIndex},
    For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[Fruits]), ArrayItemIndex += 1,
        ArrayItem = Fruits[[ArrayItemIndex]];
        SPrint["Fruits, forEach loop v1, index: ", {ArrayItemIndex}, ", value: ", {ArrayItem}];
    ];
];
(* Fruits, forEach loop v1, index: 1, value: "apple" *)
(* Fruits, forEach loop v1, index: 2, value: "mango" *)
(* Fruits, forEach loop v1, index: 3, value: "orange" *)

MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]},
    SPrint["Fruits, forEach loop v2, index: ", {ArrayItemIndex}, ", value: ", {ArrayItem}];
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
Print["Products: ", PrettyJsonStringify[Products]];

Module[{ArrayItem, ArrayItemIndex},
    For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[Products]), ArrayItemIndex += 1,
        ArrayItem = Products[[ArrayItemIndex]];
        Module[{ObjectKeys, ObjectValues, ObjectIterationIndex, ObjectKey, ObjectValue},
            ObjectKeys = Keys[ArrayItem];
            ObjectValues = Values[ArrayItem];
            For[ObjectIterationIndex = 1, (ObjectIterationIndex <= Length[ObjectKeys]), ObjectIterationIndex += 1,
                ObjectKey = ObjectKeys[[ObjectIterationIndex]];
                ObjectValue = ObjectValues[[ObjectIterationIndex]];
                SPrint["Products, forEach loop v1, array item index: ", {ArrayItemIndex}, ", object iteration/entry index: ", {ObjectIterationIndex}, ", key: ", {ObjectKey}, ", value: ", {ObjectValue}];
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
            SPrint["Products, forEach loop v2, array item index: ", {ArrayItemIndex}, ", object iteration/entry index: ", {ObjectIterationIndex}, ", key: ", {ObjectKey}, ", value: ", {ObjectValue}];
            ObjectIterationIndex += 1;
        ] &), ArrayItem];
    ];
] &), Products];
(* Products, forEach loop v2, array item index: 1, object iteration/entry index: 1, key: "id", value: "P1" *)
(* Products, forEach loop v2, array item index: 1, object iteration/entry index: 2, key: "name", value: "bubble gum" *)
(* Products, forEach loop v2, array item index: 2, object iteration/entry index: 1, key: "id", value: "P2" *)
(* Products, forEach loop v2, array item index: 2, object iteration/entry index: 2, key: "name", value: "potato chips" *)
