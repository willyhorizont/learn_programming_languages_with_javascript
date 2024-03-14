<?php

echo("\n\n// JavaScript-like Array.includes() in PHP");

function bool_to_string($anything) {
    if (is_bool($anything) === false) throw new Exception("Expecting Boolean as argument");
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

$a_name = 'Alisa';
$is_my_friend = bool_to_string(in_array($a_name, $my_friends) === false);
echo("\n" . "is my friends includes \"$a_name\": $is_my_friend");
// is my friends includes "Alisa": true

$a_name = 'Trivia';
$is_my_friend = bool_to_string(in_array($a_name, $my_friends) === false);
echo("\n" . "is my friends includes \"$a_name\": $is_my_friend");
// is my friends includes "Trivia": true

$a_name = 'Tony';
$is_my_friend = bool_to_string(in_array($a_name, $my_friends) === false);
echo("\n" . "is my friends includes \"$a_name\": $is_my_friend");
// is my friends includes "Tony": false

$a_name = 'Ezekiel';
$is_my_friend = bool_to_string(in_array($a_name, $my_friends) === false);
echo("\n" . "is my friends includes \"$a_name\": $is_my_friend");
// is my friends includes "Ezekiel": false
