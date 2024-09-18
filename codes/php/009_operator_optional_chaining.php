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

console_log("\n// JavaScript-like Optional Chaining Operator (?.) in PHP");

// There"s no JavaScript-like Optional Chaining Operator (?.) in PHP.
// But, we don't need that in PHP, because PHP already default it to null but with a warning. we can just use PHP Error Control Operator (@) to supress the error.

$JSON_OBJECT = [
    "foo" => [
        "bar" => "baz",
    ],
    "fruits" => ["apple", "mango", "banana"]
];
console_log(string_interpolation("JSON_OBJECT: ", json_stringify($JSON_OBJECT, ["pretty" => true])));

console_log("// using PHP Error Control Operator (@).");

console_log(string_interpolation('JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: ', [@$JSON_OBJECT["foo"]["bar"]]));
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.["foo"]?.["bar"]: "baz"

console_log(string_interpolation('JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: ', [@$JSON_OBJECT["foo"]["baz"]]));
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.["foo"]?.["baz"]: null

console_log(string_interpolation('JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: ', [@$JSON_OBJECT["fruits"][2]]));
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.["fruits"]?.[2]: "banana"

console_log(string_interpolation('JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: ', [@$JSON_OBJECT["fruits"][5]]));
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.["fruits"]?.[5]: null
