<?php

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

// in PHP, JavaScript-like Array is called array

$fruits = ["apple", "mango", "orange"];
echo("\n" . "fruits: " . pretty_array_of_primitives($fruits));

echo("\n" . "fruits, length: " . count($fruits));
// fruits, length: 3

echo("\n" . "fruits, get mango: " . $fruits[1]);
// fruits, get mango: mango

echo("\n" . "fruits, first element: " . $fruits[0]);
// fruits, first element: apple

echo("\n" . "fruits, last element: " . end($fruits));
// fruits, last element: orange

foreach ($fruits as $array_item_index => $array_item) {
    echo("\n" . "fruits, forEach loop, index: " . $array_item_index . ", value: " . $array_item);
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
echo("\n" . "products: " . json_encode($products, JSON_PRETTY_PRINT));

foreach ($products as $array_item_index => $array_item) {
    $object_iteration_index = 0;
    foreach ($array_item as $object_key => $object_value) {
        echo("\n" . "products, forEach loop, array item index: " . $array_item_index . ", object iteration/entry index: " . $object_iteration_index . ", key: " . $object_key . ", value: " . $object_value);
        $object_iteration_index += 1;
    }
}
// products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
// products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
// products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
// products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
