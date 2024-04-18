jsonString = ExportString[<|"key" -> "value"|>, "JSON"];
formattedString = ImportString[jsonString, "RawJSON"];
prettyJsonString = ExportString[formattedString, "JSON", "Compact" -> False];
Print[prettyJsonString];

jsonString = ExportString[<|"key" -> "value"|>, "JSON", "Compact" -> True]
Print[jsonString];

prettyJsonStringify = (Module[{anything = #}, Return[StringReplace[ExportString[ImportString[ExportString[anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], Module]] &);

jsonStringify = (Module[{anything = #}, Return[StringReplace[StringReplace[ExportString[anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], Module]] &);

sPrint = (Module[{parameters = {##}}, Print[StringJoin[MapIndexed[(Module[{arrayItem = #1, arrayItemIndex = #2[[1]]}, If[((ArrayQ[arrayItem] == True) && Length[arrayItem] == 1), Return[jsonStringify[arrayItem[[1]]], Module], If[(StringQ[arrayItem] == True), Return[arrayItem, Module], Return["", Module]]]] &), parameters]]]] &);

prettyJsonStringify = (Module[{anything = #}, StringReplace[ExportString[ImportString[ExportString[anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);
Print[prettyJsonStringify[<|"foo" -> "bar"|>]];
Print[prettyJsonStringify[{1, 2, 3}]];

jsonStringify = (Module[{anything = #}, StringReplace[StringReplace[ExportString[anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);
Print[jsonStringify[{1, 2, 3}]];
Print[jsonStringify[<|"foo" -> "bar"|>]];

sPrint = (Module[{parameters = {##}},
    parametersNew = MapIndexed[(Module[{arrayItem = #1, arrayItemIndex = #2[[1]]},
        If[((ArrayQ[arrayItem] == True) && Length[arrayItem] == 1),
            Return[jsonStringify[arrayItem[[1]]], Module];
        ];
        If[(StringQ[arrayItem] == True),
            Return[arrayItem, Module];
        ];
        Return["", Module];
    ] &), parameters];
    Print[StringJoin[parametersNew]];
] &);

sPrint = (Module[{parameters = {##}}, Print[StringJoin[MapIndexed[(Module[{arrayItem = #1, arrayItemIndex = #2[[1]]}, If[((ArrayQ[arrayItem] == True) && Length[arrayItem] == 1), Return[jsonStringify[arrayItem[[1]]], Module], If[(StringQ[arrayItem] == True), Return[arrayItem, Module], Return["", Module]]]] &), parameters]]]] &);

prettyJsonStringify = (Module[{anything = #}, StringReplace[ExportString[ImportString[ExportString[anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

optionalChainingV1[anything_, objectPropertiesArray___] := Module[{},
    Print["anything: ", prettyJsonStringify[anything]];
    Print["objectPropertiesArray: ", prettyJsonStringify[{objectPropertiesArray}]];
];

JSONOBJECT = <|
    "foo" -> <|
        "bar" -> "baz"
    |>,
    "fruits" -> {"apple", "mango", "banana"}
|>;

optionalChainingV1[JSONOBJECT, "foo", "baz"];

indentString[n_Integer] := StringJoin[ConstantArray["x", n]]
indentString[n_Integer] := StringJoin@ConstantArray["x", n]
