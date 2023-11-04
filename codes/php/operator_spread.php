<?php

echo("\n\n// JavaScript-like Spread Syntax in PHP Array");

function pretty_array_of_primitives($an_array_of_primitives) {
    $result = "[";
    foreach ($an_array_of_primitives as $array_item_index => $array_item) {
        if (is_numeric($array_item) === false && gettype($array_item) !== "string") {
            continue;
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

$my_fruits_in_fridge = ["apple", "mango", "orange"];
echo("\nmy fruits in fridge: " . pretty_array_of_primitives($my_fruits_in_fridge));

$my_fruits_from_grocery_store = ["melon", "banana"];
echo("\nmy fruits from grocery store: " . pretty_array_of_primitives($my_fruits_from_grocery_store));

$my_fruits = [...$my_fruits_in_fridge, ...$my_fruits_from_grocery_store];
echo("\nmy fruits: " . pretty_array_of_primitives($my_fruits));
// my fruits: ["apple", "mango", "orange", "melon", "banana"]

echo("\n\n// Spread Syntax in PHP Associative Array");

$general_car = [
    "wheels" => 4,
    "tires" => 4
];
echo("\ngeneral car: " . json_encode($general_car, JSON_PRETTY_PRINT));

$minivan_car = [...$general_car, "doors" => 4];
echo("\nminivan car: " . json_encode($minivan_car, JSON_PRETTY_PRINT));
// minivan car: {
//     "wheels": 4,
//     "tires": 4,
//     "doors": 4
// }

$super_car = [...$general_car, "doors" => 2];
echo("\nsuper car: " . json_encode($super_car, JSON_PRETTY_PRINT));
// super car: {
//     "wheels": 4,
//     "tires": 4,
//     "doors": 2
// }
