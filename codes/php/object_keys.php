<?php

echo("\n// JavaScript-like Object.keys() in PHP associative-array" . "\n");

$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];
echo("friend: " . str_replace("/\n$/", "", json_encode($friend, JSON_PRETTY_PRINT)) . "\n");

echo("friend keys: " . str_replace(",", ", ", str_replace(":", ": ", json_encode(array_keys($friend)))) . "\n");
// friend keys: ["name", "country", "age"]
