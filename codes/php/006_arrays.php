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

$console_log("// JavaScript-like Array in PHP (array)");

$fruits = ["apple", "mango", "orange"];
$console_log($string_interpolation("fruits: ", [$fruits]));

$console_log($string_interpolation("fruits, length: ", [count($fruits)]));
// fruits, length: 3

$console_log($string_interpolation("fruits, get mango: ", [$fruits[1]]));
// fruits, get mango: "mango"

$console_log($string_interpolation("fruits, get mango: ", [$optional_chaining($fruits, 1)]));
// fruits, get mango: "mango"

$console_log($string_interpolation("fruits, first element: ", [$fruits[0]]));
// fruits, first element: "apple"

$console_log($string_interpolation("fruits, first element: ", [$optional_chaining($fruits, 0)]));
// fruits, first element: "apple"

// $console_log($string_interpolation("fruits, last element: ", [end($fruits)])); // don't use this, this will throw error when array is empty
// fruits, last element: "orange"

$console_log($string_interpolation("fruits, last element: ", [$optional_chaining($fruits, (count($fruits) - 1))]));
// fruits, last element: "orange"

// iterate over and print each item and index
(function () use ($fruits, $console_log, $string_interpolation) {
    for ($array_item_index = 0; ($array_item_index < count($fruits)); $array_item_index += 1) {
        $array_item = $fruits[$array_item_index];
        $console_log($string_interpolation("fruits, index: ", [$array_item_index], ", item: ", [$array_item], ", for loop"));
    }
})();
// fruits, index: 0, item: "apple", for loop
// fruits, index: 1, item: "mango", for loop
// fruits, index: 2, item: "orange", for loop

// iterate over and print each item and index
(function () use ($fruits, $console_log, $string_interpolation) {
    $array_item_index = 0;
    foreach ($fruits as $object_key => $object_value) {
        $console_log($string_interpolation("fruits, index: ", [$array_item_index], ", item: ", [$object_value], ", for each loop"));
        $array_item_index += 1;
    }
})();
// fruits, index: 0, item: "apple", for each loop
// fruits, index: 1, item: "mango", for each loop
// fruits, index: 2, item: "orange", for each loop

array_push($fruits, "banana");
$console_log($string_interpolation("fruits: ", [$fruits]));
// fruits: ["apple", "mango", "orange", "banana"]
