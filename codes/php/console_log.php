<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    $pretty = ($optional_argument["pretty"] ?? false);
    return (($pretty === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
};

function console_log(...$rest_arguments) {
    echo join("", $rest_arguments) . "\n";
};

function string_interpolation(...$rest_arguments) {
    return array_reduce($rest_arguments,  fn($current_result, $current_argument) => ($current_result . (((is_array($current_argument) === true) && count($current_argument) === 1) ? (json_stringify(@$current_argument[0])) : ($current_argument))), "");
};

console_log("// JavaScript-like console.log() in PHP");

$any_string = "foo";
$any_numeric = 123;
$any_boolean = true;
$any_null = null;
$any_array = [1, 2, 3];
$any_object = ["foo" => "bar"];

echo "any string: ", json_stringify($any_string), ", any numeric: ", json_stringify($any_numeric), ", any boolean: ", json_stringify($any_boolean), ", any null: ", json_stringify($any_null), ", any array: ", json_stringify($any_array), ", any object: ", json_stringify($any_object), "\n";

echo "any string: " . json_stringify($any_string), ", any numeric: " . json_stringify($any_numeric), ", any boolean: " . json_stringify($any_boolean), ", any null: " . json_stringify($any_null), ", any array: " . json_stringify($any_array), ", any object: " . json_stringify($any_object), "\n";

console_log("any string: ", json_stringify($any_string), ", any numeric: ", json_stringify($any_numeric), ", any boolean: ", json_stringify($any_boolean), ", any null: ", json_stringify($any_null), ", any array: ", json_stringify($any_array), ", any object: ", json_stringify($any_object));

console_log(string_interpolation("any string: ", [$any_string], ", any numeric: ", [$any_numeric], ", any boolean: ", [$any_boolean], ", any null: ", [$any_null], ", any array: ", [$any_array], ", any object: ", [$any_object]));
