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
    foreach ($an_array as $array_item_index => $array_item) {
        $result = $callback_function($result, $array_item, $array_item_index, $an_array);
    }
    return $result;
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
    if (get_type($pipe_result) === $js_like_type["Function"]) {
        return $pipe_result($pipe_last_result);
    }
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
            foreach ($anything_inner as $array_item_index => $array_item) {
                $result .= $json_stringify_inner($array_item);
                if (($array_item_index + 1) !== count($anything_inner)) {
                    $result .= (($pretty === true) ? (",\n" . str_repeat($indent, $indent_level)) : ", ");
                }
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

function json_stringify_v1($anything, $optional_argument = ["pretty" => false]) {
    // json_stringify_v1
    return (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (((optional_chaining($optional_argument, "pretty") ?? false) === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))))))));
};

function json_stringify_v2($anything, $optional_argument = ["pretty" => false]) {
    // json_stringify_v2
    return pipe((((optional_chaining($optional_argument, "pretty") ?? false) === true) ? (pipe(json_encode($anything, JSON_PRETTY_PRINT), (fn($_) => str_replace("/\n$/", "", $_)))) : (pipe(json_encode($anything), (fn($_) => str_replace(",", ", ", $_)), (fn($_) => str_replace("{", "{ ", $_)), (fn($_) => str_replace(":", ": ", $_)), (fn($_) => str_replace("}", " }", $_))))), (fn($_) => str_replace("{  }", '"[object Function]"', $_)), (fn($_) => str_replace("{}", '"[object Function]"', $_)));
};

function json_stringify_v3($anything, $optional_argument = ["pretty" => false]) {
    // json_stringify_v3
    $pretty = (optional_chaining($optional_argument, "pretty") ?? false);
    $json_stringify_inner = function ($anything_inner) use (&$json_stringify_inner) {
        global $js_like_type;
        if ((get_type($anything_inner) === $js_like_type["Null"]) || (get_type($anything_inner) === $js_like_type["String"]) || (get_type($anything_inner) === $js_like_type["Numeric"]) || (get_type($anything_inner) === $js_like_type["Boolean"])) return $anything_inner;
        if (get_type($anything_inner) === $js_like_type["Object"]) {
            $object_entry_index = 0;
            $new_object = [];
            foreach ($anything_inner as $object_key => $object_value) {
                $new_object[$object_key] = $json_stringify_inner($object_value);
                $object_entry_index += 1;
            }
            return $new_object;
        }
        if (get_type($anything_inner) === $js_like_type["Array"]) {
            $new_array = [];
            foreach ($anything_inner as $array_item_index => $array_item) {
                array_push($new_array, $json_stringify_inner($array_item));
            }
            return $new_array;
        }
        if (get_type($anything_inner) === $js_like_type["Function"]) return "[object Function]";
        return get_type($anything_inner);
    };
    $json_stringify_inner_result = $json_stringify_inner($anything);
    return (($pretty === true) ? (str_replace("/\n$/", "", json_encode($json_stringify_inner_result, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($json_stringify_inner_result)))))));
};

function json_stringify_v4($anything, $optional_argument = ["pretty" => false]) {
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
            foreach ($anything_inner as $array_item_index => $array_item) {
                $result .= $json_stringify_inner($array_item);
                if (($array_item_index + 1) !== count($anything_inner)) {
                    $result .= (($pretty === true) ? (",\n" . str_repeat($indent, $indent_level)) : ", ");
                }
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

console_log("// JavaScript-like JSON.stringify() in PHP");

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
console_log(string_interpolation('json_encode($my_array): ', (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($my_array))))))))))));
console_log(string_interpolation('json_stringify_v1($my_array): ', json_stringify_v1($my_array)));
console_log(string_interpolation('json_stringify_v2($my_array): ', json_stringify_v2($my_array)));
console_log(string_interpolation('json_stringify_v3($my_array): ', json_stringify_v3($my_array)));
console_log(string_interpolation('json_stringify_v4($my_array): ', json_stringify_v4($my_array)));
console_log(string_interpolation('json_stringify($my_array): ', json_stringify($my_array)));
console_log(string_interpolation('json_encode($my_array, JSON_PRETTY_PRINT): ', (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (str_replace("/\n$/", "", json_encode($my_array, JSON_PRETTY_PRINT)))))))));
console_log(string_interpolation('json_stringify_v1($my_array): ', json_stringify_v1($my_array, ["pretty" => true])));
console_log(string_interpolation('json_stringify_v2($my_array): ', json_stringify_v2($my_array, ["pretty" => true])));
console_log(string_interpolation('json_stringify_v3($my_array): ', json_stringify_v3($my_array, ["pretty" => true])));
console_log(string_interpolation('json_stringify_v4($my_array): ', json_stringify_v4($my_array, ["pretty" => true])));
console_log(string_interpolation('json_stringify($my_array): ', json_stringify($my_array, ["pretty" => true])));

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
console_log(string_interpolation('json_encode($my_object): ', (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($my_object))))))))))));
console_log(string_interpolation('json_stringify_v1($my_object): ', json_stringify_v1($my_object)));
console_log(string_interpolation('json_stringify_v2($my_object): ', json_stringify_v2($my_object)));
console_log(string_interpolation('json_stringify_v3($my_object): ', json_stringify_v3($my_object)));
console_log(string_interpolation('json_stringify_v4($my_object): ', json_stringify_v4($my_object)));
console_log(string_interpolation('json_stringify($my_object): ', json_stringify($my_object)));
console_log(string_interpolation('json_encode($my_object, JSON_PRETTY_PRINT): ', (str_replace("{  }", '"[object Function]"', (str_replace("{}", '"[object Function]"', (str_replace("/\n$/", "", json_encode($my_object, JSON_PRETTY_PRINT)))))))));
console_log(string_interpolation('json_stringify_v1($my_object): ', json_stringify_v1($my_object, ["pretty" => true])));
console_log(string_interpolation('json_stringify_v2($my_object): ', json_stringify_v2($my_object, ["pretty" => true])));
console_log(string_interpolation('json_stringify_v3($my_object): ', json_stringify_v3($my_object, ["pretty" => true])));
console_log(string_interpolation('json_stringify_v4($my_object): ', json_stringify_v4($my_object, ["pretty" => true])));
console_log(string_interpolation('json_stringify($my_object): ', json_stringify($my_object, ["pretty" => true])));
