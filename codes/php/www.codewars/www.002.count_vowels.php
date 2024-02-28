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

function count_vowels_v1($a_string) {
    return array_reduce(str_split($a_string),  fn($result, $letter) => (in_array($letter, ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"]) ? ($result + 1) : $result), 0);
}
echo(count_vowels_v1("Hello World") . "\n"); // 3

function count_vowels_v2($a_string) {
    return array_reduce(str_split($a_string),  fn($result, $letter) => (in_array(strtoupper($letter), ["A", "I", "U", "E", "O"]) ? ($result + 1) : $result), 0);
}
echo(count_vowels_v2("Hello World") . "\n"); // 3

function count_vowels_v3($a_string) {
    return array_reduce(str_split($a_string),  fn($result, $letter) => (str_contains("aiueoAIUEO", $letter) ? ($result + 1) : $result), 0);
}
echo(count_vowels_v3("Hello World") . "\n"); // 3

function count_vowels_v4($a_string) {
    return array_reduce(str_split($a_string),  fn($result, $letter) => (str_contains("AIUEO", strtoupper($letter)) ? ($result + 1) : $result), 0);
}
echo(count_vowels_v4("Hello World") . "\n"); // 3

function count_vowels_v5($a_string) {
    return count(array_values(array_filter(str_split($a_string),  fn($letter) => in_array($letter, ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"]))));
}
echo(count_vowels_v5("Hello World") . "\n"); // 3

function count_vowels_v6($a_string) {
    return count(array_values(array_filter(str_split($a_string),  fn($letter) => in_array(strtoupper($letter), ["A", "I", "U", "E", "O"]))));
}
echo(count_vowels_v6("Hello World") . "\n"); // 3

function count_vowels_v7($a_string) {
    return count(array_values(array_filter(str_split($a_string),  fn($letter) => str_contains("aiueoAIUEO", $letter))));
}
echo(count_vowels_v7("Hello World") . "\n"); // 3

function count_vowels_v8($a_string) {
    return count(array_values(array_filter(str_split($a_string),  fn($letter) => str_contains("AIUEO", strtoupper($letter)))));
}
echo(count_vowels_v8("Hello World") . "\n"); // 3
