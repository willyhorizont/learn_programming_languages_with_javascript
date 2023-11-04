<?php

$my_fruits_in_fridge = ["apple", "mango", "orange"];

echo("\narray length: " . count($my_fruits_in_fridge));

foreach ($my_fruits_in_fridge as $array_item_index => $array_item) {
    echo("\n" . $array_item_index);
}

// array length: 3
// 0
// 1
// 2
