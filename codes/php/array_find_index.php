<?php

// There's no JavaScript-like Array.findIndex() in PHP.
// But, we can create our own function to mimic it in PHP.

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

echo("\n// JavaScript-like Array.findIndex() in PHP array" . "\n");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("numbers: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers))) . "\n");

$number_to_find = 27;
echo("number to find: $number_to_find" . "\n");

echo("// using JavaScript-like Array.findIndex() function \"array_find_index_v1\"" . "\n");

$number_found_index = array_find_index_v1(fn($number) => ($number === $number_to_find), $numbers);
echo("number found index: $number_found_index" . "\n");
// number found index: 2

echo("// using JavaScript-like Array.findIndex() function \"array_find_index_v2\"" . "\n");

$number_found_index = array_find_index_v2(fn($number) => ($number === $number_to_find), $numbers);
echo("number found index: $number_found_index" . "\n");
// number found index: 2

echo("// using JavaScript-like Array.findIndex() function \"array_find_index_v3\"" . "\n");

$number_found_index = array_find_index_v3(fn($number) => ($number === $number_to_find), $numbers);
echo("number found index: $number_found_index" . "\n");
// number found index: 2

echo("// using JavaScript-like Array.findIndex() function \"array_find_index_v4\"" . "\n");

$number_found_index = array_find_index_v4(fn($number) => ($number === $number_to_find), $numbers);
echo("number found index: $number_found_index" . "\n");
// number found index: 2

echo("\n// JavaScript-like Array.findIndex() in PHP array of associative-arrays" . "\n");

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
echo("products: " . str_replace("/\n$/", "", json_encode($products, JSON_PRETTY_PRINT)) . "\n");

$product_to_find = 'pasta';
echo("product to find: $product_to_find" . "\n");

echo("// using JavaScript-like Array.findIndex() function \"array_find_index_v1\"" . "\n");

$product_found_index = array_find_index_v1(fn($product) => ($product['code'] === $product_to_find), $products);
echo("product found index: $product_found_index" . "\n");
// product found index: 0

echo("// using JavaScript-like Array.findIndex() function \"array_find_index_v2\"" . "\n");

$product_found_index = array_find_index_v2(fn($product) => ($product['code'] === $product_to_find), $products);
echo("product found index: $product_found_index" . "\n");
// product found index: 0

echo("// using JavaScript-like Array.findIndex() function \"array_find_index_v3\"" . "\n");

$product_found_index = array_find_index_v3(fn($product) => ($product['code'] === $product_to_find), $products);
echo("product found index: $product_found_index" . "\n");
// product found index: 0

echo("// using JavaScript-like Array.findIndex() function \"array_find_index_v4\"" . "\n");

$product_found_index = array_find_index_v4(fn($product) => ($product['code'] === $product_to_find), $products);
echo("product found index: $product_found_index" . "\n");
// product found index: 0
