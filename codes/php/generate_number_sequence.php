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

function generate_number_sequence($start_number, $stop_number) {
    if ($stop_number > $start_number) return range($start_number, $stop_number);
    if ($start_number > $stop_number) return range($start_number, $stop_number);
    return [0];
};

console_log(string_interpolation("generate_number_sequence(0, 9): ", [generate_number_sequence(0, 9)]));
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
console_log(string_interpolation("generate_number_sequence(1, 10): ", [generate_number_sequence(1, 10)]));
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console_log(string_interpolation("generate_number_sequence(10, 1): ", [generate_number_sequence(10, 1)]));
# [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
console_log(string_interpolation("generate_number_sequence(9, 0): ", [generate_number_sequence(9, 0)]));
# [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

console_log(string_interpolation("range(0, 9): ", [range(0, 9)]));
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
console_log(string_interpolation("range(1, 10): ", [range(1, 10)]));
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console_log(string_interpolation("range(10, 1): ", [range(10, 1)]));
# [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
console_log(string_interpolation("range(9, 0): ", [range(9, 0)]));
# [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
