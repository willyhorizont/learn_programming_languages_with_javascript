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

console_log("// JavaScript-like Array in PHP (array)");

$fruits = ["apple", "mango", "orange"];
console_log(string_interpolation("fruits: ", [$fruits]));

console_log(string_interpolation("fruits, length: ", [count($fruits)]));
// fruits, length: 3

console_log(string_interpolation("fruits, get mango: ", [$fruits[1]]));
// fruits, get mango: mango

console_log(string_interpolation("fruits, get mango: ", [@$fruits[1]]));
// fruits, get mango: mango

console_log(string_interpolation("fruits, first element: ", [$fruits[0]]));
// fruits, first element: apple

console_log(string_interpolation("fruits, first element: ", [@$fruits[0]]));
// fruits, first element: apple

console_log(string_interpolation("fruits, last element: ", [end($fruits)])); // don't use this, this will throw error when array is empty
// fruits, last element: orange

console_log(string_interpolation("fruits, last element: ", [@$fruits[(count($fruits) - 1)]]));
// fruits, last element: orange

// iterate over and print each item and index
for ($array_item_index = 0; ($array_item_index < count($fruits)); $array_item_index += 1) {
    $array_item = $fruits[$array_item_index];
    console_log(string_interpolation("fruits, for loop, index: ", [$array_item_index], ", value: ", [$array_item]));
}
// fruits, for loop, index: 0, value: apple
// fruits, for loop, index: 1, value: mango
// fruits, for loop, index: 2, value: orange

// iterate over and print each item and index
foreach ($fruits as $array_item_index => $array_item) {
    console_log(string_interpolation("fruits, for each loop, index: ", [$array_item_index], ", value: ", [$array_item]));
}
// fruits, for each loop, index: 0, value: apple
// fruits, for each loop, index: 1, value: mango
// fruits, for each loop, index: 2, value: orange

array_push($fruits, "banana");
console_log(string_interpolation("fruits: ", [$fruits]));
// fruits: ["apple", "mango", "orange", "banana"]

$fruits = [...$fruits, "kiwi"];
console_log(string_interpolation("fruits: ", [$fruits]));
// fruits: ["apple", "mango", "orange", "banana", "kiwi"]
