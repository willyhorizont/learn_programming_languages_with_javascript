PrettyJsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON"], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> "    "]] &);

JsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

SPrint = (Module[{AParameters = {##}}, Print[StringJoin[MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]}, If[((ArrayQ[ArrayItem] == True) && Length[ArrayItem] == 1), JsonStringify[ArrayItem[[1]]], If[(StringQ[ArrayItem] == True), ArrayItem, ""]]] &), AParameters]]]] &);

(* There's no JavaScript-like Array.findIndex() in Wolfram. *)
(* But, we can create our own function to mimic it in Wolfram. *)

ArrayFindIndexV1 = (Module[{CallbackFunction = #1, AnArray = #2, DataFoundIndex},
    (* JavaScript-like Array.findIndex() function *)
    DataFoundIndex = -1;
    Module[{ArrayItem, ArrayItemIndex, IsConditionMatch},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == True),
                DataFoundIndex = ArrayItemIndex;
                Break[];
            ];
        ];
    ];
    Return[DataFoundIndex, Module];
] &);

ArrayFindIndexV2 = (Module[{CallbackFunction = #1, AnArray = #2, DataFoundIndex},
    (* JavaScript-like Array.findIndex() function *)
    DataFoundIndex = -1;
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            If[(CallbackFunction[ArrayItem, ArrayItemIndex, AnArray] == True),
                DataFoundIndex = ArrayItemIndex;
                Break[];
            ];
        ];
    ];
    Return[DataFoundIndex, Module];
] &);

ArrayFindIndexV3 = (Module[{CallbackFunction = #1, AnArray = #2},
    (* JavaScript-like Array.findIndex() function *)
    Module[{ArrayItem, ArrayItemIndex, IsConditionMatch},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            IsConditionMatch = CallbackFunction[ArrayItem, ArrayItemIndex, AnArray];
            If[(IsConditionMatch == True), Return[ArrayItemIndex]];
        ];
    ];
    Return[-1, Module];
] &);

ArrayFindIndexV4 = (Module[{CallbackFunction = #1, AnArray = #2},
    (* JavaScript-like Array.findIndex() function *)
    Module[{ArrayItem, ArrayItemIndex},
        For[ArrayItemIndex = 1, (ArrayItemIndex <= Length[AnArray]), ArrayItemIndex += 1,
            ArrayItem = AnArray[[ArrayItemIndex]];
            If[(CallbackFunction[ArrayItem, ArrayItemIndex, AnArray] == True), Return[ArrayItemIndex]];
        ];
    ];
    Return[-1, Module];
] &);

Print["\n(* JavaScript-like Array.findIndex() in in Wolfram List *)"];

Numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
SPrint["Numbers: ", {Numbers}];

NumberToFind = 27;
Print["NumberToFind: ", NumberToFind];

Print["(* using JavaScript-like Array.findIndex() function \"ArrayFindIndexV1\" *)"];

NumberFoundIndex = ArrayFindIndexV1[(Module[{ANumber = #1}, (ANumber == NumberToFind)] &), Numbers];
SPrint["number found index: ", {NumberFoundIndex}];
(* number found index: 3 *)

Print["(* using JavaScript-like Array.findIndex() function \"ArrayFindIndexV2\" *)"];

NumberFoundIndex = ArrayFindIndexV2[(Module[{ANumber = #1}, (ANumber == NumberToFind)] &), Numbers];
SPrint["number found index: ", {NumberFoundIndex}];
(* number found index: 3 *)

Print["(* using JavaScript-like Array.findIndex() function \"ArrayFindIndexV3\" *)"];

NumberFoundIndex = ArrayFindIndexV3[(Module[{ANumber = #1}, (ANumber == NumberToFind)] &), Numbers];
SPrint["number found index: ", {NumberFoundIndex}];
(* number found index: 3 *)

Print["(* using JavaScript-like Array.findIndex() function \"ArrayFindIndexV4\" *)"];

NumberFoundIndex = ArrayFindIndexV4[(Module[{ANumber = #1}, (ANumber == NumberToFind)] &), Numbers];
SPrint["number found index: ", {NumberFoundIndex}];
(* number found index: 3 *)

Print["\n(* JavaScript-like Array.findIndex() in in Wolfram List of Associations *)"];

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

ProductToFind = "pasta";
Print["ProductToFind: ", JsonStringify[ProductToFind]];

Print["(* using JavaScript-like Array.findIndex() function \"ArrayFindIndexV1\" *)"];

ProductFoundIndex = ArrayFindIndexV1[(Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &), Products];
SPrint["product found index: ", {ProductFoundIndex}];
(* product found index: 1 *)

Print["(* using JavaScript-like Array.findIndex() function \"ArrayFindIndexV2\" *)"];

ProductFoundIndex = ArrayFindIndexV2[(Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &), Products];
SPrint["product found index: ", {ProductFoundIndex}];
(* product found index: 1 *)

Print["(* using JavaScript-like Array.findIndex() function \"ArrayFindIndexV3\" *)"];

ProductFoundIndex = ArrayFindIndexV3[(Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &), Products];
SPrint["product found index: ", {ProductFoundIndex}];
(* product found index: 1 *)

Print["(* using JavaScript-like Array.findIndex() function \"ArrayFindIndexV4\" *)"];

ProductFoundIndex = ArrayFindIndexV4[(Module[{AProduct = #1}, (AProduct[["code"]] == ProductToFind)] &), Products];
SPrint["product found index: ", {ProductFoundIndex}];
(* product found index: 1 *)
