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

// There's no JavaScript-like Array.some() in PHP.
// But, we can create our own function to mimic it in PHP.

$array_some_v1 = function ($callback_function, $any_array) {
    // JavaScript-like Array.some() function $array_some_v1
    $is_condition_match = false;
    $array_item_index = 0;
    foreach ($any_array as $object_key => $object_value) {
        $is_condition_match = $callback_function($object_value, $array_item_index, $any_array);
        if ($is_condition_match) break;
        $array_item_index += 1;
    }
    return $is_condition_match;
};

$array_some_v2 = function ($callback_function, $any_array) {
    // JavaScript-like Array.some() function $array_some_v2
    $is_condition_match = false;
    $array_item_index = 0;
    foreach ($any_array as $object_key => $object_value) {
        $is_condition_match = $callback_function($object_value, $array_item_index, $any_array);
        if ($is_condition_match) return $is_condition_match;
        $array_item_index += 1;
    }
    return $is_condition_match;
};

$array_some_v3 = function ($callback_function, $any_array) {
    // JavaScript-like Array.some() function $array_some_v3
    $array_item_index = 0;
    foreach ($any_array as $object_key => $object_value) {
        $is_condition_match = $callback_function($object_value, $array_item_index, $any_array);
        if ($is_condition_match) return true;
        $array_item_index += 1;
    }
    return false;
};

$array_some_v4 = function ($callback_function, $any_array) {
    // JavaScript-like Array.some() function $array_some_v4
    $array_item_index = 0;
    foreach ($any_array as $object_key => $object_value) {
        if ($callback_function($object_value, $array_item_index, $any_array) === true) return true;
        $array_item_index += 1;
    }
    return false;
};

$console_log("\n// JavaScript-like Array.some() in PHP array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
$console_log($string_interpolation("numbers: ", [$numbers]));

$console_log('// using JavaScript-like Array.some() function "$array_some_v1"');

$is_any_number_less_than_500 = $array_some_v1((fn($any_number) => ($any_number < 500)), $numbers);
$console_log($string_interpolation("is any number < 500: ", [$is_any_number_less_than_500]));
// is any number < 500: true

$is_any_number_more_than_500 = $array_some_v1((fn($any_number) => ($any_number > 500)), $numbers);
$console_log($string_interpolation("is any number > 500: ", [$is_any_number_more_than_500]));
// is any number > 500: false

$console_log('// using JavaScript-like Array.some() function "$array_some_v2"');

$is_any_number_less_than_500 = $array_some_v2((fn($any_number) => ($any_number < 500)), $numbers);
$console_log($string_interpolation("is any number < 500: ", [$is_any_number_less_than_500]));
// is any number < 500: true

$is_any_number_more_than_500 = $array_some_v2((fn($any_number) => ($any_number > 500)), $numbers);
$console_log($string_interpolation("is any number > 500: ", [$is_any_number_more_than_500]));
// is any number > 500: false

$console_log('// using JavaScript-like Array.some() function "$array_some_v3"');

$is_any_number_less_than_500 = $array_some_v3((fn($any_number) => ($any_number < 500)), $numbers);
$console_log($string_interpolation("is any number < 500: ", [$is_any_number_less_than_500]));
// is any number < 500: true

$is_any_number_more_than_500 = $array_some_v3((fn($any_number) => ($any_number > 500)), $numbers);
$console_log($string_interpolation("is any number > 500: ", [$is_any_number_more_than_500]));
// is any number > 500: false

$console_log('// using JavaScript-like Array.some() function "$array_some_v4"');

$is_any_number_less_than_500 = $array_some_v4((fn($any_number) => ($any_number < 500)), $numbers);
$console_log($string_interpolation("is any number < 500: ", [$is_any_number_less_than_500]));
// is any number < 500: true

$is_any_number_more_than_500 = $array_some_v4((fn($any_number) => ($any_number > 500)), $numbers);
$console_log($string_interpolation("is any number > 500: ", [$is_any_number_more_than_500]));
// is any number > 500: false

$console_log("\n// JavaScript-like Array.some() in PHP array of associative-arrays");

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

$console_log('// using JavaScript-like Array.some() function "$array_some_v1"');

$is_any_product_price_less_than_500 = $array_some_v1((fn($any_product) => ($optional_chaining($any_product, "price") < 500)), $products);
$console_log($string_interpolation("is any product price < 500: ", [$is_any_product_price_less_than_500]));
// is any product price < 500: true

$is_any_product_price_more_than_500 = $array_some_v1((fn($any_product) => ($optional_chaining($any_product, "price") > 500)), $products);
$console_log($string_interpolation("is any product price > 500: ", [$is_any_product_price_more_than_500]));
// is any product price > 500: false

$console_log('// using JavaScript-like Array.some() function "$array_some_v2"');

$is_any_product_price_less_than_500 = $array_some_v2((fn($any_product) => ($optional_chaining($any_product, "price") < 500)), $products);
$console_log($string_interpolation("is any product price < 500: ", [$is_any_product_price_less_than_500]));
// is any product price < 500: true

$is_any_product_price_more_than_500 = $array_some_v2((fn($any_product) => ($optional_chaining($any_product, "price") > 500)), $products);
$console_log($string_interpolation("is any product price > 500: ", [$is_any_product_price_more_than_500]));
// is any product price > 500: false

$console_log('// using JavaScript-like Array.some() function "$array_some_v3"');

$is_any_product_price_less_than_500 = $array_some_v3((fn($any_product) => ($optional_chaining($any_product, "price") < 500)), $products);
$console_log($string_interpolation("is any product price < 500: ", [$is_any_product_price_less_than_500]));
// is any product price < 500: true

$is_any_product_price_more_than_500 = $array_some_v3((fn($any_product) => ($optional_chaining($any_product, "price") > 500)), $products);
$console_log($string_interpolation("is any product price > 500: ", [$is_any_product_price_more_than_500]));
// is any product price > 500: false

$console_log('// using JavaScript-like Array.some() function "$array_some_v4"');

$is_any_product_price_less_than_500 = $array_some_v4((fn($any_product) => ($optional_chaining($any_product, "price") < 500)), $products);
$console_log($string_interpolation("is any product price < 500: ", [$is_any_product_price_less_than_500]));
// is any product price < 500: true

$is_any_product_price_more_than_500 = $array_some_v4((fn($any_product) => ($optional_chaining($any_product, "price") > 500)), $products);
$console_log($string_interpolation("is any product price > 500: ", [$is_any_product_price_more_than_500]));
// is any product price > 500: false
