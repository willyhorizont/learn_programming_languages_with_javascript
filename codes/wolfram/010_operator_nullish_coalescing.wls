JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

Print["\n(* JavaScript-like Nullish Coalescing Operator (??) in Wolfram *)"];

(* There's no JavaScript-like Nullish Coalescing Operator (??) in Wolfram. *)
(* But, we can create our own function to mimic it in Wolfram. *)

(* JavaScript-like Optional Chaining Operator (?.) function *)
OptionalChainingV4 = (Module[{Anything = {##}[[1]], ObjectPropertiesArray = Drop[{##}, 1]}, If[(((AssociationQ[Anything] == True) && (ListQ[Anything] == True)) || (Length[ObjectPropertiesArray] == 0)), Anything, Fold[(Module[{CurrentResult = #1, CurrentItem = #2}, If[((CurrentResult === Null) && (AssociationQ[Anything] == True) && (StringQ[CurrentItem] == True) && (KeyExistsQ[Anything, CurrentItem] == True)), Anything[[CurrentItem]], If[((CurrentResult === Null) && (ListQ[Anything] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[Anything] > CurrentItem)), Anything[[CurrentItem]], If[((AssociationQ[CurrentResult] == True) && (StringQ[CurrentItem] == True) && (KeyExistsQ[CurrentResult, CurrentItem] == True)), CurrentResult[[CurrentItem]], If[((ListQ[CurrentResult] == True) && (NumericQ[CurrentItem] == True) && (CurrentItem >= 0) && (Length[CurrentResult] > CurrentItem)), CurrentResult[[CurrentItem]], Null]]]]] &), Null, ObjectPropertiesArray]]] &);

(* JavaScript-like Nullish Coalescing Operator (??) function *)
NullishCoalescing = (Module[{Anything = #1, DefaultValue = #2}, If[(Anything === Null), DefaultValue, Anything]] &);

JSONOBJECT = <|
    "foo" -> <|
        "bar" -> "baz"
    |>,
    "Fruits" -> {"apple", "mango", "banana"}
|>;
Print["JSONOBJECT: ", JsonStringify[JSONOBJECT, "Pretty" -> True]];

Print["(* using JavaScript-like Nullish Coalescing Operator (??) function \"NullishCoalescing\" *)"];

Print["(JSONOBJECT?.foo?.bar ?? 'not found') or (JSONOBJECT?.['foo']?.['bar'] ?? 'not found'): ", JsonStringify[NullishCoalescing[OptionalChainingV4[JSONOBJECT, "foo", "bar"], "not found"]]];
(* (JSONOBJECT?.foo?.bar ?? "not found") or (JSONOBJECT?.['foo']?.['bar'] ?? "not found"): "baz" *)

Print["(JSONOBJECT?.foo?.baz ?? 'not found') or (JSONOBJECT?.['foo']?.['baz'] ?? 'not found'): ", JsonStringify[NullishCoalescing[OptionalChainingV4[JSONOBJECT, "foo", "baz"], "not found"]]];
(* (JSONOBJECT?.foo?.baz ?? "not found") or (JSONOBJECT?.['foo']?.['baz'] ?? "not found"): "not found" *)

Print["(JSONOBJECT?.Fruits?.[2] ?? 'not found') or (JSONOBJECT?.['Fruits']?.[2] ?? 'not found'): ", JsonStringify[NullishCoalescing[OptionalChainingV4[JSONOBJECT, "Fruits", 2], "not found"]]];
(* (JSONOBJECT?.Fruits?.[2] ?? "not found") or (JSONOBJECT?.['Fruits']?.[2] ?? "not found"): "banana" *)

Print["(JSONOBJECT?.Fruits?.[5] ?? 'not found') or (JSONOBJECT?.['Fruits']?.[5] ?? 'not found'): ", JsonStringify[NullishCoalescing[OptionalChainingV4[JSONOBJECT, "Fruits", 5], "not found"]]];
(* (JSONOBJECT?.Fruits?.[5] ?? "not found") or (JSONOBJECT?.['Fruits']?.[5] ?? "not found"): "not found" *)
