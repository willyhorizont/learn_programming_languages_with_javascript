<?php

// There's no JavaScript-like Object.fromEntries() in PHP.
// But, we can create our own function to mimic it in PHP.

function object_from_entries($an_object_entries) {
    // JavaScript-like Object.fromEntries() function
    $new_object = [];
    foreach ($an_object_entries as $object_entry_index => $object_entry) {
        if (gettype($object_entry) !== "array") continue;
        if (count($object_entry) !== 2) continue;
        $object_key = $object_entry[0];
        $object_value = $object_entry[1];
        $new_object[$object_key] = $object_value;
    }
    return $new_object;
};

echo("\n// JavaScript-like Object.fromEntries() in PHP associative-array" . "\n");

$friend_entries = [["name", "Alisa"], ["country", "Finland"], ["age", 25]];
echo("friend entries: " . str_replace("/\n$/", "", json_encode($friend_entries, JSON_PRETTY_PRINT)) . "\n");

echo("// using JavaScript-like Object.fromEntries() function \"object_from_entries\"" . "\n");

echo("friend object from friend entries: " . str_replace("/\n$/", "", json_encode(object_from_entries($friend_entries), JSON_PRETTY_PRINT)) . "\n");
// friend object from friend entries: {
//     "name": "Alisa",
//     "country": "Finland",
//     "age": 25
// }
