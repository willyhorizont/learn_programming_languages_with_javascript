<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    $pretty = ($optional_argument["pretty"] ?? false);
    return (($pretty === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
};

function console_log(...$rest_arguments) {
    echo join("", $rest_arguments) . "\n";
};

function string_interpolation(...$rest_arguments) {
    return array_reduce($rest_arguments,  fn($current_result, $current_argument) => ($current_result . (((is_array($current_argument) === true) && count($current_argument) === 1) ? (json_stringify(@$current_argument[0])) : ($current_argument))), "");
};

console_log("// JavaScript-like JSON.stringify() in PHP");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console_log(string_interpolation("numbers: ", [$numbers]));

$products = [
    [
        "code" => "pasta",
        "price" => 321
    ],
    [
        "code" => "bubble_gum",
        "price" => 233
    ],
    [
        "code" => "potato_chips",
        "price" => 5
    ],
    [
        "code" => "towel",
        "price" => 499
    ]
];
console_log(string_interpolation("products: ", json_stringify($products, ["pretty" => true])));
