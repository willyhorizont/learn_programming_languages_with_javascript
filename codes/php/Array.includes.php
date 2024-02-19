<?php

echo("\n\n// JavaScript-like Array.includes() in PHP");

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
echo("\nmy friends: " . pretty_array_of_primitives($my_friends));

$name = 'Alisa';
echo("\nname: \"$name\"");
$is_my_friend = in_array($name, $my_friends) === false ? 'false' : 'true';
echo("\nis my friends includes \"$name\": $is_my_friend");
// is my friends includes "Alisa": true

$name = 'Trivia';
echo("\nname: \"$name\"");
$is_my_friend = in_array($name, $my_friends) === false ? 'false' : 'true';
echo("\nis my friends includes \"$name\": $is_my_friend");
// is my friends includes "Trivia": true

$name = 'Tony';
echo("\nname: \"$name\"");
$is_my_friend = in_array($name, $my_friends) === false ? 'false' : 'true';
echo("\nis my friends includes \"$name\": $is_my_friend");
// is my friends includes "Tony": false

$name = 'Ezekiel';
echo("\nname: \"$name\"");
$is_my_friend = in_array($name, $my_friends) === false ? 'false' : 'true';
echo("\nis my friends includes \"$name\": $is_my_friend");
// is my friends includes "Ezekiel": false
