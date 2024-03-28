PrettyJsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> "    "]] &);

JsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

SPrint = (Module[{AParameters = {##}}, Print[StringJoin[MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]}, If[((ArrayQ[ArrayItem] == True) && Length[ArrayItem] == 1), JsonStringify[ArrayItem[[1]]], If[(StringQ[ArrayItem] == True), ArrayItem, ""]]] &), AParameters]]]] &);

ArrayEveryV1 = (Module[{CallbackFunction = #1, AnArray = #2, IsConditionMatch},
    (* JavaScript-like Array.every() function *)
    IsConditionMatch = False;
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == False), Break[]];
        ];
    ];
    Return[IsConditionMatch, Module];
] &);

ArrayEveryV2 = (Module[{CallbackFunction = #1, AnArray = #2, IsConditionMatch},
    (* JavaScript-like Array.every() function *)
    IsConditionMatch = False;
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == False), Return[IsConditionMatch, Module]];
        ];
    ];
    Return[IsConditionMatch, Module];
] &);

ArrayEveryV3 = (Module[{CallbackFunction = #1, AnArray = #2, IsConditionMatch},
    (* JavaScript-like Array.every() function *)
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == False), Return[False]];
        ];
    ];
    Return[True, Module];
] &);

ArrayEveryV4 = (Module[{CallbackFunction = #1, AnArray = #2},
    (* JavaScript-like Array.every() function *)
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            If[(CallbackFunction[ArrayItem, ArrayItemIndex, AnArray] == False), Return[False]];
        ];
    ];
    Return[True, Module];
] &);

Print["\n(* JavaScript-like Array.every() in in Wolfram List *)"];

Numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
SPrint["Numbers: ", {Numbers}];

Print["(* using JavaScript-like Array.every() function \"ArrayEveryV1\" *)"];

IsAllNumberLessThan500 = ArrayEveryV1[(Module[{ANumber = #1}, (ANumber < 500)] &), Numbers];
SPrint["is all ANumber < 500: ", {IsAllNumberLessThan500}];
(* is all ANumber < 500: true *)

IsAllNumberMoreThan500 = ArrayEveryV1[(Module[{ANumber = #1}, (ANumber > 500)] &), Numbers];
SPrint["is all ANumber > 500: ", {IsAllNumberMoreThan500}];
(* is all ANumber > 500: false *)

Print["(* using JavaScript-like Array.every() function \"ArrayEveryV2\" *)"];

IsAllNumberLessThan500 = ArrayEveryV2[(Module[{ANumber = #1}, (ANumber < 500)] &), Numbers];
SPrint["is all ANumber < 500: ", {IsAllNumberLessThan500}];
(* is all ANumber < 500: true *)

IsAllNumberMoreThan500 = ArrayEveryV2[(Module[{ANumber = #1}, (ANumber > 500)] &), Numbers];
SPrint["is all ANumber > 500: ", {IsAllNumberMoreThan500}];
(* is all ANumber > 500: false *)

Print["(* using JavaScript-like Array.every() function \"ArrayEveryV3\" *)"];

IsAllNumberLessThan500 = ArrayEveryV3[(Module[{ANumber = #1}, (ANumber < 500)] &), Numbers];
SPrint["is all ANumber < 500: ", {IsAllNumberLessThan500}];
(* is all ANumber < 500: true *)

IsAllNumberMoreThan500 = ArrayEveryV3[(Module[{ANumber = #1}, (ANumber > 500)] &), Numbers];
SPrint["is all ANumber > 500: ", {IsAllNumberMoreThan500}];
(* is all ANumber > 500: false *)

Print["(* using JavaScript-like Array.every() function \"ArrayEveryV4\" *)"];

IsAllNumberLessThan500 = ArrayEveryV4[(Module[{ANumber = #1}, (ANumber < 500)] &), Numbers];
SPrint["is all ANumber < 500: ", {IsAllNumberLessThan500}];
(* is all ANumber < 500: true *)

IsAllNumberMoreThan500 = ArrayEveryV4[(Module[{ANumber = #1}, (ANumber > 500)] &), Numbers];
SPrint["is all ANumber > 500: ", {IsAllNumberMoreThan500}];
(* is all ANumber > 500: false *)

Print["(* using Wolfram Array.every() built-in function \"AllTrue[]\" *)"];

IsAllNumberLessThan500 = AllTrue[Numbers, (Module[{ANumber = #1}, (ANumber < 500)] &)];
SPrint["is all ANumber < 500: ", {IsAllNumberLessThan500}];
(* is all ANumber < 500: true *)

IsAllNumberMoreThan500 = AllTrue[Numbers, (Module[{ANumber = #1}, (ANumber > 500)] &)];
SPrint["is all ANumber > 500: ", {IsAllNumberMoreThan500}];
(* is all ANumber > 500: false *)

Print["\n(* JavaScript-like Array.every() in in Wolfram List of Associations *)"];

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

Print["(* using JavaScript-like Array.every() function \"ArrayEveryV1\" *)"];

IsAllProductPriceLessThan500 = ArrayEveryV1[(Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &), Products];
SPrint["is all Product price < 500: ", {IsAllProductPriceLessThan500}];
(* is all Product price < 500: true *)

IsAllProductPriceMoreThan500 = ArrayEveryV1[(Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &), Products];
SPrint["is all Product price > 500: ", {IsAllProductPriceMoreThan500}];
(* is all Product price > 500: false *)

Print["(* using JavaScript-like Array.every() function \"ArrayEveryV2\" *)"];

IsAllProductPriceLessThan500 = ArrayEveryV2[(Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &), Products];
SPrint["is all Product price < 500: ", {IsAllProductPriceLessThan500}];
(* is all Product price < 500: true *)

IsAllProductPriceMoreThan500 = ArrayEveryV2[(Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &), Products];
SPrint["is all Product price > 500: ", {IsAllProductPriceMoreThan500}];
(* is all Product price > 500: false *)

Print["(* using JavaScript-like Array.every() function \"ArrayEveryV3\" *)"];

IsAllProductPriceLessThan500 = ArrayEveryV3[(Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &), Products];
SPrint["is all Product price < 500: ", {IsAllProductPriceLessThan500}];
(* is all Product price < 500: true *)

IsAllProductPriceMoreThan500 = ArrayEveryV3[(Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &), Products];
SPrint["is all Product price > 500: ", {IsAllProductPriceMoreThan500}];
(* is all Product price > 500: false *)

Print["(* using JavaScript-like Array.every() function \"ArrayEveryV4\" *)"];

IsAllProductPriceLessThan500 = ArrayEveryV4[(Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &), Products];
SPrint["is all Product price < 500: ", {IsAllProductPriceLessThan500}];
(* is all Product price < 500: true *)

IsAllProductPriceMoreThan500 = ArrayEveryV4[(Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &), Products];
SPrint["is all Product price > 500: ", {IsAllProductPriceMoreThan500}];
(* is all Product price > 500: false *)

Print["(* using Wolfram Array.every() built-in function \"AllTrue[]\" *)"];

IsAllProductPriceLessThan500 = AllTrue[Products, (Module[{AProduct = #1}, (AProduct[["price"]] < 500)] &)];
SPrint["is all Product price < 500: ", {IsAllProductPriceLessThan500}];
(* is all Product price < 500: true *)

IsAllProductPriceMoreThan500 = AllTrue[Products, (Module[{AProduct = #1}, (AProduct[["price"]] > 500)] &)];
SPrint["is all Product price > 500: ", {IsAllProductPriceMoreThan500}];
(* is all Product price > 500: false *)
