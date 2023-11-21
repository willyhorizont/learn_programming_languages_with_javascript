<?php

function pretty_array_of_primitives($an_array_of_primitives) {
    $result = "[";
    foreach ($an_array_of_primitives as $array_item_index => $array_item) {
        if (is_numeric($array_item) === false && (gettype($array_item) !== "string")) {
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

// Array in PHP

$fruits = ["apple", "mango", "orange"];
echo("\nfruits: " . pretty_array_of_primitives($fruits));

echo("\n" . "fruits, length: " . count($fruits));
// fruits, length: 3

echo("\n" . "fruits, get mango: " . $fruits[1]);
// fruits, get mango: mango

echo("\n" . "fruits, first element: " . $fruits[0]);
// fruits, first element: apple

echo("\n" . "fruits, last element: " . end($fruits));
// fruits, last element: orange

foreach ($fruits as $array_item_index => $array_item) {
    echo("\n" . "fruits, foreach loop, index: " . $array_item_index . ", value: " . $array_item);
}
// fruits, foreach loop, index: 0, value: apple
// fruits, foreach loop, index: 1, value: mango
// fruits, foreach loop, index: 2, value: orange

// Array of Objects in PHP

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
echo("\nproducts: " . json_encode($products, JSON_PRETTY_PRINT));

foreach ($products as $array_item_index => $array_item) {
    foreach ($array_item as $object_key => $object_value) {
        echo("\n" . "products, foreach loop, index: " . $array_item_index . ", key: " . $object_key . ", value: " . $object_value);
    }
}
// products, foreach loop, index: 0, key: id, value: P1
// products, foreach loop, index: 0, key: name, value: bubble gum
// products, foreach loop, index: 1, key: id, value: P2
// products, foreach loop, index: 1, key: name, value: potato chips
