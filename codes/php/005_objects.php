<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    return (((@$optional_argument["pretty"] ?? false) === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
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
    return array_reduce($rest_arguments, (fn($current_result, $current_argument) => ($current_result . ((get_type($current_argument) === "String") ? ($current_argument) : (((get_type($current_argument) === "Array") && (count($current_argument) === 1)) ? (json_stringify(@$current_argument[0])) : (json_stringify($current_argument)))))), "");
};

function console_log(...$rest_arguments) {
    echo string_interpolation(...$rest_arguments) . "\n";
};

console_log("// JavaScript-like Object in PHP (associative-array)");

// Create using array(k1 => v1, k2 => v2, ...)
$friend = array(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
);
console_log(string_interpolation("friend: ", json_stringify($friend, ["pretty" => true])));

// Create using shorthand syntax [k1 => v1, k2 => v2, ...] (the best way)
$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];
console_log(string_interpolation("friend: ", json_stringify($friend, ["pretty" => true])));

console_log(string_interpolation("friend, get total object keys: ", [count($friend)]));
// friend, get total object keys: 3

console_log(string_interpolation("friend, get country: ", [$friend["country"]]));
// friend, get country: "Finland"

console_log(string_interpolation("friend, get country: ", [@$friend["country"]]));
// friend, get country: "Finland"

// iterate over and print each key-value pair and object entry index
(function () use ($friend) {
    $object_entry_index = 0;
    foreach ($friend as $object_key => $object_value) {
        console_log(string_interpolation("friend, for each loop, object entry index: ", [$object_entry_index], ", key: ", [$object_key], ", value: ", [$object_value]));
        $object_entry_index += 1;
    }
})();
// friend, for each loop, object entry index: 0, key: "name", value: "Alisa"
// friend, for each loop, object entry index: 1, key: "country", value: "Finland"
// friend, for each loop, object entry index: 2, key: "age", value: 25

$friend["age"] = 27;
console_log(string_interpolation("friend: ", json_stringify($friend, ["pretty" => true])));

$friend["gender"] = "Female";
console_log(string_interpolation("friend: ", json_stringify($friend, ["pretty" => true])));

unset($friend["country"]);
console_log(string_interpolation("friend: ", json_stringify($friend, ["pretty" => true])));

// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
$delivery_response_key_message = "message";
$delivery_response = [
    $delivery_response_key_message => "ok"
];
console_log(string_interpolation("delivery_response: ", json_stringify($delivery_response, ["pretty" => true])));
$delivery_response_key_status = "status";
$delivery_response[$delivery_response_key_status] = 200;
console_log(string_interpolation("delivery_response: ", json_stringify($delivery_response, ["pretty" => true])));
