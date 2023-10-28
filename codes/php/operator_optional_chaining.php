<?php

function array_reduce_v1 ($callback_function, $an_array, $initial_value) {
    // JavaScript-like Array.array_reduce() function
    $result = null;
    foreach ($an_array as $array_item_index => $array_item) {
        $result = $result === null ? $initial_value : $result;
        if (gettype($initial_value) === "array" || gettype($initial_value) === "object") {
            $result = $result === null ? [] : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
        if (gettype($initial_value) === "integer" || gettype($initial_value) === "double") {
            $result = $result === null ? 0 : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
        if (gettype($initial_value) === "string") {
            $result = $result === null ? "" : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
        if (gettype($initial_value) === "boolean") {
            $result = $result === null ? false : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
        if ($initial_value === null || is_null($initial_value) || gettype($initial_value) === "NULL") {
            $result = $result === null ? null : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
    }
    return $result;
};

function optional_chaining_v1($an_object=[], ...$object_properties) {
    // JavaScript-like Optional Chaining Operator (?.) function
    return array_reduce($object_properties, fn($current_result, $current_dictionary) => ($current_result === null ? @$an_object[$current_dictionary] : @$current_result[$current_dictionary]), null);
};

// JavaScript-like Optional Chaining Operator (?.) function
$optional_chaining_v2 = fn($an_object=[], ...$object_properties) => array_reduce($object_properties, fn($current_result, $current_dictionary) => ($current_result === null ? @$an_object[$current_dictionary] : @$current_result[$current_dictionary]), null);

function optional_chaining_v3($an_object=[], ...$object_properties) {
    // JavaScript-like Optional Chaining Operator (?.) function
    return array_reduce_v1(fn($current_result, $current_dictionary) => ($current_result === null ? @$an_object[$current_dictionary] : @$current_result[$current_dictionary]), $object_properties, null);
};

// JavaScript-like Optional Chaining Operator (?.) function
$optional_chaining_v4 = fn($an_object=[], ...$object_properties) => array_reduce_v1(fn($current_result, $current_dictionary) => ($current_result === null ? @$an_object[$current_dictionary] : @$current_result[$current_dictionary]), $object_properties, null);

function optional_chaining_v5($an_object=[], $dictionary_properties_string_separated_by_dot='') {
    // JavaScript-like Optional Chaining Operator (?.) function
    return array_reduce(explode(".", $dictionary_properties_string_separated_by_dot), fn($current_result, $current_dictionary) => ($current_result === null ? @$an_object[$current_dictionary] : @$current_result[$current_dictionary]), null);
};

// JavaScript-like Optional Chaining Operator (?.) function
$optional_chaining_v6 = fn($an_object=[], $dictionary_properties_string_separated_by_dot='') => array_reduce(explode(".", $dictionary_properties_string_separated_by_dot), fn($current_result, $current_dictionary) => ($current_result === null ? @$an_object[$current_dictionary] : @$current_result[$current_dictionary]), null);

function optional_chaining_v7($an_object=[], $dictionary_properties_string_separated_by_dot='') {
    // JavaScript-like Optional Chaining Operator (?.) function
    return array_reduce_v1(fn($current_result, $current_dictionary) => ($current_result === null ? @$an_object[$current_dictionary] : @$current_result[$current_dictionary]), explode(".", $dictionary_properties_string_separated_by_dot), null);
};

// JavaScript-like Optional Chaining Operator (?.) function
$optional_chaining_v8 = fn($an_object=[], $dictionary_properties_string_separated_by_dot='') => array_reduce_v1(fn($current_result, $current_dictionary) => ($current_result === null ? @$an_object[$current_dictionary] : @$current_result[$current_dictionary]), explode(".", $dictionary_properties_string_separated_by_dot), null);

echo("\n\n// JavaScript-like Optional Chaining Operator (?.) in PHP");

$JSON_OBJECT = [
    "foo" => [
        "bar" => "baz",
    ]
];
echo("\nJSON_OBJECT: " . json_encode($JSON_OBJECT, JSON_PRETTY_PRINT));

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v1\"");
echo("\nJSON_OBJECT?.foo?.bar: " . (optional_chaining_v1($JSON_OBJECT, "foo", "bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v1\"");
echo("\nJSON_OBJECT?.foo?.baz: " . (optional_chaining_v1($JSON_OBJECT, "foo", "baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v2\"");
echo("\nJSON_OBJECT?.foo?.bar: " . ($optional_chaining_v2($JSON_OBJECT, "foo", "bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v2\"");
echo("\nJSON_OBJECT?.foo?.baz: " . ($optional_chaining_v2($JSON_OBJECT, "foo", "baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v3\"");
echo("\nJSON_OBJECT?.foo?.bar: " . (optional_chaining_v3($JSON_OBJECT, "foo", "bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v3\"");
echo("\nJSON_OBJECT?.foo?.baz: " . (optional_chaining_v3($JSON_OBJECT, "foo", "baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v4\"");
echo("\nJSON_OBJECT?.foo?.bar: " . ($optional_chaining_v4($JSON_OBJECT, "foo", "bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v4\"");
echo("\nJSON_OBJECT?.foo?.baz: " . ($optional_chaining_v4($JSON_OBJECT, "foo", "baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v5\"");
echo("\nJSON_OBJECT?.foo?.bar: " . (optional_chaining_v5($JSON_OBJECT, "foo.bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v5\"");
echo("\nJSON_OBJECT?.foo?.baz: " . (optional_chaining_v5($JSON_OBJECT, "foo.baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v6\"");
echo("\nJSON_OBJECT?.foo?.bar: " . ($optional_chaining_v6($JSON_OBJECT, "foo.bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v6\"");
echo("\nJSON_OBJECT?.foo?.baz: " . ($optional_chaining_v6($JSON_OBJECT, "foo.baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v7\"");
echo("\nJSON_OBJECT?.foo?.bar: " . (optional_chaining_v7($JSON_OBJECT, "foo.bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v7\"");
echo("\nJSON_OBJECT?.foo?.baz: " . (optional_chaining_v7($JSON_OBJECT, "foo.baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v8\"");
echo("\nJSON_OBJECT?.foo?.bar: " . ($optional_chaining_v8($JSON_OBJECT, "foo.bar") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using JavaScript-like Optional Chaining Operator (?.) function \"\$optional_chaining_v8\"");
echo("\nJSON_OBJECT?.foo?.baz: " . (optional_chaining_v7($JSON_OBJECT, "foo.baz") ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined

echo("\n// using PHP Error Control Operator (@).");
echo("\nJSON_OBJECT?.foo?.bar: " . (@$JSON_OBJECT["foo"]["bar"] ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: baz

echo("\n// using PHP Error Control Operator (@).");
echo("\nJSON_OBJECT?.foo?.baz: " . (@$JSON_OBJECT["foo"]["baz"] ?? "undefined"));
// $JSON_OBJECT?.foo?.bar: undefined
