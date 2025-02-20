<?php

/*
    Source:
        https://www.codewars.com/kata/54ff3102c1bad923760001f3
    Title:
        Vowel Count
    Description:
        Return the number (count) of vowels in the given string.
        We will consider a, e, i, o, u as vowels for this Kata (but not y).
        The input string will only consist of lower case letters and/or spaces.
*/

function count_vowels_v1($any_string) {
    return array_reduce(str_split($any_string), (fn($current_result, $any_character) => (in_array($any_character, ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"]) ? ($current_result + 1) : $current_result)), 0);
};
echo count_vowels_v1("Hello World") . "\n"; // 3

function count_vowels_v2($any_string) {
    return array_reduce(str_split($any_string), (fn($current_result, $any_character) => (in_array(strtoupper($any_character), ["A", "I", "U", "E", "O"]) ? ($current_result + 1) : $current_result)), 0);
};
echo count_vowels_v2("Hello World") . "\n"; // 3

function count_vowels_v3($any_string) {
    return array_reduce(str_split($any_string), (fn($current_result, $any_character) => (str_contains("aiueoAIUEO", $any_character) ? ($current_result + 1) : $current_result)), 0);
};
echo count_vowels_v3("Hello World") . "\n"; // 3

function count_vowels_v4($any_string) {
    return array_reduce(str_split($any_string), (fn($current_result, $any_character) => (str_contains("AIUEO", strtoupper($any_character)) ? ($current_result + 1) : $current_result)), 0);
};
echo count_vowels_v4("Hello World") . "\n"; // 3

function count_vowels_v5($any_string) {
    return count(array_values(array_filter(str_split($any_string), (fn($any_character) => (in_array($any_character, ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"]))))));
};
echo count_vowels_v5("Hello World") . "\n"; // 3

function count_vowels_v6($any_string) {
    return count(array_values(array_filter(str_split($any_string), (fn($any_character) => (in_array(strtoupper($any_character), ["A", "I", "U", "E", "O"]))))));
};
echo count_vowels_v6("Hello World") . "\n"; // 3

function count_vowels_v7($any_string) {
    return count(array_values(array_filter(str_split($any_string), (fn($any_character) => (str_contains("aiueoAIUEO", $any_character))))));
};
echo count_vowels_v7("Hello World") . "\n"; // 3

function count_vowels_v8($any_string) {
    return count(array_values(array_filter(str_split($any_string), (fn($any_character) => (str_contains("AIUEO", strtoupper($any_character)))))));
};
echo count_vowels_v8("Hello World") . "\n"; // 3
