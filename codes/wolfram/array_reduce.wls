JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

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
Print["Numbers: ", JsonStringify[Numbers]];

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
Print["Products: ", JsonStringify[Products, "Pretty" -> True]];

Print["(* using JavaScript-like Array.reduce() function \"ArrayReduceV2\" *)"];

ProductGrouped = ArrayReduceV2[(Module[{CurrentResult = #1, CurrentProduct = #2}, If[(CurrentProduct[["price"]] > 100), Join[<||>, CurrentResult, <|"expensive" -> Join[{}, CurrentResult[["expensive"]], {CurrentProduct}]|>], Join[<||>, CurrentResult, <|"cheap" -> Join[{}, CurrentResult[["cheap"]], {CurrentProduct}]|>]]] &), Products, <|"expensive" -> {}, "cheap" -> {}|>];
Print["grouped products: ", JsonStringify[ProductGrouped, "Pretty" -> True]];
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

ProductGrouped = Fold[(Module[{CurrentResult = #1, CurrentProduct = #2}, If[(CurrentProduct[["price"]] > 100), Join[<||>, CurrentResult, <|"expensive" -> Join[{}, CurrentResult[["expensive"]], {CurrentProduct}]|>], Join[<||>, CurrentResult, <|"cheap" -> Join[{}, CurrentResult[["cheap"]], {CurrentProduct}]|>]]] &), <|"expensive" -> {}, "cheap" -> {}|>, Products];
Print["grouped products: ", JsonStringify[ProductGrouped, "Pretty" -> True]];
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
