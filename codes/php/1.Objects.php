<?php

$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];

// iterate over and get each key-value pair
foreach ($friend as $object_key => $object_value) {
    echo("\n" . "friend, foreach loop, key: " . $object_key . ", value: " . $object_value);
}
// friend, foreach loop, key: name, value: Alisa
// friend, foreach loop, key: country, value: Finland
// friend, foreach loop, key: age, value: 25
