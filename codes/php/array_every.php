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

// There's no JavaScript-like Array.every() in PHP.
// But, we can create our own function to mimic it in PHP.

function array_every_v1($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v1
    $is_condition_match = false;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === false) break;
    }
    return $is_condition_match;
};

function array_every_v2($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v2
    $is_condition_match = false;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === false) return $is_condition_match;
    }
    return $is_condition_match;
};

function array_every_v3($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v3
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === false) return false;
    }
    return true;
};

function array_every_v4($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v4
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === false) return false;
    }
    return true;
};

console_log("\n// JavaScript-like Array.every() in PHP array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console_log(string_interpolation("numbers: ", [$numbers]));

console_log('// using JavaScript-like Array.every() function "array_every_v1"');

$is_all_number_less_than_500 = array_every_v1(fn($number) => ($number < 500), $numbers);
console_log(string_interpolation("is all number < 500: ", [$is_all_number_less_than_500]));
// is all number < 500: true

$is_all_number_more_than_500 = array_every_v1(fn($number) => ($number > 500), $numbers);
console_log(string_interpolation("is all number > 500: ", [$is_all_number_more_than_500]));
// is all number > 500: false

console_log('// using JavaScript-like Array.every() function "array_every_v2"');

$is_all_number_less_than_500 = array_every_v2(fn($number) => ($number < 500), $numbers);
console_log(string_interpolation("is all number < 500: ", [$is_all_number_less_than_500]));
// is all number < 500: true

$is_all_number_more_than_500 = array_every_v2(fn($number) => ($number > 500), $numbers);
console_log(string_interpolation("is all number > 500: ", [$is_all_number_more_than_500]));
// is all number > 500: false

console_log('// using JavaScript-like Array.every() function "array_every_v3"');

$is_all_number_less_than_500 = array_every_v3(fn($number) => ($number < 500), $numbers);
console_log(string_interpolation("is all number < 500: ", [$is_all_number_less_than_500]));
// is all number < 500: true

$is_all_number_more_than_500 = array_every_v3(fn($number) => ($number > 500), $numbers);
console_log(string_interpolation("is all number > 500: ", [$is_all_number_more_than_500]));
// is all number > 500: false

console_log('// using JavaScript-like Array.every() function "array_every_v4"');

$is_all_number_less_than_500 = array_every_v4(fn($number) => ($number < 500), $numbers);
console_log(string_interpolation("is all number < 500: ", [$is_all_number_less_than_500]));
// is all number < 500: true

$is_all_number_more_than_500 = array_every_v4(fn($number) => ($number > 500), $numbers);
console_log(string_interpolation("is all number > 500: ", [$is_all_number_more_than_500]));
// is all number > 500: false

console_log("\n// JavaScript-like Array.every() in PHP array of associative-arrays");

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

console_log('// using JavaScript-like Array.every() function "array_every_v1"');

$is_all_product_price_less_than_500 = array_every_v1(fn($product) => (@$product["price"] < 500), $products);
console_log(string_interpolation("is all product price < 500: ", [$is_all_product_price_less_than_500]));
// is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v1(fn($product) => (@$product["price"] > 500), $products);
console_log(string_interpolation("is all product price > 500: ", [$is_all_product_price_more_than_500]));
// is all product price > 500: false

console_log('// using JavaScript-like Array.every() function "array_every_v2"');

$is_all_product_price_less_than_500 = array_every_v2(fn($product) => (@$product["price"] < 500), $products);
console_log(string_interpolation("is all product price < 500: ", [$is_all_product_price_less_than_500]));
// is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v2(fn($product) => (@$product["price"] > 500), $products);
console_log(string_interpolation("is all product price > 500: ", [$is_all_product_price_more_than_500]));
// is all product price > 500: false

console_log('// using JavaScript-like Array.every() function "array_every_v3"');

$is_all_product_price_less_than_500 = array_every_v3(fn($product) => (@$product["price"] < 500), $products);
console_log(string_interpolation("is all product price < 500: ", [$is_all_product_price_less_than_500]));
// is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v3(fn($product) => (@$product["price"] > 500), $products);
console_log(string_interpolation("is all product price > 500: ", [$is_all_product_price_more_than_500]));
// is all product price > 500: false

console_log('// using JavaScript-like Array.every() function "array_every_v4"');

$is_all_product_price_less_than_500 = array_every_v4(fn($product) => (@$product["price"] < 500), $products);
console_log(string_interpolation("is all product price < 500: ", [$is_all_product_price_less_than_500]));
// is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v4(fn($product) => (@$product["price"] > 500), $products);
console_log(string_interpolation("is all product price > 500: ", [$is_all_product_price_more_than_500]));
// is all product price > 500: false