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

function generate_number_sequence($start_number, $stop_number) {
    if ($stop_number > $start_number) return range($start_number, $stop_number);
    if ($start_number > $stop_number) return range($start_number, $stop_number);
    return [0];
};

console_log(string_interpolation("generate_number_sequence(0, 9): ", [generate_number_sequence(0, 9)]));
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
console_log(string_interpolation("generate_number_sequence(1, 10): ", [generate_number_sequence(1, 10)]));
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console_log(string_interpolation("generate_number_sequence(10, 1): ", [generate_number_sequence(10, 1)]));
// [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
console_log(string_interpolation("generate_number_sequence(9, 0): ", [generate_number_sequence(9, 0)]));
// [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

console_log(string_interpolation("range(0, 9): ", [range(0, 9)]));
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
console_log(string_interpolation("range(1, 10): ", [range(1, 10)]));
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console_log(string_interpolation("range(10, 1): ", [range(10, 1)]));
// [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
console_log(string_interpolation("range(9, 0): ", [range(9, 0)]));
// [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
