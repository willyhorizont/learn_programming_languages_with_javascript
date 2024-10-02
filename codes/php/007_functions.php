<?php

$js_like_type = [
    "Null" => "Null",
    "Boolean" => "Boolean",
    "String" => "String",
    "Numeric" => "Numeric",
    "Object" => "Object",
    "Array" => "Array",
    "Function" => "Function"
];

function array_reduce_v2($callback_function, $an_array, $initial_value) {
    // JavaScript-like Array.reduce() function array_reduce_v2
    $result = $initial_value;
    $array_item_index = 0;
    foreach ($an_array as $object_key => $object_value) {
        $result = $callback_function($result, $object_value, $array_item_index, $an_array);
        $array_item_index += 1;
    }
    return $result;
};

function array_every($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v4
    $array_item_index = 0;
    foreach ($an_array as $object_key => $object_value) {
        if ($callback_function($object_value, $array_item_index, $an_array) === false) return false;
        $array_item_index += 1;
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
    return array_every((fn($object_value) => (is_like_js_string($object_value) === true)), array_keys($anything));
};

function is_like_js_function($anything) {
    return (is_callable($anything) === true);
};

function get_type($anything) {
    global $js_like_type;
    if (is_like_js_null($anything) === true) return $js_like_type["Null"];
    if (is_like_js_boolean($anything) === true) return $js_like_type["Boolean"];
    if (is_like_js_string($anything) === true) return $js_like_type["String"];
    if (is_like_js_numeric($anything) === true) return $js_like_type["Numeric"];
    if (is_like_js_object($anything) === true) return $js_like_type["Object"];
    if (is_like_js_array($anything) === true) return $js_like_type["Array"];
    if (is_like_js_function($anything) === true) return $js_like_type["Function"];
    return ('"' . gettype($anything) . '"');
};

function optional_chaining($anything, ...$array_index_or_object_key_or_function_argument_array) {
    // JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v2
    global $js_like_type;
    if (get_type($anything) === $js_like_type["Function"]) return $anything(...$array_index_or_object_key_or_function_argument_array);
    if (((get_type($anything) !== $js_like_type["Object"]) && (get_type($anything) !== $js_like_type["Array"])) || (count($array_index_or_object_key_or_function_argument_array) === 0)) return $anything;
    return array_reduce_v2((function ($current_result, $current_item) use ($anything, $js_like_type) {
        if ((get_type($current_result) === $js_like_type["Null"]) && (get_type($anything) === $js_like_type["Object"]) && (get_type($current_item) === $js_like_type["String"])) return @$anything[((string) $current_item)];
        if ((get_type($current_result) === $js_like_type["Null"]) && (get_type($anything) === $js_like_type["Array"]) && (get_type($current_item) === $js_like_type["Numeric"]) && (((int) $current_item) >= 0) && (count($anything) > ((int) $current_item))) return @$anything[((int) $current_item)];
        if ((get_type($current_result) === $js_like_type["Object"]) && (get_type($current_item) === $js_like_type["String"])) return @$current_result[((string) $current_item)];
        if ((get_type($current_result) === $js_like_type["Array"]) && (get_type($current_item) === $js_like_type["Numeric"]) && (((int) $current_item) >= 0) && (count($current_result) > ((int) $current_item))) return @$current_result[((int) $current_item)];
        return null;
    }), $array_index_or_object_key_or_function_argument_array, null);
};

function pipe(...$rest_arguments) {
    global $js_like_type;
    $pipe_last_result = null;
    $pipe_result = array_reduce_v2((function ($current_result, $current_argument) use (&$pipe_last_result, $js_like_type) {
        $pipe_last_result = $current_result;
        if (get_type($current_result) === $js_like_type["Null"]) return $current_argument;
        if (get_type($current_argument) === $js_like_type["Function"]) return $current_argument($current_result);
        return null;
    }), $rest_arguments, null);
    if (get_type($pipe_result) === $js_like_type["Function"]) return $pipe_result($pipe_last_result);
    return $pipe_result;
};

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    // json_stringify_v4
    $pretty = (optional_chaining($optional_argument, "pretty") ?? false);
    $indent = str_repeat(" ", 4);
    $indent_level = 0;
    $json_stringify_inner = function ($anything_inner) use ($pretty, $indent, &$indent_level, &$json_stringify_inner) {
        global $js_like_type;
        if (get_type($anything_inner) === $js_like_type["Null"]) return "null";
        if (get_type($anything_inner) === $js_like_type["String"]) return '"' . $anything_inner . '"';
        if (get_type($anything_inner) === $js_like_type["Numeric"]) return ((string) $anything_inner);
        if ((get_type($anything_inner) === $js_like_type["Boolean"]) || ($anything_inner === true)) return "true";
        if ((get_type($anything_inner) === $js_like_type["Boolean"]) || ($anything_inner === false)) return "false";
        if (get_type($anything_inner) === $js_like_type["Object"]) {
            if (count($anything_inner) === 0) return "{}";
            $indent_level += 1;
            $result = (($pretty === true) ? ("{\n" . str_repeat($indent, $indent_level)) : "{ ");
            $object_entry_index = 0;
            foreach ($anything_inner as $object_key => $object_value) {
                $result .= ('"' . $object_key . '": ' . $json_stringify_inner($object_value));
                if (($object_entry_index + 1) !== count($anything_inner)) {
                    $result .= (($pretty === true) ? (",\n" . str_repeat($indent, $indent_level)) : ", ");
                }
                $object_entry_index += 1;
            }
            $indent_level -= 1;
            $result .= (($pretty === true) ? ("\n" . str_repeat($indent, $indent_level) . "}") : " }");
            return $result;
        }
        if (get_type($anything_inner) === $js_like_type["Array"]) {
            if (count($anything_inner) === 0) return "[]";
            $indent_level += 1;
            $result = (($pretty === true) ? ("[\n" . str_repeat($indent, $indent_level)) : "[");
            $array_item_index = 0;
            foreach ($anything_inner as $object_key => $object_value) {
                $result .= $json_stringify_inner($object_value);
                if (($array_item_index + 1) !== count($anything_inner)) {
                    $result .= (($pretty === true) ? (",\n" . str_repeat($indent, $indent_level)) : ", ");
                }
                $array_item_index += 1;
            }
            $indent_level -= 1;
            $result .= (($pretty === true) ? ("\n" . str_repeat($indent, $indent_level) . "]") : "]");
            return $result;
        }
        if (get_type($anything_inner) === $js_like_type["Function"]) return '"[object Function]"';
        return '"' . get_type($anything_inner) . '"';
    };
    return $json_stringify_inner($anything);
};

function string_interpolation(...$rest_arguments) {
    global $js_like_type;
    return array_reduce_v2((fn($current_result, $current_argument) => ($current_result . ((get_type($current_argument) === $js_like_type["String"]) ? ($current_argument) : (((get_type($current_argument) === $js_like_type["Array"]) && (count($current_argument) === 1)) ? (json_stringify(optional_chaining($current_argument, 0))) : (json_stringify($current_argument)))))), $rest_arguments, "");
};

function console_log(...$rest_arguments) {
    echo string_interpolation(...$rest_arguments) . "\n";
};

// ? function statement or function declaration

function get_rectangle_area_v1($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation('get_rectangle_area_v1(7, 5): ', [get_rectangle_area_v1(7, 5)]));

// ? function expression

$get_rectangle_area_v2 = function ($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation('$get_rectangle_area_v2(7, 5): ', [$get_rectangle_area_v2(7, 5)]));

// ? anonymous function

function ($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};

// ? function expression with arrow function or named arrow function

$get_rectangle_area_v3 = fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length);
console_log(string_interpolation('$get_rectangle_area_v3(7, 5): ', [$get_rectangle_area_v3(7, 5)]));

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

say_hello((fn() => (say_how_are_you())));

say_hello(function() {
    console_log("how are you?");
});

say_hello(fn() => console_log("how are you?"));

// ? Assigning functions to variables or storing them in data structures

$get_rectangle_area_v2 = function ($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation('$get_rectangle_area_v2(7, 5): ', [$get_rectangle_area_v2(7, 5)]));

$get_rectangle_area_v3 = fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length);
console_log(string_interpolation('$get_rectangle_area_v3(7, 5): ', [$get_rectangle_area_v3(7, 5)]));

$my_array_of_get_rectangle_area_functions = [
    // "get_rectangle_area_v1", // 🤮
    fn(...$_) => (get_rectangle_area_v1(...$_)),
    function ($rectangle_width, $rectangle_length) {
        return ($rectangle_width * $rectangle_length);
    },
    fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length)
];
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions[0](7, 5): ', [$my_array_of_get_rectangle_area_functions[0](7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions[1](7, 5): ', [$my_array_of_get_rectangle_area_functions[1](7, 5)]));
console_log(string_interpolation('$my_array_of_get_rectangle_area_functions[2](7, 5): ', [$my_array_of_get_rectangle_area_functions[2](7, 5)]));
console_log(string_interpolation('optional_chaining($my_array_of_get_rectangle_area_functions, 0)(7, 5): ', [optional_chaining($my_array_of_get_rectangle_area_functions, 0)(7, 5)]));
console_log(string_interpolation('optional_chaining($my_array_of_get_rectangle_area_functions, 1)(7, 5): ', [optional_chaining($my_array_of_get_rectangle_area_functions, 1)(7, 5)]));
console_log(string_interpolation('optional_chaining($my_array_of_get_rectangle_area_functions, 2)(7, 5): ', [optional_chaining($my_array_of_get_rectangle_area_functions, 2)(7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions, 0), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions, 0), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions, 1), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions, 1), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions, 2), 7, 5): ', [optional_chaining(optional_chaining($my_array_of_get_rectangle_area_functions, 2), 7, 5)]));
console_log(string_interpolation('pipe(optional_chaining($my_array_of_get_rectangle_area_functions, 0), fn($_) => optional_chaining($_, 7, 5)): ', [pipe(optional_chaining($my_array_of_get_rectangle_area_functions, 0), fn($_) => optional_chaining($_, 7, 5))]));
console_log(string_interpolation('pipe(optional_chaining($my_array_of_get_rectangle_area_functions, 1), fn($_) => optional_chaining($_, 7, 5)): ', [pipe(optional_chaining($my_array_of_get_rectangle_area_functions, 1), fn($_) => optional_chaining($_, 7, 5))]));
console_log(string_interpolation('pipe(optional_chaining($my_array_of_get_rectangle_area_functions, 2), fn($_) => optional_chaining($_, 7, 5)): ', [pipe(optional_chaining($my_array_of_get_rectangle_area_functions, 2), fn($_) => optional_chaining($_, 7, 5))]));

function exponentiation($a, $b) {
    return ($a ** $b);
};

$simple_calculator = [
    // "exponentiation" => "exponentiation", // 🤮
    "exponentiation" => fn(...$_) => (exponentiation(...$_)),
    "multiplication" => function ($a, $b) {
        return ($a * $b);
    },
    "division" => fn($a, $b) => ($a / $b)
];
console_log(string_interpolation('$simple_calculator["exponentiation"](2, 4): ', [$simple_calculator["exponentiation"](2, 4)]));
console_log(string_interpolation('$simple_calculator["multiplication"](7, 5): ', [$simple_calculator["multiplication"](7, 5)]));
console_log(string_interpolation('$simple_calculator["division"](81, 9): ', [$simple_calculator["division"](81, 9)]));
console_log(string_interpolation('optional_chaining($simple_calculator, "exponentiation")(2, 4): ', [optional_chaining($simple_calculator, "exponentiation")(2, 4)]));
console_log(string_interpolation('optional_chaining($simple_calculator, "multiplication")(7, 5): ', [optional_chaining($simple_calculator, "multiplication")(7, 5)]));
console_log(string_interpolation('optional_chaining($simple_calculator, "division")(81, 9): ', [optional_chaining($simple_calculator, "division")(81, 9)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator, "exponentiation"), 2, 4): ', [optional_chaining(optional_chaining($simple_calculator, "exponentiation"), 2, 4)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator, "multiplication"), 7, 5): ', [optional_chaining(optional_chaining($simple_calculator, "multiplication"), 7, 5)]));
console_log(string_interpolation('optional_chaining(optional_chaining($simple_calculator, "division"), 81, 9): ', [optional_chaining(optional_chaining($simple_calculator, "division"), 81, 9)]));
console_log(string_interpolation('pipe(optional_chaining($simple_calculator, "exponentiation"), fn($_) => optional_chaining($_, 2, 4)): ', [pipe(optional_chaining($simple_calculator, "exponentiation"), fn($_) => optional_chaining($_, 2, 4))]));
console_log(string_interpolation('pipe(optional_chaining($simple_calculator, "multiplication"), fn($_) => optional_chaining($_, 7, 5)): ', [pipe(optional_chaining($simple_calculator, "multiplication"), fn($_) => optional_chaining($_, 7, 5))]));
console_log(string_interpolation('pipe(optional_chaining($simple_calculator, "division"), fn($_) => optional_chaining($_, 81, 9)): ', [pipe(optional_chaining($simple_calculator, "division"), fn($_) => optional_chaining($_, 81, 9))]));

// ? Returning functions as values from other functions

function multiply_v1($a) {
    $multiply_by = function ($b) use ($a) {
        return ($a * $b);
    };
    return $multiply_by;
};
$multiply_by2 = multiply_v1(2);
$multiply_by2_result = $multiply_by2(10);
console_log(string_interpolation('$multiply_by2(10): ', [$multiply_by2_result]));

function multiply_v2($a) {
    return function ($b) use ($a) {
        return ($a * $b);
    };
};
$multiply_by3 = multiply_v2(3);
$multiply_by3_result = $multiply_by3(10);
console_log(string_interpolation('$multiply_by3(10): ', [$multiply_by3_result]));

function multiply_v3($a) {
    return fn($b) => ($a * $b);
};
$multiply_by4 = multiply_v3(4);
$multiply_by4_result = $multiply_by4(10);
console_log(string_interpolation('$multiply_by4(10): ', [$multiply_by4_result]));

$multiply_v4 = function ($a) {
    $multiply_by = function ($b) use ($a) {
        return ($a * $b);
    };
    return $multiply_by;
};
$multiply_by5 = $multiply_v4(5);
$multiply_by5_result = $multiply_by5(10);
console_log(string_interpolation('$multiply_by5(10): ', [$multiply_by5_result]));

$multiply_v5 = function ($a) {
    return function ($b) use ($a) {
        return ($a * $b);
    };
};
$multiply_by6 = $multiply_v5(6);
$multiply_by6_result = $multiply_by6(10);
console_log(string_interpolation('$multiply_by6(10): ', [$multiply_by6_result]));

$multiply_v6 = function ($a) {
    return fn($b) => ($a * $b);
};
$multiply_by7 = $multiply_v6(7);
$multiply_by7_result = $multiply_by7(10);
console_log(string_interpolation('$multiply_by7(10): ', [$multiply_by7_result]));

$multiply_v6 = fn($a) => fn($b) => ($a * $b);
$multiply_by8 = $multiply_v6(8);
$multiply_by8_result = $multiply_by8(10);
console_log(string_interpolation('$multiply_by8(10): ', [$multiply_by8_result]));
