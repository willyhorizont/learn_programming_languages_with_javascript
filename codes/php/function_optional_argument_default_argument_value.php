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

console_log("// Function Optional Argument and Function Default Argument Value in PHP");

function function_v1_optional_argument_default_argument_value($anything, $optional_argument = ["pretty" => false]) {
    $pretty = (@$optional_argument["pretty"] ?? false);
    console_log(string_interpolation("optional argument default value function v1 optional argument pretty: ", [$pretty]));
};
function_v1_optional_argument_default_argument_value(["apple", "banana", "cherry"], ["pretty" => true]);
function_v1_optional_argument_default_argument_value(["apple", "banana", "cherry"]);

$function_v2_optional_argument_default_argument_value = function ($anything, $optional_argument = ["pretty" => false]) {
    $pretty = (@$optional_argument["pretty"] ?? false);
    console_log(string_interpolation("optional argument default value function v2 optional argument pretty: ", [$pretty]));
};
$function_v2_optional_argument_default_argument_value(["apple", "banana", "cherry"], ["pretty" => true]);
$function_v2_optional_argument_default_argument_value(["apple", "banana", "cherry"]);

$function_v3_optional_argument_default_argument_value = fn($anything, $optional_argument = ["pretty" => false]) => console_log(string_interpolation("optional argument default value function v3 optional argument pretty: ", [(@$optional_argument["pretty"] ?? false)]));
$function_v3_optional_argument_default_argument_value(["apple", "banana", "cherry"], ["pretty" => true]);
$function_v3_optional_argument_default_argument_value(["apple", "banana", "cherry"]);
