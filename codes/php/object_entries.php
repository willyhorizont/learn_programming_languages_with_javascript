<?php

// There's no JavaScript-like Object.entries() in PHP.
// But, we can create our own function to mimic it in PHP.

function object_entries($an_object) {
    // JavaScript-like Object.entries() function
    $new_array = [];
    foreach ($an_object as $object_key => $object_value) {
        $new_array = [...$new_array, [$object_key, $object_value]];
    }
    return $new_array;
};

echo("\n// JavaScript-like Object.entries() in PHP associative-array" . "\n");

$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];
echo("friend: " . str_replace("/\n$/", "", json_encode($friend, JSON_PRETTY_PRINT)) . "\n");

echo("// using JavaScript-like Object.entries() function \"object_entries\"" . "\n");

echo("friend entries: " . str_replace(",", ", ", str_replace(":", ": ", json_encode(object_entries($friend)))) . "\n");
// friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
