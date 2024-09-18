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

// ? function statement or function declaration

function get_rectangle_area_v1($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};
// call the function example: get_rectangle_area_v1(7, 5)

// ? function expression

$get_rectangle_area_v2 = function ($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};
// call the function example: $get_rectangle_area_v2(7, 5)

// ? anonymous function

function ($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};

// ? function expression with arrow function or named arrow function

$get_rectangle_area_v3 = fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length);
// call the function example: $get_rectangle_area_v3(7, 5)

// ? anonymous arrow function

fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length);

// ? Passing functions as arguments to other functions

function say_hello($callback_function) {
    console_log("hello");
    $callback_function();
};

function say_how_are_you() {
    console_log("how are you?");
};

say_hello("say_how_are_you"); // 🤮

say_hello(function() {
    console_log("how are you?");
});

say_hello(fn() => console_log("how are you?"));

// ? Assigning functions to variables or storing them in data structures

$get_rectangle_area_v2 = function ($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};

$get_rectangle_area_v3 = fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length);

$my_array_of_get_rectangle_area_functions = [
    "get_rectangle_area_v1", // 🤮
    function ($rectangle_width, $rectangle_length) {
        return ($rectangle_width * $rectangle_length);
    },
    fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length)
];

$get_rectangle_area_function_result1 = @$my_array_of_get_rectangle_area_functions[0](7, 5);
$get_rectangle_area_function_result2 = @$my_array_of_get_rectangle_area_functions[1](7, 5);
$get_rectangle_area_function_result3 = @$my_array_of_get_rectangle_area_functions[2](7, 5);

function exponentiation($a, $b) {
    return ($a ** $b);
};

$simple_calculator = [
    "exponentiation" => "exponentiation", // 🤮
    "multiplication" => function ($a, $b) {
        return ($a * $b);
    },
    "division" => fn ($a, $b) => ($a / $b)
];
$simple_calculator_result1 = @$simple_calculator["exponentiation"](2, 4);
$simple_calculator_result2 = @$simple_calculator["multiplication"](7, 5);
$simple_calculator_result3 = @$simple_calculator["division"](81, 9);

// ? Returning functions as values from other functions

function multiply_v1($a) {
    $multiply_by = function ($b) use ($a) {
        return ($a * $b);
    };
    return $multiply_by;
};
$multiply_by2 = multiply_v1(2);
$multiply_by2_result = $multiply_by2(10); // 20

function multiply_v2($a) {
    return function ($b) use ($a) {
        return ($a * $b);
    };
};
$multiply_by3 = multiply_v2(3);
$multiply_by3_result = $multiply_by3(10); // 30

function multiply_v3($a) {
    return fn ($b) => ($a * $b);
};
$multiply_by4 = multiply_v3(4);
$multiply_by4_result = $multiply_by4(10); // 40

$multiply_v4 = function ($a) {
    $multiply_by = function ($b) use ($a) {
        return ($a * $b);
    };
    return $multiply_by;
};
$multiply_by5 = $multiply_v4(5);
$multiply_by5_result = $multiply_by5(10); // 50

$multiply_v5 = function ($a) {
    return function ($b) use ($a) {
        return ($a * $b);
    };
};
$multiply_by6 = $multiply_v5(6);
$multiply_by6_result = $multiply_by6(10); // 60

$multiply_v6 = function ($a) {
    return fn ($b) => ($a * $b);
};
$multiply_by7 = $multiply_v6(7);
$multiply_by7_result = $multiply_by7(10); // 70

$multiply_v6 = fn ($a) => fn ($b) => ($a * $b);
$multiply_by8 = $multiply_v6(8);
$multiply_by8_result = $multiply_by8(10); // 80
