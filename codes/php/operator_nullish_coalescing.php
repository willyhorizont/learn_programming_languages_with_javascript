<?php

echo("\n\n// JavaScript-like Nullish Coalescing Operator (??) in PHP");

$JSON_OBJECT = [
    "foo" => [
        "bar" => "baz",
    ]
];
echo("\nJSON_OBJECT: " . json_encode($JSON_OBJECT, JSON_PRETTY_PRINT));

echo("\nJSON_OBJECT?.foo?.bar: " . (@$JSON_OBJECT["foo"]["bar"] ?? "not found"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\nJSON_OBJECT?.foo?.baz: " . (@$JSON_OBJECT["foo"]["baz"] ?? "not found"));
// $JSON_OBJECT?.foo?.bar: not found
