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

console_log("Variables and Scopes in PHP");

// global scope

$yyy = "global_scope, 1";
console_log(string_interpolation("yyy: ", $yyy)); // yyy: global_scope, 1

// local scope

(function () {
    $yyy = "local_scope, 10";
    $aaa = "local_scope, 20";
    console_log(string_interpolation("yyy: ", $yyy)); // yyy: local_scope, 10
    console_log(string_interpolation("aaa: ", $aaa)); // aaa: local_scope, 20
})();
// console_log(string_interpolation("aaa: ", $aaa)); // "aaa" is not defined
console_log(string_interpolation("yyy: ", $yyy)); // yyy: global_scope, 1

$yyy = "global_scope, 1";

(function () use ($yyy) {
    $yyy = "local_scope, 10";
    $aaa = "local_scope, 20";
    console_log(string_interpolation("yyy: ", $yyy)); // yyy: local_scope, 10
    console_log(string_interpolation("aaa: ", $aaa)); // aaa: local_scope, 20
})();
// console_log(string_interpolation("aaa: ", $aaa)); // "aaa" is not defined
console_log(string_interpolation("yyy: ", $yyy)); // yyy: local_scope, 1

$yyy = "global_scope, 1";

// local scope, can access global variables but to modify them need to use "global" keyword

(function () {
    global $yyy;
    $yyy = "local_scope, 10";
    $aaa = "local_scope, 20";
    console_log(string_interpolation("yyy: ", $yyy)); // yyy: local_scope, 10
    console_log(string_interpolation("aaa: ", $aaa)); // aaa: local_scope, 20
})();
// console_log(string_interpolation("aaa: ", $aaa)); // "aaa" is not defined
console_log(string_interpolation("yyy: ", $yyy)); // yyy: local_scope, 10

$yyy = "global_scope, 1";

// local scope, can access variables from enclosing (outer) function or even global variables but to modify them need to use "use (&$something)"

(function () use (&$yyy) {
    $yyy = "local_scope, 10";
    $aaa = "local_scope, 20";
    console_log(string_interpolation("yyy: ", $yyy)); // yyy: local_scope, 10
    console_log(string_interpolation("aaa: ", $aaa)); // aaa: local_scope, 20
})();
// console_log(string_interpolation("aaa: ", $aaa)); // "aaa" is not defined
console_log(string_interpolation("yyy: ", $yyy)); // yyy: local_scope, 10

$yyy = "global_scope, 1";