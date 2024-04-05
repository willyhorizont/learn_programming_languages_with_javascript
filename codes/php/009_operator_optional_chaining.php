<?php

echo("\n// JavaScript-like Optional Chaining Operator (?.) in PHP" . "\n");

// There's no JavaScript-like Optional Chaining Operator (?.) in Lua.
// But, we can use PHP Error Control Operator (@) to mimic it in PHP.

$JSON_OBJECT = [
    "foo" => [
        "bar" => "baz",
    ],
    "fruits" => ["apple", "mango", "banana"]
];
echo("JSON_OBJECT: " . str_replace("/\n$/", "", json_encode($JSON_OBJECT, JSON_PRETTY_PRINT)) . "\n");

echo("// using PHP Error Control Operator (@)." . "\n");

echo("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: " . json_encode(@$JSON_OBJECT["foo"]["bar"]) . "\n");
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

echo("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: " . json_encode(@$JSON_OBJECT["foo"]["baz"]) . "\n");
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

echo("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: " . json_encode(@$JSON_OBJECT["fruits"][2]) . "\n");
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "banana"

echo("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: " . json_encode(@$JSON_OBJECT["fruits"][5]) . "\n");
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
