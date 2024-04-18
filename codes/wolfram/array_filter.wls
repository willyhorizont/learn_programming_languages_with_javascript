JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

ArrayFilterV1 = (Module[{CallbackFunction = #1, AnArray = #2, DataFiltered},
    (* JavaScript-like Array.filter() function *)
    DataFiltered = {};
    Module[{ArrayItem, ArrayItemIndex, IsConditionMatch},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == True),
                DataFiltered = Append[DataFiltered, ArrayItem];
            ];
        ];
    ];
    Return[DataFiltered, Module];
] &);

ArrayFilterV2 = (Module[{CallbackFunction = #1, AnArray = #2, DataFiltered},
    (* JavaScript-like Array.filter() function *)
    DataFiltered = {};
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            If[(CallbackFunction[ArrayItem, ArrayItemIndex, AnArray] == True),
                DataFiltered = Append[DataFiltered, ArrayItem];
            ];
        ];
    ];
    Return[DataFiltered, Module];
] &);

Print["\n(* JavaScript-like Array.filter() in in Wolfram List *)"];

Numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
Print["Numbers: ", JsonStringify[Numbers]];

Print["(* using JavaScript-like Array.filter() function \"ArrayFilterV1\" *)"];

NumbersEven = ArrayFilterV1[(Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &), Numbers];
Print["even numbers only: ", JsonStringify[NumbersEven]];
(* even numbers only: [12, 34, 36, 4, 254] *)

NumbersOdd = ArrayFilterV1[(Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &), Numbers];
Print["odd numbers only: ", JsonStringify[NumbersOdd]];
(* odd numbers only: [27, 23, 65, 93, 87] *)

Print["(* using JavaScript-like Array.filter() function \"ArrayFilterV2\" *)"];

NumbersEven = ArrayFilterV2[(Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &), Numbers];
Print["even numbers only: ", JsonStringify[NumbersEven]];
(* even numbers only: [12, 34, 36, 4, 254] *)

NumbersOdd = ArrayFilterV2[(Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &), Numbers];
Print["odd numbers only: ", JsonStringify[NumbersOdd]];
(* odd numbers only: [27, 23, 65, 93, 87] *)

Print["(* using Wolfram Array.filter() built-in function \"Select[]\" *)"];

NumbersEven = Select[Numbers, (Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &)];
Print["even numbers only: ", JsonStringify[NumbersEven]];
(* even numbers only: [12, 34, 36, 4, 254] *)

NumbersOdd = Select[Numbers, (Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &)];
Print["odd numbers only: ", JsonStringify[NumbersOdd]];
(* odd numbers only: [27, 23, 65, 93, 87] *)

Print["(* using Wolfram Array.filter() built-in function \"Cases[]\", BlankSequence Operator (_) and PatternTest Operator (?) *)"];

NumbersEven = Cases[Numbers, _?(Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &)];
Print["even numbers only: ", JsonStringify[NumbersEven]];
(* even numbers only: [12, 34, 36, 4, 254] *)

NumbersOdd = Cases[Numbers, _?(Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &)];
Print["odd numbers only: ", JsonStringify[NumbersOdd]];
(* odd numbers only: [27, 23, 65, 93, 87] *)

Print["\n(* JavaScript-like Array.filter() in in Wolfram List of Associations *)"];

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

Print["(* using JavaScript-like Array.filter() function \"ArrayFilterV1\" *)"];

ProductBelow100 = ArrayFilterV1[(Module[{AProduct = #1}, (AProduct[["price"]] <= 100)] &), Products];
Print["products with price <= 100 only: ", JsonStringify[ProductBelow100, "Pretty" -> True]];
(*
products with price <= 100 only: [
    {
        "code": "potato_chips",
        "price": 5
    }
]
*)

ProductAbove100 = ArrayFilterV1[(Module[{AProduct = #1}, (AProduct[["price"]] > 100)] &), Products];
Print["products with price > 100 only: ", JsonStringify[ProductAbove100, "Pretty" -> True]];
(*
products with price > 100 only: [
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
]
*)

Print["(* using JavaScript-like Array.filter() function \"ArrayFilterV2\" *)"];

ProductBelow100 = ArrayFilterV2[(Module[{AProduct = #1}, (AProduct[["price"]] <= 100)] &), Products];
Print["products with price <= 100 only: ", JsonStringify[ProductBelow100, "Pretty" -> True]];
(*
products with price <= 100 only: [
    {
        "code": "potato_chips",
        "price": 5
    }
]
*)

ProductAbove100 = ArrayFilterV2[(Module[{AProduct = #1}, (AProduct[["price"]] > 100)] &), Products];
Print["products with price > 100 only: ", JsonStringify[ProductAbove100, "Pretty" -> True]];
(*
products with price > 100 only: [
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
]
*)

Print["(* using Wolfram Array.filter() built-in function \"Select[]\" *)"];

ProductBelow100 = Select[Products, (Module[{AProduct = #1}, (AProduct[["price"]] <= 100)] &)];
Print["products with price <= 100 only: ", JsonStringify[ProductBelow100, "Pretty" -> True]];
(*
products with price <= 100 only: [
    {
        "code": "potato_chips",
        "price": 5
    }
]
*)

ProductAbove100 = Select[Products, (Module[{AProduct = #1}, (AProduct[["price"]] > 100)] &)];
Print["products with price > 100 only: ", JsonStringify[ProductAbove100, "Pretty" -> True]];
(*
products with price > 100 only: [
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
]
*)

Print["(* using Wolfram Array.filter() built-in function \"Cases[]\", BlankSequence Operator (_) and PatternTest Operator (?) *)"];

ProductBelow100 = Cases[Products, _?(Module[{AProduct = #1}, (AProduct[["price"]] <= 100)] &)];
Print["products with price <= 100 only: ", JsonStringify[ProductBelow100, "Pretty" -> True]];
(*
products with price <= 100 only: [
    {
        "code": "potato_chips",
        "price": 5
    }
]
*)

ProductAbove100 = Cases[Products, _?(Module[{AProduct = #1}, (AProduct[["price"]] > 100)] &)];
Print["products with price > 100 only: ", JsonStringify[ProductAbove100, "Pretty" -> True]];
(*
products with price > 100 only: [
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
]
*)
