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
    return array_every(fn($array_item) => (is_like_js_string($array_item) === true), array_keys($anything));
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
    return array_reduce($rest_arguments,  (fn($current_result, $current_argument) => ($current_result . ((get_type($current_argument) === "String") ? ($current_argument) : (((get_type($current_argument) === "Array") && (count($current_argument) === 1)) ? (json_stringify(@$current_argument[0])) : (json_stringify($current_argument)))))), "");
};

function console_log(...$rest_arguments) {
    echo string_interpolation(...$rest_arguments) . "\n";
};

function array_reduce_v2($callback_function, $an_array, $initial_value) {
    // JavaScript-like Array.reduce() function array_reduce_v2
    $result = $initial_value;
    foreach ($an_array as $array_item_index => $array_item) {
        $result = $callback_function($result, $array_item, $array_item_index, $an_array);
    }
    return $result;
};

console_log("\n// JavaScript-like Array.reduce() in PHP array");

$numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
console_log(string_interpolation("numbers: ", [$numbers]));

console_log('// using JavaScript-like Array.reduce() function "array_reduce_v2"');

$numbers_total = array_reduce_v2(fn($current_result, $current_number) => ($current_result + $current_number), $numbers, 0);
console_log(string_interpolation("total number: ", [$numbers_total]));
// total number: 41.2

console_log('// using PHP Array.reduce() built-in function "array_reduce"');

$numbers_total = array_reduce($numbers,  fn($current_result, $current_number) => ($current_result + $current_number), 0);
console_log(string_interpolation("total number: ", [$numbers_total]));
// total number: 41.2

console_log("\n// JavaScript-like Array.reduce() in PHP array of associative-arrays");

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

console_log('// using JavaScript-like Array.reduce() function "array_reduce_v2"');

$products_grouped = array_reduce_v2(fn($current_result, $current_product) => ((@$current_product["price"] > 100) ? [...$current_result, "expensive" => [...@$current_result["expensive"], $current_product]] : [...$current_result, "cheap" => [...@$current_result["cheap"], $current_product]]), $products, ["expensive" => [], "cheap" => []]);
console_log(string_interpolation("grouped products: ", json_stringify($products_grouped, ["pretty" => true])));
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }

console_log('// using PHP Array.reduce() built-in function "array_reduce"');

$products_grouped = array_reduce($products,  fn($current_result, $current_product) => ((@$current_product["price"] > 100) ? [...$current_result, "expensive" => [...@$current_result["expensive"], $current_product]] : [...$current_result, "cheap" => [...@$current_result["cheap"], $current_product]]), ["expensive" => [], "cheap" => []]);
console_log(string_interpolation("grouped products: ", json_stringify($products_grouped, ["pretty" => true])));
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }
