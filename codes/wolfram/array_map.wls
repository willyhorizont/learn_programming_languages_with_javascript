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

ArrayMapV1 = (Module[{CallbackFunction = #1, AnArray = #2, NewArray},
    (* JavaScript-like Array.map() function *)
    NewArray = {};
    Module[{ArrayItem, ArrayItemIndex, NewArrayItem},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            NewArrayItem = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            NewArray = Append[NewArray, NewArrayItem];
        ];
    ];
    Return[NewArray, Module];
] &);

ArrayMapV2 = (Module[{CallbackFunction = #1, AnArray = #2, NewArray},
    (* JavaScript-like Array.map() function *)
    NewArray = {};
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            NewArray = Append[NewArray, CallbackFunction[ArrayItem, ArrayItemIndex, AnArray]];
        ];
    ];
    Return[NewArray, Module];
] &);

Print["\n(* JavaScript-like Array.map() in in Wolfram List *)"];

Numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
SPrint["Numbers: ", {Numbers}];

Print["(* using JavaScript-like Array.map() function \"ArrayMapV1\" *)"];

NumbersLabeled = ArrayMapV1[(Module[{ANumber = #1}, <|ToString[ANumber] -> If[(Mod[ANumber, 2] == 0), "even", "odd"]|>] &), Numbers];
Print["labeled numbers: ", PrettyJsonStringify[NumbersLabeled]];
(*
labeled numbers: [
    {
        "12": "even"
    },
    {
        "34": "even"
    },
    {
        "27": "odd"
    },
    {
        "23": "odd"
    },
    {
        "65": "odd"
    },
    {
        "93": "odd"
    },
    {
        "36": "even"
    },
    {
        "87": "odd"
    },
    {
        "4": "even"
    },
    {
        "254": "even"
    }
]
*)

Print["(* using JavaScript-like Array.map() function \"ArrayMapV2\" *)"];

NumbersLabeled = ArrayMapV2[(Module[{ANumber = #1}, <|ToString[ANumber] -> If[(Mod[ANumber, 2] == 0), "even", "odd"]|>] &), Numbers];
Print["labeled numbers: ", PrettyJsonStringify[NumbersLabeled]];
(*
labeled numbers: [
    {
        "12": "even"
    },
    {
        "34": "even"
    },
    {
        "27": "odd"
    },
    {
        "23": "odd"
    },
    {
        "65": "odd"
    },
    {
        "93": "odd"
    },
    {
        "36": "even"
    },
    {
        "87": "odd"
    },
    {
        "4": "even"
    },
    {
        "254": "even"
    }
]
*)

Print["(* using Wolfram Array.map() built-in function \"Map[]\" *)"];

NumbersLabeled = Map[(Module[{ANumber = #1}, <|ToString[ANumber] -> If[(Mod[ANumber, 2] == 0), "even", "odd"]|>] &), Numbers];
Print["labeled numbers: ", PrettyJsonStringify[NumbersLabeled]];
(*
labeled numbers: [
    {
        "12": "even"
    },
    {
        "34": "even"
    },
    {
        "27": "odd"
    },
    {
        "23": "odd"
    },
    {
        "65": "odd"
    },
    {
        "93": "odd"
    },
    {
        "36": "even"
    },
    {
        "87": "odd"
    },
    {
        "4": "even"
    },
    {
        "254": "even"
    }
]
*)

Print["(* using Wolfram Array.map() built-in function \"MapIndexed[]\" *)"];

NumbersLabeled = MapIndexed[(Module[{ANumber = #1}, <|ToString[ANumber] -> If[(Mod[ANumber, 2] == 0), "even", "odd"]|>] &), Numbers];
Print["labeled numbers: ", PrettyJsonStringify[NumbersLabeled]];
(*
labeled numbers: [
    {
        "12": "even"
    },
    {
        "34": "even"
    },
    {
        "27": "odd"
    },
    {
        "23": "odd"
    },
    {
        "65": "odd"
    },
    {
        "93": "odd"
    },
    {
        "36": "even"
    },
    {
        "87": "odd"
    },
    {
        "4": "even"
    },
    {
        "254": "even"
    }
]
*)

Print["\n(* JavaScript-like Array.map() in in Wolfram List of Associations *)"];

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

Print["(* using JavaScript-like Array.map() function \"ArrayMapV1\" *)"];

ProductLabeled = ArrayMapV1[(Module[{AProduct = #1}, SpreadSyntaxObject[AProduct, <|"label" -> If[(AProduct[["price"]] > 100), "expensive", "cheap"]|>]] &), Products];
Print["labeled products: ", PrettyJsonStringify[ProductLabeled]];
(*
labeled products: [
    {
        "code": "pasta",
        "price": 321,
        "label": "expensive"
    },
    {
        "code": "bubble_gum",
        "price": 233,
        "label": "expensive"
    },
    {
        "code": "potato_chips",
        "price": 5,
        "label": "cheap"
    },
    {
        "code": "towel",
        "price": 499,
        "label": "expensive"
    }
]
*)

Print["(* using JavaScript-like Array.map() function \"ArrayMapV2\" *)"];

ProductLabeled = ArrayMapV2[(Module[{AProduct = #1}, SpreadSyntaxObject[AProduct, <|"label" -> If[(AProduct[["price"]] > 100), "expensive", "cheap"]|>]] &), Products];
Print["labeled products: ", PrettyJsonStringify[ProductLabeled]];
(*
labeled products: [
    {
        "code": "pasta",
        "price": 321,
        "label": "expensive"
    },
    {
        "code": "bubble_gum",
        "price": 233,
        "label": "expensive"
    },
    {
        "code": "potato_chips",
        "price": 5,
        "label": "cheap"
    },
    {
        "code": "towel",
        "price": 499,
        "label": "expensive"
    }
]
*)

Print["(* using Wolfram Array.map() built-in function \"Map[]\" *)"];

ProductLabeled = Map[(Module[{AProduct = #1}, SpreadSyntaxObject[AProduct, <|"label" -> If[(AProduct[["price"]] > 100), "expensive", "cheap"]|>]] &), Products];
Print["labeled products: ", PrettyJsonStringify[ProductLabeled]];
(*
labeled products: [
    {
        "code": "pasta",
        "price": 321,
        "label": "expensive"
    },
    {
        "code": "bubble_gum",
        "price": 233,
        "label": "expensive"
    },
    {
        "code": "potato_chips",
        "price": 5,
        "label": "cheap"
    },
    {
        "code": "towel",
        "price": 499,
        "label": "expensive"
    }
]
*)

Print["(* using Wolfram Array.map() built-in function \"MapIndexed[]\" *)"];

ProductLabeled = MapIndexed[(Module[{AProduct = #1}, SpreadSyntaxObject[AProduct, <|"label" -> If[(AProduct[["price"]] > 100), "expensive", "cheap"]|>]] &), Products];
Print["labeled products: ", PrettyJsonStringify[ProductLabeled]];
(*
labeled products: [
    {
        "code": "pasta",
        "price": 321,
        "label": "expensive"
    },
    {
        "code": "bubble_gum",
        "price": 233,
        "label": "expensive"
    },
    {
        "code": "potato_chips",
        "price": 5,
        "label": "cheap"
    },
    {
        "code": "towel",
        "price": 499,
        "label": "expensive"
    }
]
*)
