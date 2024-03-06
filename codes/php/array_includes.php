<?php

echo("\n\n// JavaScript-like Array.includes() in PHP");

function bool_to_string($anything) {
    if (is_bool($anything) === false) return "not bool";
    return (($anything === true) ? "true" : "false");
}

function pretty_array_of_primitives($an_array_of_primitives) {
    $result = "[";
    foreach ($an_array_of_primitives as $array_item_index => $array_item) {
        if (is_numeric($array_item) === false && (gettype($array_item) !== "string") && (is_bool($array_item) === false) && $array_item !== null) {
            continue;
        }
        if ($array_item === null) {
            $result = $result . "null";
        }
        if ($array_item === true) {
            $result = $result . "true";
        }
        if ($array_item === false) {
            $result = $result . "false";
        }
        if (gettype($array_item) === "string") {
            $result = $result . "\"" . $array_item . "\"";
        }
        if (is_numeric($array_item) === true) {
            $result = $result . $array_item;
        }
        if (($array_item_index + 1) !== count($an_array_of_primitives)){
            $result = $result . ", ";
        }
    }
    $result = $result . "]";
    return $result;
};
    
$my_friends = ['Alisa', 'Trivia'];
echo("\n" . "my friends: " . pretty_array_of_primitives($my_friends));

$name = 'Alisa';
echo("\n" . "name: \"$name\"");
$is_my_friend = bool_to_string(in_array($name, $my_friends) === false);
echo("\n" . "is my friends includes \"$name\": $is_my_friend");
// is my friends includes "Alisa": true

$name = 'Trivia';
echo("\n" . "name: \"$name\"");
$is_my_friend = bool_to_string(in_array($name, $my_friends) === false);
echo("\n" . "is my friends includes \"$name\": $is_my_friend");
// is my friends includes "Trivia": true

$name = 'Tony';
echo("\n" . "name: \"$name\"");
$is_my_friend = bool_to_string(in_array($name, $my_friends) === false);
echo("\n" . "is my friends includes \"$name\": $is_my_friend");
// is my friends includes "Tony": false

$name = 'Ezekiel';
echo("\n" . "name: \"$name\"");
$is_my_friend = bool_to_string(in_array($name, $my_friends) === false);
echo("\n" . "is my friends includes \"$name\": $is_my_friend");
// is my friends includes "Ezekiel": false
