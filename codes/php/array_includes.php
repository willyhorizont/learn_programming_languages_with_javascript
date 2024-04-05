<?php

echo("\n// JavaScript-like Array.includes() in PHP" . "\n");
    
$my_friends = ['Alisa', 'Trivia'];
echo("my friends: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($my_friends))) . "\n");

$a_name = 'Alisa';
$is_my_friend = in_array($a_name, $my_friends);
echo("is my friends includes \"$a_name\": " . json_encode($is_my_friend) . "\n");
// is my friends includes "Alisa": true

$a_name = 'Trivia';
$is_my_friend = in_array($a_name, $my_friends);
echo("is my friends includes \"$a_name\": " . json_encode($is_my_friend) . "\n");
// is my friends includes "Trivia": true

$a_name = 'Tony';
$is_my_friend = in_array($a_name, $my_friends);
echo("is my friends includes \"$a_name\": " . json_encode($is_my_friend) . "\n");
// is my friends includes "Tony": false

$a_name = 'Ezekiel';
$is_my_friend = in_array($a_name, $my_friends);
echo("is my friends includes \"$a_name\": " . json_encode($is_my_friend) . "\n");
// is my friends includes "Ezekiel": false
