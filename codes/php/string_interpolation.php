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

console_log("// JavaScript-like Template literals / Template strings (String Interpolation) in PHP (none 🤮)");

// PHP can only interpolate variables for string interpolation 🤮

$my_name = "Alisa";
$my_age = 25;
console_log("my name is $my_name and I am $my_age.");
console_log("my name is {$my_name} and I am {$my_age}.");
// console_log("my name is ${my_name} and I am ${my_age}."); // this is not working and throw warning
console_log("my name is " . $my_name . " and I am " . $my_age . ".");
console_log(string_interpolation("my name is ", $my_name, " and I am ", $my_age, "."));
console_log(string_interpolation("my name is ", [$my_name], " and I am ", [$my_age], "."));

console_log("1 + 2 + 3 + 4 = {1 + 2 + 3 + 4}"); // this is not working
// console_log("1 + 2 + 3 + 4 = ${1 + 2 + 3 + 4}"); // this is not working and throw warning
console_log(string_interpolation("1 + 2 + 3 + 4 = ", 1 + 2 + 3 + 4));
console_log(string_interpolation("1 + 2 + 3 + 4 = ", [1 + 2 + 3 + 4]));

function get_rectangle_area($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};
console_log("get_rectangle_area(7, 5): {get_rectangle_area(7, 5)}"); // this is not working
// console_log("get_rectangle_area(7, 5): ${get_rectangle_area(7, 5)}"); // this is not working and throw warning
console_log(string_interpolation("get_rectangle_area(7, 5): ", get_rectangle_area(7, 5)));
console_log(string_interpolation("get_rectangle_area(7, 5): ", [get_rectangle_area(7, 5)]));

$any_string = "foo";
console_log(string_interpolation("any string: ", [$any_string]));

$any_numeric = 123;
console_log(string_interpolation("any numeric: ", [$any_numeric]));

$any_boolean = true;
console_log(string_interpolation("any boolean: ", [$any_boolean]));

$any_null = null;
console_log(string_interpolation("any null: ", [$any_null]));

$any_array = [1, 2, 3];
console_log(string_interpolation("any array: ", [$any_array]));
console_log(string_interpolation("any array first element: ", [@$any_array[0]]));

$any_object = ["foo" => "bar"];
console_log(string_interpolation("any object: ", [$any_object]));
console_log(string_interpolation("any object foo value: ", [@$any_object["foo"]]));
