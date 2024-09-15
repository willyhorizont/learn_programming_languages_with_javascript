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

console_log("// Immediately Invoked Function Expression (IIFE) in PHP");
console_log("// a Self-Executing Anonymous Function that runs as soon as it is defined");
console_log("// https://developer.mozilla.org/en-US/docs/Glossary/IIFE");

(function () {
    console_log("// self-executing after defined");
})();

(fn() => console_log("// self-executing after defined"))();
