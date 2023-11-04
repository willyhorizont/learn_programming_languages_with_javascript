<?php

echo("\n\n// JavaScript-like Optional Chaining Operator (?.) in PHP");

function optional_chaining_v1($an_object=[], ...$object_properties_array) {
    // JavaScript-like Optional Chaining Operator (?.) function
    return array_reduce($object_properties_array, fn($current_result, $current_item) => ($current_result === null ? @$an_object[$current_item] : @$current_result[$current_item]), null);
};

// JavaScript-like Optional Chaining Operator (?.) function
$optional_chaining_v2 = fn($an_object=[], ...$object_properties_array) => array_reduce($object_properties_array, fn($current_result, $current_item) => ($current_result === null ? @$an_object[$current_item] : @$current_result[$current_item]), null);

function optional_chaining_v3($an_object=[], $object_properties_string='') {
    // JavaScript-like Optional Chaining Operator (?.) function
    return array_reduce(explode(".", $object_properties_string), fn($current_result, $current_item) => ($current_result === null ? @$an_object[$current_item] : @$current_result[$current_item]), null);
};

// JavaScript-like Optional Chaining Operator (?.) function
$optional_chaining_v4 = fn($an_object=[], $object_properties_string='') => array_reduce(explode(".", $object_properties_string), fn($current_result, $current_item) => ($current_result === null ? @$an_object[$current_item] : @$current_result[$current_item]), null);

$JSON_OBJECT = [
    "foo" => [
        "bar" => "baz",
    ]
];
echo("\nJSON_OBJECT: " . json_encode($JSON_OBJECT, JSON_PRETTY_PRINT));

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v1\"");

echo("\nJSON_OBJECT?.foo?.bar: " . (optional_chaining_v1($JSON_OBJECT, "foo", "bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\nJSON_OBJECT?.foo?.baz: " . (optional_chaining_v1($JSON_OBJECT, "foo", "baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v2\"");

echo("\nJSON_OBJECT?.foo?.bar: " . ($optional_chaining_v2($JSON_OBJECT, "foo", "bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\nJSON_OBJECT?.foo?.baz: " . ($optional_chaining_v2($JSON_OBJECT, "foo", "baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v3\"");

echo("\nJSON_OBJECT?.foo?.bar: " . (optional_chaining_v3($JSON_OBJECT, "foo.bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz


echo("\nJSON_OBJECT?.foo?.baz: " . (optional_chaining_v3($JSON_OBJECT, "foo.baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v4\"");

echo("\nJSON_OBJECT?.foo?.bar: " . ($optional_chaining_v4($JSON_OBJECT, "foo.bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz


echo("\nJSON_OBJECT?.foo?.baz: " . ($optional_chaining_v4($JSON_OBJECT, "foo.baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using PHP Error Control Operator (@).");
echo("\nJSON_OBJECT?.foo?.bar: " . (@$JSON_OBJECT["foo"]["bar"] ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using PHP Error Control Operator (@).");
echo("\nJSON_OBJECT?.foo?.baz: " . (@$JSON_OBJECT["foo"]["baz"] ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined
