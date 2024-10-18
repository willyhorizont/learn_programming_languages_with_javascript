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

$create_valid_object_key = fn($object_key) => ("(" . ((string) $object_key) . ")");

$object_from_entries = function ($an_object_entries) use ($js_like_type, $get_type, $create_valid_object_key, $optional_chaining) {
    // JavaScript-like Object.fromEntries() function
    $new_object = [];
    foreach ($an_object_entries as $object_entry_index => $object_entry) {
        if ($get_type($object_entry) !== $js_like_type["Array"]) continue;
        if (count($object_entry) !== 2) continue;
        $object_key = $optional_chaining($object_entry, 0);
        $object_value = $optional_chaining($object_entry, 1);
        if ($get_type($object_key) === $js_like_type["Numeric"]) {
            $new_object[$create_valid_object_key($object_key)] = $object_value;
            continue;
        }
        $new_object[((string) $object_key)] = $object_value;
    }
    return $new_object;
};

$array_entries = function ($an_array) {
    // JavaScript-like Array.entries() function
    $new_object_entries = [];
    $array_item_index = 0;
    foreach ($an_array as $object_key => $object_value) {
        array_push($new_object_entries, [$array_item_index, $object_value]);
        $array_item_index += 1;
    }
    return $new_object_entries;
};

$console_log("\n// JavaScript-like Spread Syntax (...) in PHP");

$fruits = ["Mango", "Melon", "Banana"];
$console_log($string_interpolation("fruits: ", [$fruits]));

$vegetables = ["Carrot", "Tomato"];
$console_log($string_interpolation("vegetables: ", [$vegetables]));

$country_capitals_in_asia = [
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
];
$console_log($string_interpolation("country_capitals_in_asia: ", $json_stringify($country_capitals_in_asia, pretty: true)));

$country_capitals_in_europe = [
    "France" => "Paris",
    "England" => "London"
];
$console_log($string_interpolation("country_capitals_in_europe: ", $json_stringify($country_capitals_in_europe, pretty: true)));

$console_log("\n// [...array1, ...array2]:\n");

$combination1 = [...$fruits, ...$vegetables];
$console_log($string_interpolation("combination1: ", $json_stringify($combination1, pretty: true)));
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

$combination2 = [...$fruits, ...["Cucumber", "Cabbage"]];
$console_log($string_interpolation("combination2: ", $json_stringify($combination2, pretty: true)));
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

$console_log("\n// { ...object1, ...object2 }:\n");

$combination3 = [...$country_capitals_in_asia, ...$country_capitals_in_europe];
$console_log($string_interpolation("combination3: ", $json_stringify($combination3, pretty: true)));
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

$combination4 = [...$country_capitals_in_asia, ...["Germany" => "Berlin", "Italy" => "Rome"]];
$console_log($string_interpolation("combination4: ", $json_stringify($combination4, pretty: true)));
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

$console_log("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n");

$combination5 = [...$fruits, $vegetables];
$console_log($string_interpolation("combination5: ", $json_stringify($combination5, pretty: true)));
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
$console_log($string_interpolation("combination6: ", $json_stringify($combination6, pretty: true)));
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Cabbage"
//     ]
// ]

$console_log("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n");

$combination7 = [...$fruits, $country_capitals_in_asia];
$console_log($string_interpolation("combination7: ", $json_stringify($combination7, pretty: true)));
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
$console_log($string_interpolation("combination8: ", $json_stringify($combination8, pretty: true)));
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

$console_log("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n");

$combination9 = [...$country_capitals_in_asia, "country_capitals_in_europe" => $country_capitals_in_europe];
$console_log($string_interpolation("combination9: ", $json_stringify($combination9, pretty: true)));
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
$console_log($string_interpolation("combination10: ", $json_stringify($combination10, pretty: true)));
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "country_capitals_in_europe": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

$console_log("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n");

$combination11 = [...$country_capitals_in_asia, "vegetables" => $vegetables];
$console_log($string_interpolation("combination11: ", $json_stringify($combination11, pretty: true)));
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
$console_log($string_interpolation("combination12: ", $json_stringify($combination12, pretty: true)));
// combination12: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Cucumber",
//         "Cabbage"
//     ]
// }

$console_log("\n// { ...object1, ...array2 }:\n");

$combination13 = [...$country_capitals_in_asia, ...$object_from_entries($array_entries($vegetables))];
$console_log($string_interpolation("combination13: ", $json_stringify($combination13, pretty: true)));
// combination13: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Carrot",
//    "1" : "Tomato"
// }

$combination14 = [...$country_capitals_in_asia, ...$object_from_entries($array_entries(["Cucumber", "Cabbage"]))];
$console_log($string_interpolation("combination14: ", $json_stringify($combination14, pretty: true)));
// combination14: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Cucumber",
//    "1" : "Cabbage"
// }

// $console_log("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n");

// this combination throw an error in JavaScript
// $combination_error_in_java_script1 = [...$fruits, ...$country_capitals_in_asia];
// $console_log($string_interpolation("combination_error_in_java_script1: ", $json_stringify($combination_error_in_java_script1, pretty: true)));

// this combination throw an error in JavaScript
// $combination_error_in_java_script2 = [...$fruits, ...["Germany" => "Berlin", "Italy" => "Rome"]];
// $console_log($string_interpolation("combination_error_in_java_script2: ", $json_stringify($combination_error_in_java_script2, pretty: true)));
