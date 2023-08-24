<?php

echo("\n\n// JavaScript-like Array.includes() in PHP");
    
$my_friends = ['Alisa', 'Trivia'];
echo("\nmy friends: " . str_replace(",", ", ", json_encode($my_friends)));

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
