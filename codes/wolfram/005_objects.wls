PrettyJsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> "    "]] &);

JsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

SPrint = (Module[{AParameters = {##}}, Print[StringJoin[MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]}, If[((ArrayQ[ArrayItem] == True) && Length[ArrayItem] == 1), JsonStringify[ArrayItem[[1]]], If[(StringQ[ArrayItem] == True), ArrayItem, ""]]] &), AParameters]]]] &);

(* in Wolfram, JavaScript-like Object is called Association *)

Friend = <|
    "name" -> "Alisa",
    "country" -> "Finland",
    "age" -> 25
|>;
Print["Friend: ", PrettyJsonStringify[Friend]];

(*
or we can also define object using curly braces ({})
Friend = {
    "name" -> "Alisa",
    "country" -> "Finland",
    "age" -> 25
};
*)

Print["Friend, get country: ", PrettyJsonStringify[Friend[["country"]]]];
(* Friend, get country: Finland *)

(* iterate over and get each key-value pair and object iteration/entry index *)
Module[{ObjectKeys, ObjectValues, ObjectIterationIndex, ObjectKey, ObjectValue},
    ObjectKeys = Keys[Friend];
    ObjectValues = Values[Friend];
    For[ObjectIterationIndex = 1, (ObjectIterationIndex <= Length[ObjectKeys]), ObjectIterationIndex += 1,
        ObjectKey = ObjectKeys[[ObjectIterationIndex]];
        ObjectValue = ObjectValues[[ObjectIterationIndex]];
        SPrint["Friend, forEach loop v1, object iteration/entry index: ", {ObjectIterationIndex}, ", key: ", {ObjectKey}, ", value: ", {ObjectValue}];
    ];
];
(* Friend, forEach loop v1, object iteration/entry index: 1, key: "name", value: "Alisa" *)
(* Friend, forEach loop v1, object iteration/entry index: 2, key: "country", value: "Finland" *)
(* Friend, forEach loop v1, object iteration/entry index: 3, key: "age", value: 25 *)

(* iterate over and get each key-value pair and object iteration/entry index *)
Module[{ObjectIterationIndex},
    ObjectIterationIndex = 1;
    KeyValueMap[(Module[{ObjectKey = #1, ObjectValue = #2},
        SPrint["Friend, forEach loop v2, object iteration/entry index: ", {ObjectIterationIndex}, ", key: ", {ObjectKey}, ", value: ", {ObjectValue}];
        ObjectIterationIndex += 1;
    ] &), Friend];
];
(* Friend, forEach loop v2, object iteration/entry index: 1, key: "name", value: "Alisa" *)
(* Friend, forEach loop v2, object iteration/entry index: 2, key: "country", value: "Finland" *)
(* Friend, forEach loop v2, object iteration/entry index: 3, key: "age", value: 25 *)
