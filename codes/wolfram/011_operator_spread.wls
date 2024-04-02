PrettyJsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> "    "]] &);

JsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

SPrint = (Module[{AParameters = {##}}, Print[StringJoin[MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]}, If[((ArrayQ[ArrayItem] == True) && Length[ArrayItem] == 1), JsonStringify[ArrayItem[[1]]], If[(StringQ[ArrayItem] == True), ArrayItem, ""]]] &), AParameters]]]] &);

Print["\n(* JavaScript-like Spread Syntax (...) in Wolfram *)"];

(* There's no JavaScript-like Spread Syntax (...) in Wolfram. *)
(* But, we can create our own function to mimic it in Wolfram. *)

SpreadSyntaxObject = (Module[{AParameters = {##}, NewObject},
    NewObject = <||>;
    Module[{AParameter, ParameterIndex},
        For[ParameterIndex = 1, (ParameterIndex <= Length[AParameters]), ParameterIndex += 1,
            AParameter = AParameters[[ParameterIndex]];
            If[(AssociationQ[AParameter] == True),
                Module[{ObjectKeys, ObjectValues, ObjectIterationIndex, ObjectKey, ObjectValue},
                    ObjectKeys = Keys[AParameter];
                    ObjectValues = Values[AParameter];
                    For[ObjectIterationIndex = 1, (ObjectIterationIndex <= Length[ObjectKeys]), ObjectIterationIndex += 1,
                        ObjectKey = ObjectKeys[[ObjectIterationIndex]];
                        ObjectValue = ObjectValues[[ObjectIterationIndex]];
                        NewObject[[ObjectKey]] = ObjectValue;
                    ];
                ];
                Continue[];
            ];
            If[(ListQ[AParameter] == True),
                Module[{ArrayItem, ArrayItemIndex},
                    For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AParameter]), ArrayItemIndex += 1,
                        ArrayItem = AParameter[[ArrayItemIndex]];
                        NewObject[[ToString[ArrayItemIndex]]] = ArrayItem;
                    ];
                ];
                Continue[];
            ];
        ];
    ];
    Return[NewObject, Module];
] &);

SpreadSyntaxArray = (Module[{AParameters = {##}, NewArray},
    NewArray = {};
    Module[{AParameter, ParameterIndex},
        For[ParameterIndex = 1, (ParameterIndex <= Length[AParameters]), ParameterIndex += 1,
            AParameter = AParameters[[ParameterIndex]];
            If[(AssociationQ[AParameter] == True),
                If[(Length[Keys[AParameter]] == 1),
                    Module[{ObjectKeys, ObjectValues, ObjectIterationIndex, ObjectKey, ObjectValue},
                        ObjectKeys = Keys[AParameter];
                        ObjectValues = Values[AParameter];
                        For[ObjectIterationIndex = 1, (ObjectIterationIndex <= Length[ObjectKeys]), ObjectIterationIndex += 1,
                            ObjectKey = ObjectKeys[[ObjectIterationIndex]];
                            ObjectValue = ObjectValues[[ObjectIterationIndex]];
                            NewArray = Append[NewArray, ObjectValue];
                        ];
                    ];
                    Continue[];
                ];
                NewArray = Append[NewArray, AParameter];
                Continue[];
            ];
            If[(ListQ[AParameter] == True),
                Module[{ArrayItem, ArrayItemIndex},
                    For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AParameter]), ArrayItemIndex += 1,
                        ArrayItem = AParameter[[ArrayItemIndex]];
                        NewArray = Append[NewArray, ArrayItem];
                    ];
                ];
                Continue[];
            ];
        ];
    ];
    Return[NewArray, Module];
] &);

Fruits = {"Mango", "Melon", "Banana"};
SPrint["Fruits: ", {Fruits}];

Vegetables = {"Carrot", "Tomato"};
SPrint["Vegetables: ", {Vegetables}];

CountryCapitalsInAsia = <|
    "Thailand" -> "Bangkok",
    "China" -> "Beijing",
    "Japan" -> "Tokyo"
|>;
Print["CountryCapitalsInAsia: ", PrettyJsonStringify[CountryCapitalsInAsia]];

CountryCapitalsInEurope = <|
    "France" -> "Paris",
    "England" -> "London"
|>;
Print["CountryCapitalsInEurope: ", PrettyJsonStringify[CountryCapitalsInEurope]];

Print["\n(* [...array1, ...array2]: *)\n"];

Combination1 = SpreadSyntaxArray[Fruits, Vegetables];
Print["Combination1: ", PrettyJsonStringify[Combination1]];
(*
Combination1: [
    "Mango",
    "Melon",
    "Banana",
    "Carrot",
    "Tomato"
]
*)

Combination2 = SpreadSyntaxArray[Fruits, {"Cucumber", "Cabbage"}];
Print["Combination2: ", PrettyJsonStringify[Combination2]];
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

Combination3 = SpreadSyntaxObject[CountryCapitalsInAsia, CountryCapitalsInEurope];
Print["Combination3: ", PrettyJsonStringify[Combination3]];
(*
Combination3: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "France": "Paris",
    "England": "London"
}
*)

Combination4 = SpreadSyntaxObject[CountryCapitalsInAsia, <|"Germany" -> "Berlin", "Italy" -> "Rome"|>];
Print["Combination4: ", PrettyJsonStringify[Combination4]];
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

Combination5 = SpreadSyntaxArray[Fruits, <|"Vegetables" -> Vegetables|>];
Print["Combination5: ", PrettyJsonStringify[Combination5]];
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

Combination6 = SpreadSyntaxArray[Fruits, <|"Vegetables" -> {"Cucumber", "Cabbage"}|>];
Print["Combination6: ", PrettyJsonStringify[Combination6]];
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

Combination7 = SpreadSyntaxArray[Fruits, <|"CountryCapitalsInAsia" -> CountryCapitalsInAsia|>];
Print["Combination7: ", PrettyJsonStringify[Combination7]];
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

Combination8 = SpreadSyntaxArray[Fruits, <|"CountryCapitalsInEurope" -> <|"Germany" -> "Berlin", "Italy" -> "Rome"|>|>];
Print["Combination8: ", PrettyJsonStringify[Combination8]];
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

Combination9 = SpreadSyntaxObject[CountryCapitalsInAsia, <|"CountryCapitalsInEurope" -> CountryCapitalsInEurope|>];
Print["Combination9: ", PrettyJsonStringify[Combination9]];
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

Combination10 = SpreadSyntaxObject[CountryCapitalsInAsia, <|"CountryCapitalsInEurope" -> <|"Germany" -> "Berlin", "Italy" -> "Rome"|>|>];
Print["Combination10: ", PrettyJsonStringify[Combination10]];
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

Combination11 = SpreadSyntaxObject[CountryCapitalsInAsia, <|"Vegetables" -> Vegetables|>];
Print["Combination11: ", PrettyJsonStringify[Combination11]];
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

Combination12 = SpreadSyntaxObject[CountryCapitalsInAsia, <|"Vegetables" -> {"Cucumber", "Cabbage"}|>];
Print["Combination12: ", PrettyJsonStringify[Combination12]];
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

Combination13 = SpreadSyntaxObject[CountryCapitalsInAsia, Vegetables];
Print["Combination13: ", PrettyJsonStringify[Combination13]];
(*
Combination13: {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
    "1": "Carrot",
    "2": "Tomato"
}
*)

Combination14 = SpreadSyntaxObject[CountryCapitalsInAsia, {"Cucumber", "Cabbage"}];
Print["Combination14: ", PrettyJsonStringify[Combination14]];
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
(* CombinationErrorInJavascript1 = SpreadSyntaxArray[Fruits, CountryCapitalsInAsia]; *)
(* Print["CombinationErrorInJavascript1: ", PrettyJsonStringify[CombinationErrorInJavascript1]]; *)

(* this Combination throw an error in JavaScript *)
(* CombinationErrorInJavascript2 = SpreadSyntaxArray[Fruits, <|"Germany" -> "Berlin", "Italy" -> "Rome"|>]; *)
(* Print["CombinationErrorInJavascript2: ", PrettyJsonStringify[CombinationErrorInJavascript2]]; *)
