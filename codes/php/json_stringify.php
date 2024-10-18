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

$get_type = fn($anything) => (($is_like_js_null($anything) === true) ? ($js_like_type["Null"]) : (($is_like_js_boolean($anything) === true) ? ($js_like_type["Boolean"]) : ((($is_like_js_string($anything) === true) ? ($js_like_type["String"]) : (($is_like_js_numeric($anything) === true) ? ($js_like_type["Numeric"]) : ((($is_like_js_object($anything) === true) ? ($js_like_type["Object"]) : (($is_like_js_array($anything) === true) ? ($js_like_type["Array"]) : (($is_like_js_function($anything) === true) ? ($js_like_type["Function"]) : ('"' . gettype($anything) . '"'))))))))));

$optional_chaining = fn($anything, ...$array_index_or_object_key_or_function_argument_array) => (($get_type($anything) === $js_like_type["Function"]) ? ($anything(...$array_index_or_object_key_or_function_argument_array)) : (((($get_type($anything) !== $js_like_type["Object"]) && ($get_type($anything) !== $js_like_type["Array"])) || (count($array_index_or_object_key_or_function_argument_array) === 0)) ? ($anything) : ($array_reduce_v2((fn($current_result, $current_item) => ((($get_type($current_result) === $js_like_type["Null"]) && ($get_type($anything) === $js_like_type["Object"]) && ($get_type($current_item) === $js_like_type["String"])) ? (@$anything[((string) $current_item)]) : ((($get_type($current_result) === $js_like_type["Null"]) && ($get_type($anything) === $js_like_type["Array"]) && ($get_type($current_item) === $js_like_type["Numeric"]) && (((int) $current_item) >= 0) && (count($anything) > ((int) $current_item))) ? (@$anything[((int) $current_item)]) : ((($get_type($current_result) === $js_like_type["Object"]) && ($get_type($current_item) === $js_like_type["String"])) ? (@$current_result[((string) $current_item)]) : ((($get_type($current_result) === $js_like_type["Array"]) && ($get_type($current_item) === $js_like_type["Numeric"]) && (((int) $current_item) >= 0) && (count($current_result) > ((int) $current_item))) ? (@$current_result[((int) $current_item)]) : null))))), $array_index_or_object_key_or_function_argument_array, null))));

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
    // $json_stringify_v4
    $indent = str_repeat(" ", 4);
    $indent_level = 0;
    $json_stringify_inner = function ($anything_inner) use ($js_like_type, $get_type, $pretty, $indent, &$indent_level, &$json_stringify_inner) {
        if ($get_type($anything_inner) === $js_like_type["Null"]) return "null";
        if ($get_type($anything_inner) === $js_like_type["String"]) return '"' . $anything_inner . '"';
        if ($get_type($anything_inner) === $js_like_type["Numeric"]) return ((string) $anything_inner);
        if (($get_type($anything_inner) === $js_like_type["Boolean"]) && ($anything_inner === true)) return "true";
        if (($get_type($anything_inner) === $js_like_type["Boolean"]) && ($anything_inner === false)) return "false";
        if ($get_type($anything_inner) === $js_like_type["Object"]) {
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
        if ($get_type($anything_inner) === $js_like_type["Array"]) {
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
        if ($get_type($anything_inner) === $js_like_type["Function"]) return '"[object Function]"';
        return '"' . $get_type($anything_inner) . '"';
    };
    return $json_stringify_inner($anything);
};

$string_interpolation = fn(...$rest_arguments) => $array_reduce_v2((fn($current_result, $current_argument) => ($current_result . (($get_type($current_argument) === $js_like_type["String"]) ? ($current_argument) : ((($get_type($current_argument) === $js_like_type["Array"]) && (count($current_argument) === 1)) ? ($json_stringify($optional_chaining($current_argument, 0))) : ($json_stringify($current_argument)))))), $rest_arguments, "");

$console_log = function (...$rest_arguments) use ($string_interpolation) {
    echo $string_interpolation(...$rest_arguments) . "\n";
};

$json_stringify_v1 = fn($anything, $pretty = false) => (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (($pretty === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything))))))))))); // json_stringify_v1

$json_stringify_v2 = fn($anything, $pretty = false) => $pipe((($pretty === true) ? ($pipe(json_encode($anything, JSON_PRETTY_PRINT), (fn($_) => str_replace("/\n$/", "", $_)))) : ($pipe(json_encode($anything), (fn($_) => str_replace(",", ", ", $_)), (fn($_) => str_replace("{", "{ ", $_)), (fn($_) => str_replace(":", ": ", $_)), (fn($_) => str_replace("}", " }", $_))))), (fn($_) => str_replace("{  }", '"[object Function]"', $_)), (fn($_) => str_replace("{}", '"[object Function]"', $_))); // json_stringify_v2

$json_stringify_v3 = function ($anything, $pretty = false) use ($js_like_type, $get_type) {
    // json_stringify_v3
    $json_stringify_inner = function ($anything_inner) use ($js_like_type, $get_type, &$json_stringify_inner) {
        if (($get_type($anything_inner) === $js_like_type["Null"]) || ($get_type($anything_inner) === $js_like_type["String"]) || ($get_type($anything_inner) === $js_like_type["Numeric"]) || ($get_type($anything_inner) === $js_like_type["Boolean"])) return $anything_inner;
        if ($get_type($anything_inner) === $js_like_type["Object"]) {
            $object_entry_index = 0;
            $new_object = [];
            foreach ($anything_inner as $object_key => $object_value) {
                $new_object[$object_key] = $json_stringify_inner($object_value);
                $object_entry_index += 1;
            }
            return $new_object;
        }
        if ($get_type($anything_inner) === $js_like_type["Array"]) {
            $new_array = [];
            $array_item_index = 0;
            foreach ($anything_inner as $object_key => $object_value) {
                array_push($new_array, $json_stringify_inner($object_value));
                $array_item_index += 1;
            }
            return $new_array;
        }
        if ($get_type($anything_inner) === $js_like_type["Function"]) return "[object Function]";
        return $get_type($anything_inner);
    };
    $json_stringify_inner_result = $json_stringify_inner($anything);
    return (($pretty === true) ? (str_replace("/\n$/", "", json_encode($json_stringify_inner_result, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($json_stringify_inner_result)))))));
};

$json_stringify_v4 = function ($anything, $pretty = false) use ($js_like_type, $get_type) {
    // $json_stringify_v4
    $indent = str_repeat(" ", 4);
    $indent_level = 0;
    $json_stringify_inner = function ($anything_inner) use ($js_like_type, $get_type, $pretty, $indent, &$indent_level, &$json_stringify_inner) {
        if ($get_type($anything_inner) === $js_like_type["Null"]) return "null";
        if ($get_type($anything_inner) === $js_like_type["String"]) return '"' . $anything_inner . '"';
        if ($get_type($anything_inner) === $js_like_type["Numeric"]) return ((string) $anything_inner);
        if (($get_type($anything_inner) === $js_like_type["Boolean"]) && ($anything_inner === true)) return "true";
        if (($get_type($anything_inner) === $js_like_type["Boolean"]) && ($anything_inner === false)) return "false";
        if ($get_type($anything_inner) === $js_like_type["Object"]) {
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
        if ($get_type($anything_inner) === $js_like_type["Array"]) {
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
        if ($get_type($anything_inner) === $js_like_type["Function"]) return '"[object Function]"';
        return '"' . $get_type($anything_inner) . '"';
    };
    return $json_stringify_inner($anything);
};

$console_log("// JavaScript-like JSON.stringify() in PHP");

$my_array = [
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
$console_log($string_interpolation('json_encode($my_array): ', (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($my_array))))))))))));
$console_log($string_interpolation('json_stringify_v1($my_array): ', $json_stringify_v1($my_array)));
$console_log($string_interpolation('json_stringify_v2($my_array): ', $json_stringify_v2($my_array)));
$console_log($string_interpolation('json_stringify_v3($my_array): ', $json_stringify_v3($my_array)));
$console_log($string_interpolation('json_stringify_v4($my_array): ', $json_stringify_v4($my_array)));
$console_log($string_interpolation('json_stringify($my_array): ', $json_stringify($my_array)));
$console_log($string_interpolation('json_encode($my_array, JSON_PRETTY_PRINT): ', (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (str_replace("/\n$/", "", json_encode($my_array, JSON_PRETTY_PRINT)))))))));
$console_log($string_interpolation('json_stringify_v1($my_array, pretty: true): ', $json_stringify_v1($my_array, pretty: true)));
$console_log($string_interpolation('json_stringify_v2($my_array, pretty: true): ', $json_stringify_v2($my_array, pretty: true)));
$console_log($string_interpolation('json_stringify_v3($my_array, pretty: true): ', $json_stringify_v3($my_array, pretty: true)));
$console_log($string_interpolation('json_stringify_v4($my_array, pretty: true): ', $json_stringify_v4($my_array, pretty: true)));
$console_log($string_interpolation('json_stringify($my_array, pretty: true): ', $json_stringify($my_array, pretty: true)));

$my_object = [
    "my_function" => function ($a, $b) {
        return ($a * $b);
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => true,
    "my_null" => null,
    "my_array" => [1, 2, 3],
    "my_object" => [
        "foo" => "bar"
    ]
];
$console_log($string_interpolation('json_encode($my_object): ', (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($my_object))))))))))));
$console_log($string_interpolation('json_stringify_v1($my_object): ', $json_stringify_v1($my_object)));
$console_log($string_interpolation('json_stringify_v2($my_object): ', $json_stringify_v2($my_object)));
$console_log($string_interpolation('json_stringify_v3($my_object): ', $json_stringify_v3($my_object)));
$console_log($string_interpolation('json_stringify_v4($my_object): ', $json_stringify_v4($my_object)));
$console_log($string_interpolation('json_stringify($my_object): ', $json_stringify($my_object)));
$console_log($string_interpolation('json_encode($my_object, JSON_PRETTY_PRINT): ', (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (str_replace("/\n$/", "", json_encode($my_object, JSON_PRETTY_PRINT)))))))));
$console_log($string_interpolation('json_stringify_v1($my_object, pretty: true): ', $json_stringify_v1($my_object, pretty: true)));
$console_log($string_interpolation('json_stringify_v2($my_object, pretty: true): ', $json_stringify_v2($my_object, pretty: true)));
$console_log($string_interpolation('json_stringify_v3($my_object, pretty: true): ', $json_stringify_v3($my_object, pretty: true)));
$console_log($string_interpolation('json_stringify_v4($my_object, pretty: true): ', $json_stringify_v4($my_object, pretty: true)));
$console_log($string_interpolation('json_stringify($my_object, pretty: true): ', $json_stringify($my_object, pretty: true)));
