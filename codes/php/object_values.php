<?php

echo("\n// JavaScript-like Object.values() in PHP associative-array" . "\n");

$friend = [
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
];
echo("friend: " . str_replace("/\n$/", "", json_encode($friend, JSON_PRETTY_PRINT)) . "\n");

echo("friend values: " . str_replace(",", ", ", str_replace(":", ": ", json_encode(array_values($friend)))) . "\n");
// friend values: ["Alisa", "Finland", 25]
