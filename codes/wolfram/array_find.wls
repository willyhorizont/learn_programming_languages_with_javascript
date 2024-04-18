JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

(* There's no JavaScript-like Array.find() in Wolfram. *)
(* But, we can create our own function to mimic it in Wolfram. *)

ArrayFindV1 = (Module[{CallbackFunction = #1, AnArray = #2, DataFound},
    (* JavaScript-like Array.find() function *)
    DataFound = Null;
    Module[{ArrayItem, ArrayItemIndex, IsConditionMatch},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == True),
                DataFound = ArrayItem;
                Break[];
            ];
        ];
    ];
    Return[DataFound, Module];
] &);

ArrayFindV2 = (Module[{CallbackFunction = #1, AnArray = #2, DataFound},
    (* JavaScript-like Array.find() function *)
    DataFound = Null;
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            If[(CallbackFunction[ArrayItem, ArrayItemIndex, AnArray] == True),
                DataFound = ArrayItem;
                Break[];
            ];
        ];
    ];
    Return[DataFound, Module];
] &);

ArrayFindV3 = (Module[{CallbackFunction = #1, AnArray = #2},
    (* JavaScript-like Array.find() function *)
    Module[{ArrayItem, ArrayItemIndex, IsConditionMatch},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == True), Return[ArrayItem]];
        ];
    ];
    Return[Null, Module];
] &);

ArrayFindV4 = (Module[{CallbackFunction = #1, AnArray = #2},
    (* JavaScript-like Array.find() function *)
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            If[(CallbackFunction[ArrayItem, ArrayItemIndex, AnArray] == True), Return[ArrayItem]];
        ];
    ];
    Return[Null, Module];
] &);

Print["\n(* JavaScript-like Array.find() in in Wolfram List *)"];

Numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
Print["Numbers: ", JsonStringify[Numbers]];

Print["(* using JavaScript-like Array.find() function \"ArrayFindV1\" *)"];

EvenNumberFound = ArrayFindV1[(Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &), Numbers];
Print["even number found: ", EvenNumberFound];
(* even number found: 12 *)

OddNumberFound = ArrayFindV1[(Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &), Numbers];
Print["odd number found: ", OddNumberFound];
(* odd number found: 27 *)

Print["(* using JavaScript-like Array.find() function \"ArrayFindV2\" *)"];

EvenNumberFound = ArrayFindV2[(Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &), Numbers];
Print["even number found: ", EvenNumberFound];
(* even number found: 12 *)

OddNumberFound = ArrayFindV2[(Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &), Numbers];
Print["odd number found: ", OddNumberFound];
(* odd number found: 27 *)

Print["(* using JavaScript-like Array.find() function \"ArrayFindV3\" *)"];

EvenNumberFound = ArrayFindV3[(Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &), Numbers];
Print["even number found: ", EvenNumberFound];
(* even number found: 12 *)

OddNumberFound = ArrayFindV3[(Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &), Numbers];
Print["odd number found: ", OddNumberFound];
(* odd number found: 27 *)

Print["(* using JavaScript-like Array.find() function \"ArrayFindV4\" *)"];

EvenNumberFound = ArrayFindV4[(Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &), Numbers];
Print["even number found: ", EvenNumberFound];
(* even number found: 12 *)

OddNumberFound = ArrayFindV4[(Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &), Numbers];
Print["odd number found: ", OddNumberFound];
(* odd number found: 27 *)

Print["(* using Wolfram Array.find() built-in function \"SelectFirst[]\" *)"];

EvenNumberFound = SelectFirst[Numbers, (Module[{ANumber = #1}, (Mod[ANumber, 2] == 0)] &)];
Print["even number found: ", EvenNumberFound];
(* even number found: 12 *)

OddNumberFound = SelectFirst[Numbers, (Module[{ANumber = #1}, (Mod[ANumber, 2] != 0)] &)];
Print["odd number found: ", OddNumberFound];
(* odd number found: 27 *)

Print["\n(* JavaScript-like Array.find() in in Wolfram List of Associations *)"];

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

ProductToFind = "bubble_gum";
Print["ProductToFind: ", JsonStringify[ProductToFind]];

Print["(* using JavaScript-like Array.find() function \"ArrayFindV1\" *)"];

ProductFound = ArrayFindV1[(Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &), Products];
Print["product found: ", JsonStringify[ProductFound, "Pretty" -> True]];
(*
product found: {
    "code":"bubble_gum",
    "price": 233
}
*)

Print["(* using JavaScript-like Array.find() function \"ArrayFindV2\" *)"];

ProductFound = ArrayFindV2[(Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &), Products];
Print["product found: ", JsonStringify[ProductFound, "Pretty" -> True]];
(*
product found: {
    "code":"bubble_gum",
    "price": 233
}
*)

Print["(* using JavaScript-like Array.find() function \"ArrayFindV3\" *)"];

ProductFound = ArrayFindV3[(Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &), Products];
Print["product found: ", JsonStringify[ProductFound, "Pretty" -> True]];
(*
product found: {
    "code":"bubble_gum",
    "price": 233
}
*)

Print["(* using JavaScript-like Array.find() function \"ArrayFindV4\" *)"];

ProductFound = ArrayFindV4[(Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &), Products];
Print["product found: ", JsonStringify[ProductFound, "Pretty" -> True]];
(*
product found: {
    "code":"bubble_gum",
    "price": 233
}
*)

Print["(* using Wolfram Array.find() built-in function \"SelectFirst[]\" *)"];

ProductFound = SelectFirst[Products, (Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &)];
Print["product found: ", JsonStringify[ProductFound, "Pretty" -> True]];
(*
product found: {
    "code":"bubble_gum",
    "price": 233
}
*)
