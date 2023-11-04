<?php

// There's no JavaScript-like Array.findIndex() in PHP.
// But, we can create our own function to mimic it in PHP.

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

function array_find_index_v1($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $item_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === true) {
            $item_index = $array_item_index;
            break;
        }
    }
    return $item_index;
};

function array_find_index_v2($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $item_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) {
            $item_index = $array_item_index;
            break;
        }
    }
    return $item_index;
};

function array_find_index_v3($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $item_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === true) {
            return $array_item_index;
        }
    }
    return $item_index;
};

function array_find_index_v4($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $item_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) {
            return $array_item_index;
        }
    }
    return $item_index;
};

function array_find_index_v5($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === true) {
            return $array_item_index;
        }
    }
    return -1;
};

function array_find_index_v6($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) {
            return $array_item_index;
        }
    }
    return -1;
};

echo("\n\n// JavaScript-like Array.findIndex() in PHP Array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\nnumbers: " . pretty_array_of_primitives($numbers));

$my_lucky_number = 27;
echo("\nmy_lucky_number: $my_lucky_number");

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v1\"");

$my_lucky_number_index = array_find_index_v1(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v2\"");

$my_lucky_number_index = array_find_index_v2(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v3\"");

$my_lucky_number_index = array_find_index_v3(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v4\"");

$my_lucky_number_index = array_find_index_v4(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v5\"");

$my_lucky_number_index = array_find_index_v5(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v6\"");

$my_lucky_number_index = array_find_index_v6(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n\n// JavaScript-like Array.findIndex() in PHP Associative Array");

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
echo("\nproducts: " . json_encode($products, JSON_PRETTY_PRINT));

$product_to_buy = 'pasta';
echo("\nproduct I want: $product_to_buy");

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v1\"");

$product_to_buy_index = array_find_index_v1(fn($product) => @$product['code'] === $product_to_buy, $products);
echo("\nproduct I want is at index: $product_to_buy_index");
// product to buy is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v2\"");

$product_to_buy_index = array_find_index_v2(fn($product) => @$product['code'] === $product_to_buy, $products);
echo("\nproduct I want is at index: $product_to_buy_index");
// product to buy is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v3\"");

$product_to_buy_index = array_find_index_v3(fn($product) => @$product['code'] === $product_to_buy, $products);
echo("\nproduct I want is at index: $product_to_buy_index");
// product to buy is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v4\"");

$product_to_buy_index = array_find_index_v4(fn($product) => @$product['code'] === $product_to_buy, $products);
echo("\nproduct I want is at index: $product_to_buy_index");
// product to buy is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v5\"");

$product_to_buy_index = array_find_index_v5(fn($product) => @$product['code'] === $product_to_buy, $products);
echo("\nproduct I want is at index: $product_to_buy_index");
// product to buy is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v6\"");

$product_to_buy_index = array_find_index_v6(fn($product) => @$product['code'] === $product_to_buy, $products);
echo("\nproduct I want is at index: $product_to_buy_index");
// product to buy is at index: 0
