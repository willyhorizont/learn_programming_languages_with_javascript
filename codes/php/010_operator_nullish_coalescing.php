<?php

echo("\n// JavaScript-like Nullish Coalescing Operator (??) in PHP" . "\n");

$JSON_OBJECT = [
    "foo" => [
        "bar" => "baz",
    ],
    "fruits" => ["apple", "mango", "banana"]
];
echo("JSON_OBJECT: " . str_replace("/\n$/", "", json_encode($JSON_OBJECT, JSON_PRETTY_PRINT)) . "\n");

echo("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): " . json_encode(@$JSON_OBJECT["foo"]["bar"] ?? "not found") . "\n");
// (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"

echo("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): " . json_encode(@$JSON_OBJECT["foo"]["baz"] ?? "not found") . "\n");
// (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

echo("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): " . json_encode(@$JSON_OBJECT["fruits"][2] ?? "not found") . "\n");
// (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "banana"

echo("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): " . json_encode(@$JSON_OBJECT["fruits"][5] ?? "not found") . "\n");
// (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"
