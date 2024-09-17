<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    return (((@$optional_argument["pretty"] ?? false) === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
};

function console_log(...$rest_arguments) {
    echo join("", $rest_arguments) . "\n";
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
    return array_reduce($rest_arguments,  fn($current_result, $current_argument) => ($current_result . (((get_type($current_argument) === "Array") && (count($current_argument) === 1)) ? (json_stringify(@$current_argument[0])) : ($current_argument))), "");
};

console_log("// JavaScript-like Array in PHP (array)");

$fruits = ["apple", "mango", "orange"];
console_log(string_interpolation("fruits: ", [$fruits]));

console_log(string_interpolation("fruits, length: ", [count($fruits)]));
// fruits, length: 3

console_log(string_interpolation("fruits, get mango: ", [$fruits[1]]));
// fruits, get mango: mango

console_log(string_interpolation("fruits, get mango: ", [@$fruits[1]]));
// fruits, get mango: mango

console_log(string_interpolation("fruits, first element: ", [$fruits[0]]));
// fruits, first element: apple

console_log(string_interpolation("fruits, first element: ", [@$fruits[0]]));
// fruits, first element: apple

// console_log(string_interpolation("fruits, last element: ", [end($fruits)])); // don't use this, this will throw error when array is empty
// fruits, last element: orange

console_log(string_interpolation("fruits, last element: ", [@$fruits[(count($fruits) - 1)]]));
// fruits, last element: orange

// iterate over and print each item and index
(function () use ($fruits) {
    for ($array_item_index = 0; ($array_item_index < count($fruits)); $array_item_index += 1) {
        $array_item = @$fruits[$array_item_index];
        console_log(string_interpolation("fruits, for loop, index: ", [$array_item_index], ", item: ", [$array_item]));
    }
})();
// fruits, for loop, index: 0, item: apple
// fruits, for loop, index: 1, item: mango
// fruits, for loop, index: 2, item: orange

// iterate over and print each item and index
foreach ($fruits as $array_item_index => $array_item) {
    console_log(string_interpolation("fruits, for each loop, index: ", [$array_item_index], ", item: ", [$array_item]));
}
// fruits, for each loop, index: 0, item: apple
// fruits, for each loop, index: 1, item: mango
// fruits, for each loop, index: 2, item: orange

array_push($fruits, "banana");
console_log(string_interpolation("fruits: ", [$fruits]));
// fruits: ["apple", "mango", "orange", "banana"]

$fruits = [...$fruits, "kiwi"];
console_log(string_interpolation("fruits: ", [$fruits]));
// fruits: ["apple", "mango", "orange", "banana", "kiwi"]
