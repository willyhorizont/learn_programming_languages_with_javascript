<?php

$js_like_type = ["Null" => "Null", "Boolean" => "Boolean", "String" => "String", "Numeric" => "Numeric", "Object" => "Object", "Array" => "Array", "Function" => "Function"];

$array_reduce_v2 = function ($callback_function, $any_array, $initial_value) {
    // JavaScript-like Array.reduce() function $array_reduce_v2
    $result = $initial_value;
    $array_item_index = 0;
    foreach ($any_array as $object_key => $object_value) {
        $result = $callback_function($result, $object_value, $array_item_index, $any_array);
        $array_item_index += 1;
    }
    return $result;
};

$array_every = function ($callback_function, $any_array) {
    // JavaScript-like Array.every() function $array_every_v4
    $array_item_index = 0;
    foreach ($any_array as $object_key => $object_value) {
        if ($callback_function($object_value, $array_item_index, $any_array) === false) return false;
        $array_item_index += 1;
    }
    return true;
};

$is_like_js_null = fn($anything) => (((gettype($anything) === "null") || (gettype($anything) === "NULL")) && (is_null($anything) === true) && (isset($anything) === false));

$is_like_js_boolean = fn($anything) => (((gettype($anything) === "boolean") || (gettype($anything) === "bool")) && (is_bool($anything) === true) && (($anything === true) || ($anything === false)));

$is_like_js_string = fn($anything) => ((gettype($anything) === "string") && (is_string($anything) === true));

$is_like_js_numeric = fn($anything) => (((gettype($anything) === "integer") || (gettype($anything) === "int") || (gettype($anything) === "float") || (gettype($anything) === "double")) && ((is_int($anything) === true) || (is_integer($anything) === true) || (is_float($anything) === true) || (is_double($anything) === true)) && (is_numeric($anything) === true));

$is_like_js_array = fn($anything) => ((gettype($anything) === "array") && (is_array($anything) === true));

$is_like_js_object = fn($anything) => (($is_like_js_array($anything) === false) ? false : ($array_every((fn($object_value) => ($is_like_js_string($object_value) === true)), array_keys($anything))));

$is_like_js_function = fn($anything) => (is_callable($anything) === true);

$get_type = fn($anything) => (($is_like_js_null($anything) === true) ? ($js_like_type["Null"]) : (($is_like_js_boolean($anything) === true) ? ($js_like_type["Boolean"]) : ((($is_like_js_string($anything) === true) ? ($js_like_type["String"]) : (($is_like_js_numeric($anything) === true) ? ($js_like_type["Numeric"]) : ((($is_like_js_object($anything) === true) ? ($js_like_type["Object"]) : (($is_like_js_array($anything) === true) ? ($js_like_type["Array"]) : (($is_like_js_function($anything) === true) ? ($js_like_type["Function"]) : (gettype($anything)))))))))));

$optional_chaining = function ($anything, ...$array_index_or_object_key_or_function_argument_array) use ($js_like_type, $get_type, $array_reduce_v2) {
    $anything_type = $get_type($anything);
    return (($anything_type === $js_like_type["Function"]) ? ($anything(...$array_index_or_object_key_or_function_argument_array)) : (((($anything_type !== $js_like_type["Object"]) && ($anything_type !== $js_like_type["Array"])) || (count($array_index_or_object_key_or_function_argument_array) === 0)) ? ($anything) : ($array_reduce_v2((function ($current_result, $current_item) use ($js_like_type, $get_type, $anything, $anything_type) {
        $current_result_type = $get_type($current_result);
        $current_item_type = $get_type($current_item);
        return ((($current_result_type === $js_like_type["Null"]) && ($anything_type === $js_like_type["Object"]) && ($current_item_type === $js_like_type["String"])) ? (@$anything[((string) $current_item)]) : ((($current_result_type === $js_like_type["Null"]) && ($anything_type === $js_like_type["Array"]) && ($current_item_type === $js_like_type["Numeric"]) && (((int) $current_item) >= 0) && (count($anything) > ((int) $current_item))) ? (@$anything[((int) $current_item)]) : ((($current_result_type === $js_like_type["Object"]) && ($current_item_type === $js_like_type["String"])) ? (@$current_result[((string) $current_item)]) : ((($current_result_type === $js_like_type["Array"]) && ($current_item_type === $js_like_type["Numeric"]) && (((int) $current_item) >= 0) && (count($current_result) > ((int) $current_item))) ? (@$current_result[((int) $current_item)]) : null))));
    }), $array_index_or_object_key_or_function_argument_array, null))));
};

$pipe = function (...$rest_arguments) use ($js_like_type, $get_type, $array_reduce_v2) {
    $pipe_last_result = null;
    $pipe_result = $array_reduce_v2((function ($current_result, $current_argument) use (&$pipe_last_result, $js_like_type, $get_type) {
        $pipe_last_result = $current_result;
        return (($get_type($current_result) === $js_like_type["Null"]) ? ($current_argument) : (($get_type($current_argument) === $js_like_type["Function"]) ? ($current_argument($current_result)) : (null)));
    }), $rest_arguments, null);
    if ($get_type($pipe_result) === $js_like_type["Function"]) return $pipe_result($pipe_last_result);
    return $pipe_result;
};

$json_stringify = function ($anything, $pretty = false) use ($js_like_type, $get_type) {
    // custom JSON.stringify() function $json_stringify_v4
    $indent = str_repeat(" ", 4);
    $indent_level = 0;
    $json_stringify_inner = function ($anything_inner) use ($js_like_type, $get_type, $pretty, $indent, &$indent_level, &$json_stringify_inner) {
        $anything_inner_type = $get_type($anything_inner);
        if ($anything_inner_type === $js_like_type["Null"]) return "null";
        if ($anything_inner_type === $js_like_type["String"]) return '"' . $anything_inner . '"';
        if ($anything_inner_type === $js_like_type["Numeric"]) return ((string) $anything_inner);
        if (($anything_inner_type === $js_like_type["Boolean"]) && ($anything_inner === true)) return "true";
        if (($anything_inner_type === $js_like_type["Boolean"]) && ($anything_inner === false)) return "false";
        if ($anything_inner_type === $js_like_type["Object"]) {
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
        if ($anything_inner_type === $js_like_type["Array"]) {
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
        if ($anything_inner_type === $js_like_type["Function"]) return "[object Function]";
        return $anything_inner_type;
    };
    return $json_stringify_inner($anything);
};

$string_interpolation = fn(...$rest_arguments) => $array_reduce_v2((function ($current_result, $current_argument) use ($js_like_type, $get_type, $json_stringify, $optional_chaining) {
    $current_argument_type = $get_type($current_argument);
    return ($current_result . (($current_argument_type === $js_like_type["String"]) ? ($current_argument) : ((($current_argument_type === $js_like_type["Array"]) && (count($current_argument) === 1)) ? ($json_stringify($optional_chaining($current_argument, 0))) : ($json_stringify($current_argument)))));
}), $rest_arguments, "");

$console_log = function (...$rest_arguments) use ($string_interpolation) {
    echo $string_interpolation(...$rest_arguments) . "\n";
};

/*
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
*/
$something = "foo";
$console_log($string_interpolation("something: ", $json_stringify($something, pretty: true)));
$something = 123;
$console_log($string_interpolation("something: ", $json_stringify($something, pretty: true)));
$something = true;
$console_log($string_interpolation("something: ", $json_stringify($something, pretty: true)));
$something = null;
$console_log($string_interpolation("something: ", $json_stringify($something, pretty: true)));
$something = [1, 2, 3];
$console_log($string_interpolation("something: ", $json_stringify($something, pretty: true)));
$something = ["foo" => "bar"];
$console_log($string_interpolation("something: ", $json_stringify($something, pretty: true)));

/*
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
*/
$get_modified_indent_level = function () {
    $indent_level = 0;
    $change_indent_level = function() use (&$indent_level, &$change_indent_level) {
        $indent_level += 1;
        if ($indent_level < 5) $change_indent_level();
        return $indent_level;
    };
    return $change_indent_level();
};
$console_log($string_interpolation("get_modified_indent_level(): ", [$get_modified_indent_level()]));
$create_new_game = function ($initial_credit) use ($console_log, $string_interpolation) {
    $current_credit = $initial_credit;
    $console_log($string_interpolation("initial_credit: ", [$initial_credit]));
    return function () use ($console_log, $string_interpolation, &$current_credit) {
        $current_credit -= 1;
        if ($current_credit === 0) {
            $console_log("not enough credits");
            return;
        }
        $console_log($string_interpolation("playing game, ", [$current_credit], " credit(s) remaining"));
    };
};
$play_game = $create_new_game(3);
$play_game();
$play_game();
$play_game();

/*
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
*/
$my_object = [
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => true,
    "my_null" => null,
    "my_array" => [1, 2, 3],
    "my_object" => [
        "foo" => "bar"
    ]
];
$console_log($string_interpolation("my_object: ", $json_stringify($my_object, pretty: true)));

/*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
*/
$my_array = ["foo", 123, true, null, [1, 2, 3], ["foo" => "bar"]];
$console_log($string_interpolation("my_array: ", $json_stringify($my_array, pretty: true)));

/*
x. support passing functions as arguments to other functions
*/
function say_hello($callback_function) {
    global $console_log;
    $console_log("hello");
    $callback_function();
};
$say_hello_v2 = function ($callback_function) use ($console_log) {
    $console_log("hello");
    $callback_function();
};
function say_how_are_you() {
    global $console_log;
    $console_log("how are you?");
};
$say_how_are_you_v2 = function () use ($console_log) {
    $console_log("how are you?");
};
say_hello("say_how_are_you"); // 🤮
say_hello($say_how_are_you_v2);
$say_hello_v2($say_how_are_you_v2);
say_hello((fn() => (say_how_are_you())));
say_hello(function() use ($console_log) {
    $console_log("how are you?");
});
$say_hello_v2((fn() => (say_how_are_you())));
$say_hello_v2(function() use ($console_log) {
    $console_log("how are you?");
});

/*
x. support returning functions as values from other functions
*/
$multiply = function ($a) {
    return function ($b) use ($a) {
        return ($a * $b);
    };
};
$multiply_by2 = $multiply(2);
$multiply_by2_result = $multiply_by2(10);
$console_log($string_interpolation("multiplyBy2(10): ", $multiply_by2_result));

/*
x. support assigning functions to variables
*/
$get_rectangle_area_v1 = function ($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};
$console_log($string_interpolation("get_rectangle_area_v1(7, 5): ", $get_rectangle_area_v1(7, 5)));
$get_rectangle_area_v2 = fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length);
$console_log($string_interpolation("get_rectangle_area_v2(7, 5): ", $get_rectangle_area_v2(7, 5)));

/*
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
*/
$my_array2 = [
    function ($a, $b) {
        return ($a * $b);
    },
    "foo",
    123,
    true,
    null,
    [1, 2, 3],
    ["foo" => "bar"]
];
$console_log($string_interpolation("myArray2[0](7, 5): ", $optional_chaining($optional_chaining($my_array2, 0), 7, 5)));
$console_log($string_interpolation("myArray2[0](7, 5): ", $pipe($optional_chaining($my_array2, 0), (fn($_) => $optional_chaining($_, 7, 5)))));
$my_object2 = [
    "my_function" => function ($a, $b) {
        return ($a * $b);
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_boolean" => true,
    "my_null" => null,
    "my_array" => [1, 2, 3],
    "my_object" => [
        "foo" => "bar"
    ]
];
$console_log($string_interpolation('myObject2["my_function"](7, 5): ', $optional_chaining($optional_chaining($my_object2, "my_function"), 7, 5)));
$console_log($string_interpolation('myObject2["my_function"](7, 5): ', $pipe($optional_chaining($my_object2, "my_function"), (fn($_) => $optional_chaining($_, 7, 5)))));
