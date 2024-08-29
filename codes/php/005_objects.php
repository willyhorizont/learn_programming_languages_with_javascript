<?php

// in PHP, JavaScript-like Object is called associative-array

// Create using array(k1 => v1, k2 => v2, ...)
// $friend = array(
//     "name" => "Alisa",
//     "country" => "Finland",
//     "age" => 25
// );

// Create using shorthand syntax [k1 => v1, k2 => v2, ...] (the best way)
$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];
echo("friend: " . str_replace("/\n$/", "", json_encode($friend, JSON_PRETTY_PRINT)) . "\n");

echo("friend, get total object keys: " . count($friend) . "\n");
// friend, get total object keys: 3

echo("friend, get country: " . $friend["country"] . "\n");
// friend, get country: Finland

// iterate over and get each key-value pair
foreach ($friend as $object_key => $object_value) {
    echo("friend, forEach loop, key: " . $object_key . ", value: " . $object_value . "\n");
}
// friend, forEach loop, key: name, value: Alisa
// friend, forEach loop, key: country, value: Finland
// friend, forEach loop, key: age, value: 25

// iterate over and get each key-value pair and object iteration/entry index
$object_iteration_index = 0;
foreach ($friend as $object_key => $object_value) {
    echo("friend, forEach loop, object iteration/entry index: " . $object_iteration_index . ", key: " . $object_key . ", value: " . $object_value . "\n");
    $object_iteration_index += 1;
}
// friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
// friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
// friend, forEach loop, object iteration/entry index: 2, key: age, value: 25

$friend["age"] = 27;
echo("friend: " . str_replace("/\n$/", "", json_encode($friend, JSON_PRETTY_PRINT)) . "\n");

$friend["gender"] = "Female";
echo("friend: " . str_replace("/\n$/", "", json_encode($friend, JSON_PRETTY_PRINT)) . "\n");

unset($friend["country"]);
echo("friend: " . str_replace("/\n$/", "", json_encode($friend, JSON_PRETTY_PRINT)) . "\n");

// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
$delivery_response_key_message = "message";
$delivery_response = [
    $delivery_response_key_message => "ok"
];
echo("delivery_response: " . str_replace("/\n$/", "", json_encode($delivery_response, JSON_PRETTY_PRINT)) . "\n");
$delivery_response_key_status = "status";
$delivery_response[$delivery_response_key_status] = 200;
echo("delivery_response: " . str_replace("/\n$/", "", json_encode($delivery_response, JSON_PRETTY_PRINT)) . "\n");
