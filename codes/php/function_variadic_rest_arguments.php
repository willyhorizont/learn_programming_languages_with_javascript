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

console_log("// Variadic Function Rest Arguments in PHP");

function function_v1_variadic(...$rest_arguments) {
    console_log(string_interpolation("function v1 variadic rest arguments: ", [$rest_arguments]));
};
function_v1_variadic(1, 2, 3, 4);

$function_v2_variadic = function (...$rest_arguments) {
    console_log(string_interpolation("function v2 variadic rest arguments: ", [$rest_arguments]));
};
$function_v2_variadic(1, 2, 3, 4);

$function_v3_variadic = fn(...$rest_arguments) => console_log(string_interpolation("function v3 variadic rest arguments: ", [$rest_arguments]));
$function_v3_variadic(1, 2, 3, 4);
