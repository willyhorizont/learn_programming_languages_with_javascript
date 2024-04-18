JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

Print["\n(* JavaScript-like Spread Syntax (...) in Wolfram *)"];

(* There's no JavaScript-like Spread Syntax (...) in Wolfram. *)
(* But, we can use Wolfram built-in function "Join[]" to mimic it in Wolfram. *)

ArrayToObject = (Module[{AnArray = #1, NewObject},
    NewObject = <||>;
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            NewObject[[ToString[ArrayItemIndex]]] = ArrayItem;
        ];
    ];
    Return[NewObject, Module];
] &);

Fruits = {"Mango", "Melon", "Banana"};
Print["Fruits: ", JsonStringify[Fruits, "Pretty" -> True]];

Vegetables = {"Carrot", "Tomato"};
Print["Vegetables: ", JsonStringify[Vegetables, "Pretty" -> True]];

CountryCapitalsInAsia = <|
    "Thailand" -> "Bangkok",
    "China" -> "Beijing",
    "Japan" -> "Tokyo"
|>;
Print["CountryCapitalsInAsia: ", JsonStringify[CountryCapitalsInAsia, "Pretty" -> True]];

CountryCapitalsInEurope = <|
    "France" -> "Paris",
    "England" -> "London"
|>;
Print["CountryCapitalsInEurope: ", JsonStringify[CountryCapitalsInEurope, "Pretty" -> True]];

Print["\n(* [...array1, ...array2]: *)\n"];

Combination1 = Join[{}, Fruits, Vegetables];
Print["Combination1: ", JsonStringify[Combination1, "Pretty" -> True]];
(*
Combination1: [
    "Mango",
    "Melon",
    "Banana",
    "Carrot",
    "Tomato"
]
*)

Combination2 = Join[{}, Fruits, {"Cucumber", "Cabbage"}];
Print["Combination2: ", JsonStringify[Combination2, "Pretty" -> True]];
(*
Combination2: [
    "Mango",
    "Melon",
    "Banana",
    "Cucumber",
    "Cabbage"
]
*)

Print["\n(* { ...object1, ...object2 }: *)\n"];

Combination3 = Join[<||>, CountryCapitalsInAsia, CountryCapitalsInEurope];
Print["Combination3: ", JsonStringify[Combination3, "Pretty" -> True]];
(*
Combination3: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "France": "Paris",
    "England": "London"
}
*)

Combination4 = Join[<||>, CountryCapitalsInAsia, <|"Germany" -> "Berlin", "Italy" -> "Rome"|>];
Print["Combination4: ", JsonStringify[Combination4, "Pretty" -> True]];
(*
Combination4: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "Germany": "Berlin",
    "Italy": "Rome"
}
*)

Print["\n(* [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]: *)\n"];

Combination5 = Join[{}, Fruits, {Vegetables}];
Print["Combination5: ", JsonStringify[Combination5, "Pretty" -> True]];
(*
Combination5: [
    "Mango",
    "Melon",
    "Banana",
    [
        "Carrot",
        "Tomato"
    ]
]
*)

Combination6 = Join[{}, Fruits, {{"Cucumber", "Cabbage"}}];
Print["Combination6: ", JsonStringify[Combination6, "Pretty" -> True]];
(*
Combination6: [
    "Mango",
    "Melon",
    "Banana",
    [
        "Cucumber",
        "Cabbage"
    ]
]
*)

Print["\n(* [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]: *)\n"];

Combination7 = Join[{}, Fruits, {CountryCapitalsInAsia}];
Print["Combination7: ", JsonStringify[Combination7, "Pretty" -> True]];
(*
Combination7: [
    "Mango",
    "Melon",
    "Banana",
    {
        "Thailand": "Bangkok",
        "China": "Beijing",
        "Japan": "Tokyo"
    }
]
*)

Combination8 = Join[{}, Fruits, {<|"Germany" -> "Berlin", "Italy" -> "Rome"|>}];
Print["Combination8: ", JsonStringify[Combination8, "Pretty" -> True]];
(*
Combination8: [
    "Mango",
    "Melon",
    "Banana",
    {
        "Germany": "Berlin",
        "Italy": "Rome"
    }
]
*)

Print["\n(* { ...object1, object2 } || { ...object1, objectKey: objectValue }: *)\n"];

Combination9 = Join[<||>, CountryCapitalsInAsia, <|"CountryCapitalsInEurope" -> CountryCapitalsInEurope|>];
Print["Combination9: ", JsonStringify[Combination9, "Pretty" -> True]];
(*
Combination9: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "CountryCapitalsInEurope": {
        "France": "Paris",
        "England": "London"
    }
}
*)

Combination10 = Join[<||>, CountryCapitalsInAsia, <|"CountryCapitalsInEurope" -> <|"Germany" -> "Berlin", "Italy" -> "Rome"|>|>];
Print["Combination10: ", JsonStringify[Combination10, "Pretty" -> True]];
(*
Combination10: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "CountryCapitalsInEurope": {
        "Germany": "Berlin",
        "Italy": "Rome"
    }
}
*)

Print["\n(* { ...object1, array2 } || { ...object1, objectKey: objectValue }: *)\n"];

Combination11 = Join[<||>, CountryCapitalsInAsia, <|"Vegetables" -> Vegetables|>];
Print["Combination11: ", JsonStringify[Combination11, "Pretty" -> True]];
(*
Combination11: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "Vegetables": [
        "Carrot",
        "Tomato"
    ]
}
*)

Combination12 = Join[<||>, CountryCapitalsInAsia, <|"Vegetables" -> {"Cucumber", "Cabbage"}|>];
Print["Combination12: ", JsonStringify[Combination12, "Pretty" -> True]];
(*
Combination12: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "Vegetables": [
        "Cucumber",
        "Cabbage"
    ]
}
*)

Print["\n(* { ...object1, ...array2 }: *)\n"];

Combination13 = Join[<||>, CountryCapitalsInAsia, ArrayToObject[Vegetables]];
Print["Combination13: ", JsonStringify[Combination13, "Pretty" -> True]];
(*
Combination13: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "1": "Carrot",
    "2": "Tomato"
}
*)

Combination14 = Join[<||>, CountryCapitalsInAsia, ArrayToObject[{"Cucumber", "Cabbage"}]];
Print["Combination14: ", JsonStringify[Combination14, "Pretty" -> True]];
(*
Combination14: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "1": "Cucumber",
    "2": "Cabbage"
}
*)

(* Print["\n(* [...array1, ...object1]: (* this Combination throw an error in JavaScript *) *)\n"]; *)

(* this Combination throw an error in JavaScript *)
(* CombinationErrorInJavascript1 = Join[{}, Fruits, CountryCapitalsInAsia]; *)
(* Print["CombinationErrorInJavascript1: ", JsonStringify[CombinationErrorInJavascript1, "Pretty" -> True]]; *)

(* this Combination throw an error in JavaScript *)
(* CombinationErrorInJavascript2 = Join[{}, Fruits, <|"Germany" -> "Berlin", "Italy" -> "Rome"|>]; *)
(* Print["CombinationErrorInJavascript2: ", JsonStringify[CombinationErrorInJavascript2, "Pretty" -> True]]; *)
