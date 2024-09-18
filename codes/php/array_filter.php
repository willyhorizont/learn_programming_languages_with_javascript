<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    return (((@$optional_argument["pretty"] ?? false) === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
};

function array_every($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v4
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === false) return false;
    }
    return true;
};

function is_like_js_null($anything) {
    return (((gettype($anything) === "null") || (gettype($anything) === "NULL")) && (is_null($anything) === true) && (isset($anything) === false));
};

function is_like_js_boolean($anything) {
    return (((gettype($anything) === "boolean") || (gettype($anything) === "bool")) && (is_bool($anything) === true) && (($anything === true) || ($anything === false)));
};

function is_like_js_string($anything) {
    return ((gettype($anything) === "string") && (is_string($anything) === true));
};

function is_like_js_numeric($anything) {
    return (((gettype($anything) === "integer") || (gettype($anything) === "int") || (gettype($anything) === "float") || (gettype($anything) === "double")) && ((is_int($anything) === true) || (is_integer($anything) === true) || (is_float($anything) === true) || (is_double($anything) === true)) && (is_numeric($anything) === true));
};

function is_like_js_array($anything) {
    return ((gettype($anything) === "array") && (is_array($anything) === true));
};

function is_like_js_object($anything) {
    if (is_like_js_array($anything) === false) return false;
    return array_every((fn($array_item) => (is_like_js_string($array_item) === true)), array_keys($anything));
};

function get_type($anything) {
    if (is_like_js_null($anything) === true) return "Null";
    if (is_like_js_boolean($anything) === true) return "Boolean";
    if (is_like_js_string($anything) === true) return "String";
    if (is_like_js_numeric($anything) === true) return "Numeric";
    if (is_like_js_object($anything) === true) return "Object";
    if (is_like_js_array($anything) === true) return "Array";
    return ucwords(strtolower(gettype($anything)));
};

function string_interpolation(...$rest_arguments) {
    return array_reduce($rest_arguments, (fn($current_result, $current_argument) => ($current_result . ((get_type($current_argument) === "String") ? ($current_argument) : (((get_type($current_argument) === "Array") && (count($current_argument) === 1)) ? (json_stringify(@$current_argument[0])) : (json_stringify($current_argument)))))), "");
};

function console_log(...$rest_arguments) {
    echo string_interpolation(...$rest_arguments) . "\n";
};

function array_filter_v1($callback_function, $an_array) {
    // JavaScript-like Array.filter() function array_filter_v1
    $data_filtered = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) $data_filtered = [...$data_filtered, $array_item];
    }
    return $data_filtered;
};

function array_filter_v2($callback_function, $an_array) {
    // JavaScript-like Array.filter() function array_filter_v2
    $data_filtered = [];
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) $data_filtered = [...$data_filtered, $array_item];
    }
    return $data_filtered;
};

console_log("\n// JavaScript-like Array.filter() in PHP array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console_log(string_interpolation("numbers: ", [$numbers]));

console_log('// using JavaScript-like Array.filter() function "array_filter_v1"');

$numbers_even = array_filter_v1((fn($number) => (($number % 2) === 0)), $numbers);
console_log(string_interpolation("even numbers only: ", [$numbers_even]));
// even numbers only: [12, 34, 36, 4, 254]

$numbers_odd = array_filter_v1((fn($number) => (($number % 2) !== 0)), $numbers);
console_log(string_interpolation("odd numbers only: ", [$numbers_odd]));
// odd numbers only: [27, 23, 65, 93, 87]

console_log('// using JavaScript-like Array.filter() function "array_filter_v2"');

$numbers_even = array_filter_v2((fn($number) => (($number % 2) === 0)), $numbers);
console_log(string_interpolation("even numbers only: ", [$numbers_even]));
// even numbers only: [12, 34, 36, 4, 254]

$numbers_odd = array_filter_v2((fn($number) => (($number % 2) !== 0)), $numbers);
console_log(string_interpolation("odd numbers only: ", [$numbers_odd]));
// odd numbers only: [27, 23, 65, 93, 87]

console_log('// using PHP Array.filter() built-in function "array_values(array_filter)"');

$numbers_even = array_values(array_filter($numbers, (fn($number) => (($number % 2) === 0))));
console_log(string_interpolation("even numbers only: ", [$numbers_even]));
// even numbers only: [12, 34, 36, 4, 254]

$numbers_odd = array_values(array_filter($numbers, (fn($number) => (($number % 2) !== 0))));
console_log(string_interpolation("odd numbers only: ", [$numbers_odd]));
// odd numbers only: [27, 23, 65, 93, 87]

console_log("\n// JavaScript-like Array.filter() in PHP array of associative-arrays");

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

console_log('// using JavaScript-like Array.filter() function "array_filter_v1"');

$products_below_100 = array_filter_v1((fn($product) => (@$product["price"] <= 100)), $products);
console_log(string_interpolation("products with price <= 100 only: ", json_stringify($products_below_100, ["pretty" => true])));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v1((fn($product) => (@$product["price"] > 100)), $products);
console_log(string_interpolation("products with price > 100 only: ", json_stringify($products_above_100, ["pretty" => true])));
// products with price > 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

console_log('// using JavaScript-like Array.filter() function "array_filter_v2"');

$products_below_100 = array_filter_v2((fn($product) => (@$product["price"] <= 100)), $products);
console_log(string_interpolation("products with price <= 100 only: ", json_stringify($products_below_100, ["pretty" => true])));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v2((fn($product) => (@$product["price"] > 100)), $products);
console_log(string_interpolation("products with price > 100 only: ", json_stringify($products_above_100, ["pretty" => true])));
// products with price > 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

console_log('// using PHP Array.filter() built-in function "array_values(array_filter)"');

$products_below_100 = array_values(array_filter($products, (fn($product) => (@$product["price"] <= 100))));
console_log(string_interpolation("products with price <= 100 only: ", json_stringify($products_below_100, ["pretty" => true])));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_values(array_filter($products, (fn($product) => (@$product["price"] > 100))));
console_log(string_interpolation("products with price > 100 only: ", json_stringify($products_above_100, ["pretty" => true])));
// products with price > 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]
