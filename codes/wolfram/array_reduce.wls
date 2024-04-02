PrettyJsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> "    "]] &);

JsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

SPrint = (Module[{AParameters = {##}}, Print[StringJoin[MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]}, If[((ArrayQ[ArrayItem] == True) && Length[ArrayItem] == 1), JsonStringify[ArrayItem[[1]]], If[(StringQ[ArrayItem] == True), ArrayItem, ""]]] &), AParameters]]]] &);

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

ArrayReduceV2 = (Module[{CallbackFunction = #1, AnArray = #2, InitialValue = #3, Result},
    (* JavaScript-like Array.reduce() function *)
    Result = InitialValue;
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            Result = CallbackFunction[Result, ArrayItem, ArrayItemIndex, AnArray];
        ];
    ];
    Return[Result, Module];
] &);

Print["\n(* JavaScript-like Array.reduce() in in Wolfram List *)"];

Numbers = {36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3};
SPrint["Numbers: ", {Numbers}];

Print["(* using JavaScript-like Array.reduce() function \"ArrayReduceV2\" *)"];

NumbersTotal = ArrayReduceV2[(Module[{CurrentResult = #1, CurrentNumber = #2}, (CurrentResult + CurrentNumber)] &), Numbers, 0];
Print["total number: ", NumbersTotal];
(* total number: 41.2 *)

Print["(* using Wolfram Array.reduce() built-in function \"Fold[]\" *)"];

NumbersTotal = Fold[(Module[{CurrentResult = #1, CurrentNumber = #2}, (CurrentResult + CurrentNumber)] &), 0, Numbers];
Print["total number: ", NumbersTotal];
(* total number: 41.2 *)

Print["\n(* JavaScript-like Array.reduce() in in Wolfram List of Associations *)"];

Products = {
    <|
        "code" -> "pasta",
        "price" -> 321
    |>,
    <|
        "code" -> "bubble_gum",
        "price" -> 233
    |>,
    <|
        "code" -> "potato_chips",
        "price" -> 5
    |>,
    <|
        "code" -> "towel",
        "price" -> 499
    |>
};
Print["Products: ", PrettyJsonStringify[Products]];

Print["(* using JavaScript-like Array.reduce() function \"ArrayReduceV2\" *)"];

ProductGrouped = ArrayReduceV2[(Module[{CurrentResult = #1, CurrentProduct = #2}, If[(CurrentProduct[["price"]] > 100), SpreadSyntaxObject[CurrentResult, <|"expensive" -> SpreadSyntaxArray[CurrentResult[["expensive"]], <|"CurrentProduct" -> CurrentProduct|>]|>], SpreadSyntaxObject[CurrentResult, <|"cheap" -> SpreadSyntaxArray[CurrentResult[["cheap"]], <|"CurrentProduct" -> CurrentProduct|>]|>]]] &), Products, <|"expensive" -> {}, "cheap" -> {}|>];
Print["grouped products: ", PrettyJsonStringify[ProductGrouped]];
(*
grouped products: {
    "expensive": [
        {
            "code": "pasta",
            "price": 321
        },
        {
            "code": "bubble_gum",
            "price": 233
        },
        {
            "code": "towel",
            "price": 499
        }
    ],
    "cheap": [
        {
            "code": "potato_chips",
            "price": 5
        }
    ]
}
*)

Print["(* using Wolfram Array.reduce() built-in function \"Fold[]\" *)"];

ProductGrouped = Fold[(Module[{CurrentResult = #1, CurrentProduct = #2}, If[(CurrentProduct[["price"]] > 100), SpreadSyntaxObject[CurrentResult, <|"expensive" -> SpreadSyntaxArray[CurrentResult[["expensive"]], <|"CurrentProduct" -> CurrentProduct|>]|>], SpreadSyntaxObject[CurrentResult, <|"cheap" -> SpreadSyntaxArray[CurrentResult[["cheap"]], <|"CurrentProduct" -> CurrentProduct|>]|>]]] &), <|"expensive" -> {}, "cheap" -> {}|>, Products];
Print["grouped products: ", PrettyJsonStringify[ProductGrouped]];
(*
grouped products: {
    "expensive": [
        {
            "code": "pasta",
            "price": 321
        },
        {
            "code": "bubble_gum",
            "price": 233
        },
        {
            "code": "towel",
            "price": 499
        }
    ],
    "cheap": [
        {
            "code": "potato_chips",
            "price": 5
        }
    ]
}
*)
