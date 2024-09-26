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

console_log("\n// JavaScript-like Spread Syntax (...) in PHP");

$fruits = ["Mango", "Melon", "Banana"];
console_log(string_interpolation("fruits: ", [$fruits]));

$vegetables = ["Carrot", "Tomato"];
console_log(string_interpolation("vegetables: ", [$vegetables]));

$country_capitals_in_asia = [
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
];
console_log(string_interpolation("country_capitals_in_asia: ", json_stringify($country_capitals_in_asia, ["pretty" => true])));

$country_capitals_in_europe = [
    "France" => "Paris",
    "England" => "London"
];
console_log(string_interpolation("country_capitals_in_asia: ", json_stringify($country_capitals_in_europe, ["pretty" => true])));

console_log("\n// [...array1, ...array2]:\n");

$combination1 = [...$fruits, ...$vegetables];
console_log(string_interpolation("combination1: ", json_stringify($combination1, ["pretty" => true])));
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

$combination2 = [...$fruits, ...["Cucumber", "Cabbage"]];
console_log(string_interpolation("combination2: ", json_stringify($combination2, ["pretty" => true])));
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

console_log("\n// { ...object1, ...object2 }:\n");

$combination3 = [...$country_capitals_in_asia, ...$country_capitals_in_europe];
console_log(string_interpolation("combination3: ", json_stringify($combination3, ["pretty" => true])));
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

$combination4 = [...$country_capitals_in_asia, ...["Germany" => "Berlin", "Italy" => "Rome"]];
console_log(string_interpolation("combination4: ", json_stringify($combination4, ["pretty" => true])));
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

console_log("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n");

$combination5 = [...$fruits, $vegetables];
console_log(string_interpolation("combination5: ", json_stringify($combination5, ["pretty" => true])));
// combination5: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Carrot",
//         "Tomato"
//     ]
// ]

$combination6 = [...$fruits, ["Cucumber", "Cabbage"]];
console_log(string_interpolation("combination6: ", json_stringify($combination6, ["pretty" => true])));
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Cabbage"
//     ]
// ]

console_log("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n");

$combination7 = [...$fruits, $country_capitals_in_asia];
console_log(string_interpolation("combination7: ", json_stringify($combination7, ["pretty" => true])));
// combination7: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Thailand": "Bangkok",
//         "China": "Beijing",
//         "Japan": "Tokyo"
//     }
// ]

$combination8 = [...$fruits, ["Germany" => "Berlin", "Italy" => "Rome"]];
console_log(string_interpolation("combination8: ", json_stringify($combination8, ["pretty" => true])));
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

console_log("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n");

$combination9 = [...$country_capitals_in_asia, "country_capitals_in_europe" => $country_capitals_in_europe];
console_log(string_interpolation("combination9: ", json_stringify($combination9, ["pretty" => true])));
// combination9: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "country_capitals_in_europe" : {
//       "France" : "Paris",
//       "England" : "London"
//    }
// }

$combination10 = [...$country_capitals_in_asia, "country_capitals_in_europe" => ["Germany" => "Berlin", "Italy" => "Rome"]];
console_log(string_interpolation("combination10: ", json_stringify($combination10, ["pretty" => true])));
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "country_capitals_in_europe": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

console_log("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n");

$combination11 = [...$country_capitals_in_asia, "vegetables" => $vegetables];
console_log(string_interpolation("combination11: ", json_stringify($combination11, ["pretty" => true])));
// combination11: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Carrot",
//         "Tomato"
//     ]
// }

$combination12 = [...$country_capitals_in_asia, "vegetables" => ["Cucumber", "Cabbage"]];
console_log(string_interpolation("combination12: ", json_stringify($combination12, ["pretty" => true])));
// combination12: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Cucumber",
//         "Cabbage"
//     ]
// }

console_log("\n// { ...object1, ...array2 }:\n");

$combination13 = [...$country_capitals_in_asia, ...$vegetables];
console_log(string_interpolation("combination13: ", json_stringify($combination13, ["pretty" => true])));
// combination13: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Carrot",
//    "1" : "Tomato"
// }

$combination14 = [...$country_capitals_in_asia, ...["Cucumber", "Cabbage"]];
console_log(string_interpolation("combination14: ", json_stringify($combination14, ["pretty" => true])));
// combination14: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Cucumber",
//    "1" : "Cabbage"
// }

// console_log("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n");

// this combination throw an error in JavaScript
// $combinationErrorInJavaScript1 = [...$fruits, ...$country_capitals_in_asia];
// console_log(string_interpolation("combinationErrorInJavaScript1: ", json_stringify($combinationErrorInJavaScript1, ["pretty" => true])));

// this combination throw an error in JavaScript
// $combinationErrorInJavaScript2 = [...$fruits, ...["Germany" => "Berlin", "Italy" => "Rome"]];
// console_log(string_interpolation("combinationErrorInJavaScript2: ", json_stringify($combinationErrorInJavaScript2, ["pretty" => true])));
