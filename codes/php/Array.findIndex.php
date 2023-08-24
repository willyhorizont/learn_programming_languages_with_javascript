<?php

// There's no JavaScript-like Array.findIndex() in PHP.
// But, we can create our own function to mimic it in PHP.

$array_find_index_v1 = function($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $item_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) {
            $item_index = $array_item_index;
            break;
        }
    }
    return $item_index;
};

$array_find_index_v2 = function($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $item_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array)) {
            $item_index = $array_item_index;
            break;
        }
    }
    return $item_index;
};

$array_find_index_v3 = function($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $item_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) {
            return $array_item_index;
        }
    }
    return $item_index;
};

$array_find_index_v4 = function($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    $item_index = -1;
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array)) {
            return $array_item_index;
        }
    }
    return $item_index;
};

$array_find_index_v5 = function($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) {
            return $array_item_index;
        }
    }
    return -1;
};

$array_find_index_v6 = function($callback_function, $an_array) {
    // JavaScript-like Array.findIndex() function
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array)) {
            return $array_item_index;
        }
    }
    return -1;
};

echo("\n\n// JavaScript-like Array.findIndex() in PHP Array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\nnumbers: " . str_replace(",", ", ", json_encode($numbers)));

$my_lucky_number = 27;
echo("\nmy_lucky_number: $my_lucky_number");

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v1\"");

$my_lucky_number_index = $array_find_index_v1(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v2\"");

$my_lucky_number_index = $array_find_index_v2(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v3\"");

$my_lucky_number_index = $array_find_index_v3(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v4\"");

$my_lucky_number_index = $array_find_index_v4(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v5\"");

$my_lucky_number_index = $array_find_index_v5(fn($number) => $number === $my_lucky_number, $numbers);
echo("\nmy lucky number is at index: $my_lucky_number_index");
// my lucky number is at index: 2

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v6\"");

$my_lucky_number_index = $array_find_index_v6(fn($number) => $number === $my_lucky_number, $numbers);
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

$product_i_want = 'pasta';
echo("\nproduct I want: $product_i_want");

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v1\"");

$product_i_want_index = $array_find_index_v1(fn($product) => @$product['code'] === $product_i_want, $products);
echo("\nproduct I want is at index: $product_i_want_index");
// product I want is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v2\"");

$product_i_want_index = $array_find_index_v2(fn($product) => @$product['code'] === $product_i_want, $products);
echo("\nproduct I want is at index: $product_i_want_index");
// product I want is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v3\"");

$product_i_want_index = $array_find_index_v3(fn($product) => @$product['code'] === $product_i_want, $products);
echo("\nproduct I want is at index: $product_i_want_index");
// product I want is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v4\"");

$product_i_want_index = $array_find_index_v4(fn($product) => @$product['code'] === $product_i_want, $products);
echo("\nproduct I want is at index: $product_i_want_index");
// product I want is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v5\"");

$product_i_want_index = $array_find_index_v5(fn($product) => @$product['code'] === $product_i_want, $products);
echo("\nproduct I want is at index: $product_i_want_index");
// product I want is at index: 0

echo("\n// using JavaScript-like Array.findIndex() function \"array_find_index_v6\"");

$product_i_want_index = $array_find_index_v6(fn($product) => @$product['code'] === $product_i_want, $products);
echo("\nproduct I want is at index: $product_i_want_index");
// product I want is at index: 0
