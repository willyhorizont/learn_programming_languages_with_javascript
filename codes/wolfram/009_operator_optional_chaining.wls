JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

Print["\n(* JavaScript-like Optional Chaining Operator (?.) in Wolfram *)"];

(* There's no JavaScript-like Optional Chaining Operator (?.) in Wolfram. *)
(* But, we can create our own function to mimic it in Wolfram. *)

OptionalChainingV1 = (Module[{Anything = {##}[[1]], ObjectPropertiesArray = Drop[{##}, 1]},
    (* JavaScript-like Optional Chaining Operator (?.) function *)
    If[(((AssociationQ[Anything] == True) && (ListQ[Anything] == True)) || (Length[ObjectPropertiesArray] == 0)), Return[Anything, Module]];
    Return[Fold[(Module[{CurrentResult = #1, CurrentItem = #2},
        If[((CurrentResult === Null) && (AssociationQ[Anything] == True) && (StringQ[CurrentItem] == True)), Return[Lookup[Anything, CurrentItem, Null], Module]];
        If[((CurrentResult === Null) && (ListQ[Anything] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[Anything] > CurrentItem)), Return[Anything[[CurrentItem]], Module]];
        If[((AssociationQ[CurrentResult] == True) && (StringQ[CurrentItem] == True)), Return[Lookup[CurrentResult, CurrentItem, Null], Module]];
        If[((ListQ[CurrentResult] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[CurrentResult] > CurrentItem)), Return[CurrentResult[[CurrentItem]], Module]];
        Return[Null, Module];
    ] &), Null, ObjectPropertiesArray], Module];
] &);

OptionalChainingV2 = (Module[{Anything = {##}[[1]], ObjectPropertiesArray = Drop[{##}, 1]},
    (* JavaScript-like Optional Chaining Operator (?.) function *)
    If[(((AssociationQ[Anything] == True) && (ListQ[Anything] == True)) || (Length[ObjectPropertiesArray] == 0)), Return[Anything, Module]];
    Return[Fold[(Module[{CurrentResult = #1, CurrentItem = #2},
        If[((CurrentResult === Null) && (AssociationQ[Anything] == True) && (StringQ[CurrentItem] == True) && (KeyExistsQ[Anything, CurrentItem] == True)), Return[Anything[[CurrentItem]], Module]];
        If[((CurrentResult === Null) && (ListQ[Anything] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[Anything] > CurrentItem)), Return[Anything[[CurrentItem]], Module]];
        If[((AssociationQ[CurrentResult] == True) && (StringQ[CurrentItem] == True) && (KeyExistsQ[CurrentResult, CurrentItem] == True)), Return[CurrentResult[[CurrentItem]], Module]];
        If[((ListQ[CurrentResult] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[CurrentResult] > CurrentItem)), Return[CurrentResult[[CurrentItem]], Module]];
        Return[Null, Module];
    ] &), Null, ObjectPropertiesArray], Module];
] &);

(* JavaScript-like Optional Chaining Operator (?.) function *)
OptionalChainingV3 = (Module[{Anything = {##}[[1]], ObjectPropertiesArray = Drop[{##}, 1]}, If[(((AssociationQ[Anything] == True) && (ListQ[Anything] == True)) || (Length[ObjectPropertiesArray] == 0)), Anything, Fold[(Module[{CurrentResult = #1, CurrentItem = #2}, If[((CurrentResult === Null) && (AssociationQ[Anything] == True) && (StringQ[CurrentItem] == True)), Lookup[Anything, CurrentItem, Null], If[((CurrentResult === Null) && (ListQ[Anything] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[Anything] > CurrentItem)), Anything[[CurrentItem]], If[((AssociationQ[CurrentResult] == True) && (StringQ[CurrentItem] == True)), Lookup[CurrentResult, CurrentItem, Null], If[((ListQ[CurrentResult] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[CurrentResult] > CurrentItem)), CurrentResult[[CurrentItem]], Null]]]]] &), Null, ObjectPropertiesArray]]] &);

(* JavaScript-like Optional Chaining Operator (?.) function *)
OptionalChainingV4 = (Module[{Anything = {##}[[1]], ObjectPropertiesArray = Drop[{##}, 1]}, If[(((AssociationQ[Anything] == True) && (ListQ[Anything] == True)) || (Length[ObjectPropertiesArray] == 0)), Anything, Fold[(Module[{CurrentResult = #1, CurrentItem = #2}, If[((CurrentResult === Null) && (AssociationQ[Anything] == True) && (StringQ[CurrentItem] == True) && (KeyExistsQ[Anything, CurrentItem] == True)), Anything[[CurrentItem]], If[((CurrentResult === Null) && (ListQ[Anything] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[Anything] > CurrentItem)), Anything[[CurrentItem]], If[((AssociationQ[CurrentResult] == True) && (StringQ[CurrentItem] == True) && (KeyExistsQ[CurrentResult, CurrentItem] == True)), CurrentResult[[CurrentItem]], If[((ListQ[CurrentResult] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[CurrentResult] > CurrentItem)), CurrentResult[[CurrentItem]], Null]]]]] &), Null, ObjectPropertiesArray]]] &);

JSONOBJECT = <|
    "foo" -> <|
        "bar" -> "baz"
    |>,
    "Fruits" -> {"apple", "mango", "banana"}
|>;
Print["JSONOBJECT: ", JsonStringify[JSONOBJECT, "Pretty" -> True]];

Print["(* using JavaScript-like Optional Chaining Operator (?.) function \"OptionalChainingV1\" *)"];

Print["JSONOBJECT?.foo?.bar or JSONOBJECT?.['foo']?.['bar']: ", JsonStringify[OptionalChainingV1[JSONOBJECT, "foo", "bar"]]];
(* JSONOBJECT?.foo?.bar or JSONOBJECT?.['foo']?.['bar']: "baz" *)

Print["JSONOBJECT?.foo?.baz or JSONOBJECT?.['foo']?.['baz']: ", JsonStringify[OptionalChainingV1[JSONOBJECT, "foo", "baz"]]];
(* JSONOBJECT?.foo?.baz or JSONOBJECT?.['foo']?.['baz']: null *)

Print["JSONOBJECT?.Fruits?.[2] or JSONOBJECT?.['Fruits']?.[2]: ", JsonStringify[OptionalChainingV1[JSONOBJECT, "Fruits", 2]]];
(* JSONOBJECT?.Fruits?.[2] or JSONOBJECT?.['Fruits']?.[2]: "banana" *)

Print["JSONOBJECT?.Fruits?.[5] or JSONOBJECT?.['Fruits']?.[5]: ", JsonStringify[OptionalChainingV1[JSONOBJECT, "Fruits", 5]]];
(* JSONOBJECT?.Fruits?.[5] or JSONOBJECT?.['Fruits']?.[5]: null *)

Print["(* using JavaScript-like Optional Chaining Operator (?.) function \"OptionalChainingV2\" *)"];

Print["JSONOBJECT?.foo?.bar or JSONOBJECT?.['foo']?.['bar']: ", JsonStringify[OptionalChainingV2[JSONOBJECT, "foo", "bar"]]];
(* JSONOBJECT?.foo?.bar or JSONOBJECT?.['foo']?.['bar']: "baz" *)

Print["JSONOBJECT?.foo?.baz or JSONOBJECT?.['foo']?.['baz']: ", JsonStringify[OptionalChainingV2[JSONOBJECT, "foo", "baz"]]];
(* JSONOBJECT?.foo?.baz or JSONOBJECT?.['foo']?.['baz']: null *)

Print["JSONOBJECT?.Fruits?.[2] or JSONOBJECT?.['Fruits']?.[2]: ", JsonStringify[OptionalChainingV2[JSONOBJECT, "Fruits", 2]]];
(* JSONOBJECT?.Fruits?.[2] or JSONOBJECT?.['Fruits']?.[2]: "banana" *)

Print["JSONOBJECT?.Fruits?.[5] or JSONOBJECT?.['Fruits']?.[5]: ", JsonStringify[OptionalChainingV2[JSONOBJECT, "Fruits", 5]]];
(* JSONOBJECT?.Fruits?.[5] or JSONOBJECT?.['Fruits']?.[5]: null *)

Print["(* using JavaScript-like Optional Chaining Operator (?.) function \"OptionalChainingV3\" *)"];

Print["JSONOBJECT?.foo?.bar or JSONOBJECT?.['foo']?.['bar']: ", JsonStringify[OptionalChainingV3[JSONOBJECT, "foo", "bar"]]];
(* JSONOBJECT?.foo?.bar or JSONOBJECT?.['foo']?.['bar']: "baz" *)

Print["JSONOBJECT?.foo?.baz or JSONOBJECT?.['foo']?.['baz']: ", JsonStringify[OptionalChainingV3[JSONOBJECT, "foo", "baz"]]];
(* JSONOBJECT?.foo?.baz or JSONOBJECT?.['foo']?.['baz']: null *)

Print["JSONOBJECT?.Fruits?.[2] or JSONOBJECT?.['Fruits']?.[2]: ", JsonStringify[OptionalChainingV3[JSONOBJECT, "Fruits", 2]]];
(* JSONOBJECT?.Fruits?.[2] or JSONOBJECT?.['Fruits']?.[2]: "banana" *)

Print["JSONOBJECT?.Fruits?.[5] or JSONOBJECT?.['Fruits']?.[5]: ", JsonStringify[OptionalChainingV3[JSONOBJECT, "Fruits", 5]]];
(* JSONOBJECT?.Fruits?.[5] or JSONOBJECT?.['Fruits']?.[5]: null *)

Print["(* using JavaScript-like Optional Chaining Operator (?.) function \"OptionalChainingV4\" *)"];

Print["JSONOBJECT?.foo?.bar or JSONOBJECT?.['foo']?.['bar']: ", JsonStringify[OptionalChainingV4[JSONOBJECT, "foo", "bar"]]];
(* JSONOBJECT?.foo?.bar or JSONOBJECT?.['foo']?.['bar']: "baz" *)

Print["JSONOBJECT?.foo?.baz or JSONOBJECT?.['foo']?.['baz']: ", JsonStringify[OptionalChainingV4[JSONOBJECT, "foo", "baz"]]];
(* JSONOBJECT?.foo?.baz or JSONOBJECT?.['foo']?.['baz']: null *)

Print["JSONOBJECT?.Fruits?.[2] or JSONOBJECT?.['Fruits']?.[2]: ", JsonStringify[OptionalChainingV4[JSONOBJECT, "Fruits", 2]]];
(* JSONOBJECT?.Fruits?.[2] or JSONOBJECT?.['Fruits']?.[2]: "banana" *)

Print["JSONOBJECT?.Fruits?.[5] or JSONOBJECT?.['Fruits']?.[5]: ", JsonStringify[OptionalChainingV4[JSONOBJECT, "Fruits", 5]]];
(* JSONOBJECT?.Fruits?.[5] or JSONOBJECT?.['Fruits']?.[5]: null *)
