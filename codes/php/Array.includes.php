<?php

echo("\n\n// JavaScript-like Array.includes() in PHP");

function pretty_array_of_primitives($an_array_of_primitives) {
    return str_replace(",", ", ", json_encode($an_array_of_primitives));
};
    
$my_friends = ['Alisa', 'Trivia'];
echo("\nmy friends: " . pretty_array_of_primitives($my_friends));

$name = 'Alisa';
echo("\nname: \"$name\"");
$is_my_friend = in_array($name, $my_friends) === false ? 'false' : 'true';
echo("\nis my friends includes \"$name\": $is_my_friend");
// is my friends includes "Alisa": true

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
