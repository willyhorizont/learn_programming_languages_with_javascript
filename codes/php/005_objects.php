<?php

// in PHP, JavaScript-like Object is called associative-array

$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];
echo("friend: " . str_replace("/\n$/", "", json_encode($friend, JSON_PRETTY_PRINT)) . "\n");

echo("friend, get country: " . $friend["country"] . "\n");
// friend, get country: Finland

echo("friend, get total object keys: " . count($friend) . "\n");
// friend, get total object keys: 3

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
