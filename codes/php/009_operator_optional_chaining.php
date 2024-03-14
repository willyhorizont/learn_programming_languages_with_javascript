<?php

echo("\n\n// JavaScript-like Optional Chaining Operator (?.) in PHP");

// There's no JavaScript-like Optional Chaining Operator (?.) in Lua.
// But, we can use PHP Error Control Operator (@) to mimic it in PHP.

$JSON_OBJECT = [
    "foo" => [
        "bar" => "baz",
    ],
    "fruits" => ["apple", "mango", "banana"]
];
echo("\n" . "JSON_OBJECT: " . json_encode($JSON_OBJECT, JSON_PRETTY_PRINT));

echo("\n// using PHP Error Control Operator (@).");

echo("\n" . "JSON_OBJECT?.foo?.bar: " . json_encode(@$JSON_OBJECT["foo"]["bar"]));
// JSON_OBJECT?.foo?.bar: "baz"

echo("\n" . "JSON_OBJECT?.foo?.baz: " . json_encode(@$JSON_OBJECT["foo"]["baz"]));
// JSON_OBJECT?.foo?.bar: null

echo("\n" . "JSON_OBJECT?.fruits?.[2]: " . json_encode(@$JSON_OBJECT["fruits"][2]));
// JSON_OBJECT?.fruits?.[2]: "banana"

echo("\n" . "JSON_OBJECT?.fruits?.[5]: " . json_encode(@$JSON_OBJECT["fruits"][5]));
// JSON_OBJECT?.fruits?.[5]: null
