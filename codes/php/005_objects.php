<?php

$js_like_type = ["Null" => "Null", "Boolean" => "Boolean", "String" => "String", "Numeric" => "Numeric", "Object" => "Object", "Array" => "Array", "Function" => "Function"];

$array_reduce_v2 = function ($callback_function, $an_array, $initial_value) {
    // JavaScript-like Array.reduce() function $array_reduce_v2
    $result = $initial_value;
    $array_item_index = 0;
    foreach ($an_array as $object_key => $object_value) {
        $result = $callback_function($result, $object_value, $array_item_index, $an_array);
        $array_item_index += 1;
    }
    return $result;
};

$array_every = function ($callback_function, $an_array) {
    // JavaScript-like Array.every() function $array_every_v4
    $array_item_index = 0;
    foreach ($an_array as $object_key => $object_value) {
        if ($callback_function($object_value, $array_item_index, $an_array) === false) return false;
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

$console_log("// JavaScript-like Object in PHP (associative-array)");

// Create using array(k1 => v1, k2 => v2, ...)
$friend = array(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
$console_log($string_interpolation("friend: ", $json_stringify($friend, pretty: true)));

// Create using shorthand syntax [k1 => v1, k2 => v2, ...] (the best way)
$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];
$console_log($string_interpolation("friend: ", $json_stringify($friend, pretty: true)));

$console_log($string_interpolation("friend, get total object keys: ", [count($friend)]));
// friend, get total object keys: 3

$console_log($string_interpolation("friend, get country: ", [$friend["country"]]));
// friend, get country: "Finland"

$console_log($string_interpolation("friend, get country: ", [$optional_chaining($friend, "country")]));
// friend, get country: "Finland"

// iterate over and print each key-value pair and object entry index
(function () use ($friend, $console_log, $string_interpolation) {
    $object_entry_index = 0;
    foreach ($friend as $object_key => $object_value) {
        $console_log($string_interpolation("friend, object entry index: ", [$object_entry_index], ", key: ", [$object_key], ", value: ", [$object_value], ", for each loop"));
        $object_entry_index += 1;
    }
})();
// friend, object entry index: 0, key: "name", value: "Alisa", for each loop
// friend, object entry index: 1, key: "country", value: "Finland", for each loop
// friend, object entry index: 2, key: "age", value: 25, for each loop

$friend["age"] = 27;
$console_log($string_interpolation("friend: ", $json_stringify($friend, pretty: true)));

$friend["gender"] = "Female";
$console_log($string_interpolation("friend: ", $json_stringify($friend, pretty: true)));

unset($friend["country"]);
$console_log($string_interpolation("friend: ", $json_stringify($friend, pretty: true)));

// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
$delivery_response_key_message = "message";
$delivery_response = [
    $delivery_response_key_message => "ok"
];
$console_log($string_interpolation("delivery_response: ", $json_stringify($delivery_response, pretty: true)));
$delivery_response_key_status = "status";
$delivery_response[$delivery_response_key_status] = 200;
$console_log($string_interpolation("delivery_response: ", $json_stringify($delivery_response, pretty: true)));
