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

// while loop

(function () {
    $i = 1;
    while (true) {
        if ($i === 2) {
            if ($i >= 5) break;
            $i += 1;
            continue;
        }
        console_log(string_interpolation("while loop v1, i is ", [$i]));
        if ($i >= 5) break;
        $i += 1;
    }
})();

(function () {
    $i = 1;
    while ($i <= 5) {
        if ($i === 2) {
            $i += 1;
            continue;
        }
        console_log(string_interpolation("while loop v2, i is ", [$i]));
        $i += 1;
    }
})();

// for loop

(function () {
    for ($i = 1; ($i <= 10); $i += 1) {
        if ($i > 5) break;
        if ($i === 2) continue;
        console_log(string_interpolation("for loop, i is ", [$i]));
    }
})();

// for each loop

(function () {
    foreach (range(1, 10, 1) as $i) { // (start, stop, step)
        if ($i > 5) break;
        if ($i === 2) continue;
        console_log(string_interpolation("for each loop ascending, i is ", [$i]));
    }
})();

(function () {
    foreach (range(10, 1, 1) as $i) { // (start, stop, step)
        if ($i <= 5) break;
        if ($i === 9) continue;
        console_log(string_interpolation("for each loop descending, i is ", [$i]));
    }
})();
