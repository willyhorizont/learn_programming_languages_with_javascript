<?php

$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];

echo("\n" . "friend, get country: " . $friend["country"]);
// friend, get country: Finland

// iterate over and get each key-value pair
foreach ($friend as $object_key => $object_value) {
    echo("\n" . "friend, foreach loop, key: " . $object_key . ", value: " . $object_value);
}
// friend, foreach loop, key: name, value: Alisa
// friend, foreach loop, key: country, value: Finland
// friend, foreach loop, key: age, value: 25

// iterate over and get each key-value pair and iteration index
$iteration_index = 0;
foreach ($friend as $object_key => $object_value) {
    echo("\n" . "friend, foreach loop, index: " . $iteration_index . ", key: " . $object_key . ", value: " . $object_value);
    $iteration_index += 1;
}
// friend, foreach loop, index: 0, key: name, value: Alisa
// friend, foreach loop, index: 1, key: country, value: Finland
// friend, foreach loop, index: 2, key: age, value: 25
