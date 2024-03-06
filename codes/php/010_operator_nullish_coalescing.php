<?php

echo("\n\n// JavaScript-like Nullish Coalescing Operator (??) in PHP");

$JSON_OBJECT = [
    "foo" => [
        "bar" => "baz",
    ],
    "fruits" => ["apple", "mango", "banana"]
];
echo("\n" . "JSON_OBJECT: " . json_encode($JSON_OBJECT, JSON_PRETTY_PRINT));

echo("\n(JSON_OBJECT?.foo?.bar ?? \"not found\"): " . json_encode(@$JSON_OBJECT["foo"]["bar"] ?? "not found"));
// (JSON_OBJECT?.foo?.bar ?? "not found"): "baz"

echo("\n(JSON_OBJECT?.foo?.baz ?? \"not found\"): " . json_encode(@$JSON_OBJECT["foo"]["baz"] ?? "not found"));
// (JSON_OBJECT?.foo?.bar ?? "not found"): "not found"

echo("\n(JSON_OBJECT?.fruits?.[2] ?? \"not found\"): " . json_encode(@$JSON_OBJECT["fruits"][2] ?? "not found"));
// (JSON_OBJECT?.fruits?.[2] ?? "not found"): "banana"

echo("\n(JSON_OBJECT?.fruits?.[5] ?? \"not found\"): " . json_encode(@$JSON_OBJECT["fruits"][5] ?? "not found"));
// (JSON_OBJECT?.fruits?.[5] ?? "not found"): "not found"
