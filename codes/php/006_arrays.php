<?php

// in PHP, JavaScript-like Array is called array

$fruits = ["apple", "mango", "orange"];
echo("fruits: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($fruits))) . "\n");

echo("fruits, length: " . count($fruits) . "\n");
// fruits, length: 3

echo("fruits, get mango: " . $fruits[1] . "\n");
// fruits, get mango: mango

echo("fruits, first element: " . $fruits[0] . "\n");
// fruits, first element: apple

echo("fruits, last element: " . end($fruits) . "\n");
// fruits, last element: orange

foreach ($fruits as $array_item_index => $array_item) {
    echo("fruits, forEach loop, index: " . $array_item_index . ", value: " . $array_item . "\n");
}
// fruits, forEach loop, index: 0, value: apple
// fruits, forEach loop, index: 1, value: mango
// fruits, forEach loop, index: 2, value: orange

// in PHP, JavaScript-like Array of Objects is called array of associative-arrays

$products = [
    [
        "id" => "P1",
        "name" => "bubble gum"
    ],
    [
        "id" => "P2",
        "name" => "potato chips"
    ]
];
echo("products: " . str_replace("/\n$/", "", json_encode($products, JSON_PRETTY_PRINT)) . "\n");

foreach ($products as $array_item_index => $array_item) {
    $object_iteration_index = 0;
    foreach ($array_item as $object_key => $object_value) {
        echo("products, forEach loop, array item index: " . $array_item_index . ", object iteration/entry index: " . $object_iteration_index . ", key: " . $object_key . ", value: " . $object_value . "\n");
        $object_iteration_index += 1;
    }
}
// products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
// products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
// products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
// products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
