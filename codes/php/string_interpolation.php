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

console_log("JavaScript-like Template literals / Template strings (String Interpolation) in PHP (none 🤮)");

console_log(string_interpolation("1 + 2 + 3 + 4 = ", [1 + 2 + 3 + 4]));

$my_name = "Alisa";
$my_age = 25;
console_log(string_interpolation("my name is ", [$my_name], " and I am ", [$my_age], "."));

$any_string = "foo";
console_log(string_interpolation("any string: ", [$any_string]));

$any_numeric = 123;
console_log(string_interpolation("any numeric: ", [$any_numeric]));

$any_boolean = true;
console_log(string_interpolation("any boolean: ", [$any_boolean]));

$any_null = null;
console_log(string_interpolation("any null: ", [$any_null]));

$any_array = [1, 2, 3];
console_log(string_interpolation("any array: ", [$any_array]));
console_log(string_interpolation("any array first element: ", [@$any_array[0]]));

$any_object = ["foo" => "bar"];
console_log(string_interpolation("any object: ", [$any_object]));
console_log(string_interpolation("any object foo value: ", [@$any_object["foo"]]));
