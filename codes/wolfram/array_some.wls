JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

ArraySomeV1 = (Module[{CallbackFunction = #1, AnArray = #2, IsConditionMatch},
    (* JavaScript-like Array.some() function *)
    IsConditionMatch = False;
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == True), Break[]];
        ];
    ];
    Return[IsConditionMatch, Module];
] &);

ArraySomeV2 = (Module[{CallbackFunction = #1, AnArray = #2, IsConditionMatch},
    (* JavaScript-like Array.some() function *)
    IsConditionMatch = False;
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == True), Return[IsConditionMatch]];
        ];
    ];
    Return[IsConditionMatch, Module];
] &);

ArraySomeV3 = (Module[{CallbackFunction = #1, AnArray = #2, IsConditionMatch},
    (* JavaScript-like Array.some() function *)
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == True), Return[True]];
        ];
    ];
    Return[False, Module];
] &);

ArraySomeV4 = (Module[{CallbackFunction = #1, AnArray = #2},
    (* JavaScript-like Array.some() function *)
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            If[(CallbackFunction[ArrayItem, ArrayItemIndex, AnArray] == True), Return[True]];
        ];
    ];
    Return[False, Module];
] &);

Print["\n(* JavaScript-like Array.some() in in Wolfram List *)"];

Numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
Print["Numbers: ", JsonStringify[Numbers]];

Print["(* using JavaScript-like Array.some() function \"ArraySomeV1\" *)"];

IsAnyNumberLessThan500 = ArraySomeV1[(Module[{ANumber = #1}, (ANumber < 500)] &), Numbers];
Print["is any ANumber < 500: ", IsAnyNumberLessThan500];
(* is any ANumber < 500: true *)

IsAnyNumberMoreThan500 = ArraySomeV1[(Module[{ANumber = #1}, (ANumber > 500)] &), Numbers];
Print["is any ANumber > 500: ", IsAnyNumberMoreThan500];
(* is any ANumber > 500: false *)

Print["(* using JavaScript-like Array.some() function \"ArraySomeV2\" *)"];

IsAnyNumberLessThan500 = ArraySomeV2[(Module[{ANumber = #1}, (ANumber < 500)] &), Numbers];
Print["is any ANumber < 500: ", IsAnyNumberLessThan500];
(* is any ANumber < 500: true *)

IsAnyNumberMoreThan500 = ArraySomeV2[(Module[{ANumber = #1}, (ANumber > 500)] &), Numbers];
Print["is any ANumber > 500: ", IsAnyNumberMoreThan500];
(* is any ANumber > 500: false *)

Print["(* using JavaScript-like Array.some() function \"ArraySomeV3\" *)"];

IsAnyNumberLessThan500 = ArraySomeV3[(Module[{ANumber = #1}, (ANumber < 500)] &), Numbers];
Print["is any ANumber < 500: ", IsAnyNumberLessThan500];
(* is any ANumber < 500: true *)

IsAnyNumberMoreThan500 = ArraySomeV3[(Module[{ANumber = #1}, (ANumber > 500)] &), Numbers];
Print["is any ANumber > 500: ", IsAnyNumberMoreThan500];
(* is any ANumber > 500: false *)

Print["(* using JavaScript-like Array.some() function \"ArraySomeV4\" *)"];

IsAnyNumberLessThan500 = ArraySomeV4[(Module[{ANumber = #1}, (ANumber < 500)] &), Numbers];
Print["is any ANumber < 500: ", IsAnyNumberLessThan500];
(* is any ANumber < 500: true *)

IsAnyNumberMoreThan500 = ArraySomeV4[(Module[{ANumber = #1}, (ANumber > 500)] &), Numbers];
Print["is any ANumber > 500: ", IsAnyNumberMoreThan500];
(* is any ANumber > 500: false *)

Print["(* using Wolfram Array.some() built-in function \"AnyTrue[]\" *)"];

IsAnyNumberLessThan500 = AnyTrue[Numbers, (Module[{ANumber = #1}, (ANumber < 500)] &)];
Print["is any ANumber < 500: ", IsAnyNumberLessThan500];
(* is any ANumber < 500: true *)

IsAnyNumberMoreThan500 = AnyTrue[Numbers, (Module[{ANumber = #1}, (ANumber > 500)] &)];
Print["is any ANumber > 500: ", IsAnyNumberMoreThan500];
(* is any ANumber > 500: false *)

Print["\n(* JavaScript-like Array.some() in in Wolfram List of Associations *)"];

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

Print["(* using JavaScript-like Array.some() function \"ArraySomeV1\" *)"];

IsAnyProductPriceLessThan500 = ArraySomeV1[(Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &), Products];
Print["is any Product price < 500: ", IsAnyProductPriceLessThan500];
(* is any Product price < 500: true *)

IsAnyProductPriceMoreThan500 = ArraySomeV1[(Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &), Products];
Print["is any Product price > 500: ", IsAnyProductPriceMoreThan500];
(* is any Product price > 500: false *)

Print["(* using JavaScript-like Array.some() function \"ArraySomeV2\" *)"];

IsAnyProductPriceLessThan500 = ArraySomeV2[(Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &), Products];
Print["is any Product price < 500: ", IsAnyProductPriceLessThan500];
(* is any Product price < 500: true *)

IsAnyProductPriceMoreThan500 = ArraySomeV2[(Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &), Products];
Print["is any Product price > 500: ", IsAnyProductPriceMoreThan500];
(* is any Product price > 500: false *)

Print["(* using JavaScript-like Array.some() function \"ArraySomeV3\" *)"];

IsAnyProductPriceLessThan500 = ArraySomeV3[(Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &), Products];
Print["is any Product price < 500: ", IsAnyProductPriceLessThan500];
(* is any Product price < 500: true *)

IsAnyProductPriceMoreThan500 = ArraySomeV3[(Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &), Products];
Print["is any Product price > 500: ", IsAnyProductPriceMoreThan500];
(* is any Product price > 500: false *)

Print["(* using JavaScript-like Array.some() function \"ArraySomeV4\" *)"];

IsAnyProductPriceLessThan500 = ArraySomeV4[(Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &), Products];
Print["is any Product price < 500: ", IsAnyProductPriceLessThan500];
(* is any Product price < 500: true *)

IsAnyProductPriceMoreThan500 = ArraySomeV4[(Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &), Products];
Print["is any Product price > 500: ", IsAnyProductPriceMoreThan500];
(* is any Product price > 500: false *)

Print["(* using Wolfram Array.some() built-in function \"AnyTrue[]\" *)"];

IsAnyProductPriceLessThan500 = AnyTrue[Products, (Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &)];
Print["is any Product price < 500: ", IsAnyProductPriceLessThan500];
(* is any Product price < 500: true *)

IsAnyProductPriceMoreThan500 = AnyTrue[Products, (Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &)];
Print["is any Product price > 500: ", IsAnyProductPriceMoreThan500];
(* is any Product price > 500: false *)
