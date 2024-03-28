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

(* iterate over and get each key-value pair and iteration/entry index *)
Module[{ObjectKeys, ObjectValues, IterationIndex, ObjectKey, ObjectValue},
    ObjectKeys = Keys[Friend];
    ObjectValues = Values[Friend];
    For[IterationIndex = 1, (IterationIndex <= Length[ObjectKeys]), IterationIndex += 1,
        ObjectKey = ObjectKeys[[IterationIndex]];
        ObjectValue = ObjectValues[[IterationIndex]];
        SPrint["Friend, foreach loop v1, iteration/entry index: ", {IterationIndex}, ", key: ", {ObjectKey}, ", value: ", {ObjectValue}];
    ];
];
(* Friend, foreach loop v1, iteration/entry index: 1, key: "name", value: "Alisa" *)
(* Friend, foreach loop v1, iteration/entry index: 2, key: "country", value: "Finland" *)
(* Friend, foreach loop v1, iteration/entry index: 3, key: "age", value: 25 *)

(* iterate over and get each key-value pair and iteration/entry index *)
Module[{IterationIndex},
    IterationIndex = 1;
    KeyValueMap[(Module[{ObjectKey = #1, ObjectValue = #2},
        SPrint["Friend, foreach loop v2, iteration/entry index: ", {IterationIndex}, ", key: ", {ObjectKey}, ", value: ", {ObjectValue}];
        IterationIndex += 1;
    ] &), Friend];
];
(* Friend, foreach loop v2, iteration/entry index: 1, key: "name", value: "Alisa" *)
(* Friend, foreach loop v2, iteration/entry index: 2, key: "country", value: "Finland" *)
(* Friend, foreach loop v2, iteration/entry index: 3, key: "age", value: 25 *)
