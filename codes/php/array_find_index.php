<?php

// There's no JavaScript-like Array.findIndex() in PHP.
// But, we can create our own function to mimic it in PHP.

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

function array_find_index_v1($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $data_found_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === true) {
            $data_found_index = $array_item_index;
            break;
        }
    }
    return $data_found_index;
};

function array_find_index_v2($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $data_found_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) {
            $data_found_index = $array_item_index;
            break;
        }
    }
    return $data_found_index;
};

function array_find_index_v3($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === true) {
            return $array_item_index;
        }
    }
    return -1;
};

function array_find_index_v4($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) {
            return $array_item_index;
        }
    }
    return -1;
};

echo("\n\n// JavaScript-like Array.findIndex() in PHP array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\n" . "numbers: " . pretty_array_of_primitives($numbers));

$number_to_find = 27;
echo("\n" . "number to find: $number_to_find");

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v1\"");

$number_found_index = array_find_index_v1(fn($number) => ($number === $number_to_find), $numbers);
echo("\n" . "number found index: $number_found_index");
// number found index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v2\"");

$number_found_index = array_find_index_v2(fn($number) => ($number === $number_to_find), $numbers);
echo("\n" . "number found index: $number_found_index");
// number found index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v3\"");

$number_found_index = array_find_index_v3(fn($number) => ($number === $number_to_find), $numbers);
echo("\n" . "number found index: $number_found_index");
// number found index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v4\"");

$number_found_index = array_find_index_v4(fn($number) => ($number === $number_to_find), $numbers);
echo("\n" . "number found index: $number_found_index");
// number found index: 2

echo("\n\n// JavaScript-like Array.findIndex() in PHP array of associative-arrays");

$products = [
    [
        "code" => "pasta",
        "price" => 321
    ],
    [
        "code" => "bubble_gum",
        "price" => 233
    ],
    [
        "code" => "potato_chips",
        "price" => 5
    ],
    [
        "code" => "towel",
        "price" => 499
    ]
];
echo("\n" . "products: " . json_encode($products, JSON_PRETTY_PRINT));

$product_to_find = 'pasta';
echo("\n" . "product to find: $product_to_find");

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v1\"");

$product_found_index = array_find_index_v1(fn($product) => (@$product['code'] === $product_to_find), $products);
echo("\n" . "product found index: $product_found_index");
// product found index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v2\"");

$product_found_index = array_find_index_v2(fn($product) => (@$product['code'] === $product_to_find), $products);
echo("\n" . "product found index: $product_found_index");
// product found index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v3\"");

$product_found_index = array_find_index_v3(fn($product) => (@$product['code'] === $product_to_find), $products);
echo("\n" . "product found index: $product_found_index");
// product found index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v4\"");

$product_found_index = array_find_index_v4(fn($product) => (@$product['code'] === $product_to_find), $products);
echo("\n" . "product found index: $product_found_index");
// product found index: 0
