<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    $pretty = ($optional_argument["pretty"] ?? false);
    return (($pretty === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
};

function console_log(...$rest_arguments) {
    echo join("", $rest_arguments) . "\n";
};

function string_interpolation(...$rest_arguments) {
    return array_reduce($rest_arguments,  fn($current_result, $current_argument) => ($current_result . (((is_array($current_argument) === true) && count($current_argument) === 1) ? (json_stringify(@$current_argument[0])) : ($current_argument))), "");
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
// friend, get country: Finland

console_log(string_interpolation("friend, get country: ", [@$friend["country"]]));
// friend, get country: Finland

// iterate over and print each key-value pair and object entry index
(function () use (&$friend) {
    $object_entry_index = 0;
    foreach ($friend as $object_key => $object_value) {
        echo("friend, for each loop, object entry index: " . $object_entry_index . ", key: " . $object_key . ", value: " . $object_value . "\n");
        $object_entry_index += 1;
    }
})();
// friend, for each loop, object entry index: 0, key: name, value: Alisa
// friend, for each loop, object entry index: 1, key: country, value: Finland
// friend, for each loop, object entry index: 2, key: age, value: 25

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
