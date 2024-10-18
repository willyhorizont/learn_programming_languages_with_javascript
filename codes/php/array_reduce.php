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

$console_log("\n// JavaScript-like Array.reduce() in PHP array");

$numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
$console_log($string_interpolation("numbers: ", [$numbers]));

$console_log('// using JavaScript-like Array.reduce() function "$array_reduce_v2"');

$numbers_total = $array_reduce_v2((fn($current_result, $current_number) => ($current_result + $current_number)), $numbers, 0);
$console_log($string_interpolation("total number: ", [$numbers_total]));
// total number: 41.2

$console_log('// using PHP Array.reduce() built-in function "array_reduce"');

$numbers_total = array_reduce($numbers, (fn($current_result, $current_number) => ($current_result + $current_number)), 0);
$console_log($string_interpolation("total number: ", [$numbers_total]));
// total number: 41.2

$console_log("\n// JavaScript-like Array.reduce() in PHP array of associative-arrays");

$products = [
    [
        "code" => "pasta",
        "price" => 321
    ],
    [
        "code" => "bubble_gum",
        "price" => 233
    ],
    [
        "code" => "potato_chips",
        "price" => 5
    ],
    [
        "code" => "towel",
        "price" => 499
    ]
];
$console_log($string_interpolation("products: ", $json_stringify($products, pretty: true)));

$console_log('// using JavaScript-like Array.reduce() function "$array_reduce_v2"');

$products_grouped = $array_reduce_v2((fn($current_result, $current_product) => (($optional_chaining($current_product, "price") > 100) ? ([...$current_result, "expensive" => [...$optional_chaining($current_result, "expensive"), $current_product]]) : ([...$current_result, "cheap" => [...$optional_chaining($current_result, "cheap"), $current_product]]))), $products, ["expensive" => [], "cheap" => []]);
$console_log($string_interpolation("grouped products: ", $json_stringify($products_grouped, pretty: true)));
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }

$console_log('// using PHP Array.reduce() built-in function "array_reduce"');

$products_grouped = array_reduce($products, (fn($current_result, $current_product) => (($optional_chaining($current_product, "price") > 100) ? ([...$current_result, "expensive" => [...$optional_chaining($current_result, "expensive"), $current_product]]) : ([...$current_result, "cheap" => [...$optional_chaining($current_result, "cheap"), $current_product]]))), ["expensive" => [], "cheap" => []]);
$console_log($string_interpolation("grouped products: ", $json_stringify($products_grouped, pretty: true)));
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }
