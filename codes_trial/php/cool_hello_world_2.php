<?php

$characters_string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ `~!@#$%^&*()_+-=[]\\{}|;':\",./<>?";
$target_string = "Hello, World!";
$result_container = array_map(fn($any_character) => [$any_character, ''], str_split($target_string));

function python_like_sleep($seconds) {
    $mili_seconds_in_micro_seconds = 1_000;
    $seconds_in_miliseconds = 1_000 * $mili_seconds_in_micro_seconds;
    usleep($seconds * $seconds_in_miliseconds);
}

function print_character($expected_printed_character, $target_string_index) {
    global $characters_string;
    global $result_container;
    $printed_character = $result_container[$target_string_index][1];

    while ($printed_character !== $expected_printed_character) {
        $any_character = $characters_string[random_int(0, (strlen($characters_string) - 1))];
        $printed_character = $any_character;
        $result_container[$target_string_index] = [$result_container[$target_string_index][0], $any_character];
        $resultString = array_reduce($result_container, fn($current_result, $current_array) => ($current_result . $current_array[1]), "");
        echo $resultString . "\n";
        python_like_sleep(0.05);
    }
}

function main() {
    global $target_string;

    $print_character_processes = [];

    foreach (str_split($target_string) as $target_string_index => $any_character) {
        $print_character_processes[$target_string_index] = function () use ($any_character, $target_string_index) {
            print_character($any_character, $target_string_index);
        };
    }

    foreach ($print_character_processes as $print_character_process) {
        $print_character_process();
    }
}

main();
