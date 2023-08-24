<?php

// There's no JavaScript-like Array.find() in PHP.
// But, we can create our own function to mimic it in PHP.

$array_find_v1 = function($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    $data_found = null;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) {
            $data_found = $array_item;
            break;
        }
    }
    return $data_found;
};

$array_find_v2 = function($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    $data_found = null;
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array)) {
            $data_found = $array_item;
            break;
        }
    }
    return $data_found;
};

$array_find_v3 = function($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    $data_found = null;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) {
            return $array_item;
        }
    }
    return $data_found;
};

$array_find_v4 = function($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    $data_found = null;
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array)) {
            return $array_item;
        }
    }
    return $data_found;
};

$array_find_v5 = function($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) {
            return $array_item;
        }
    }
    return null;
};

$array_find_v6 = function($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array)) {
            return $array_item;
        }
    }
    return null;
};

echo("\n\n// JavaScript-like Array.find() in PHP Array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\nnumbers: " . str_replace(",", ", ", json_encode($numbers)));

echo("\n// using JavaScript-like Array.find() function \"array_find_v1\"");

$even_number_found = $array_find_v1(fn($number) => $number % 2 === 0, $numbers);
echo("\neven number found: $even_number_found");
// even number found: 12

$odd_number_found = $array_find_v1(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd number found: $odd_number_found");
// odd number found: 27

echo("\n// using JavaScript-like Array.find() function \"array_find_v2\"");

$even_number_found = $array_find_v2(fn($number) => $number % 2 === 0, $numbers);
echo("\neven number found: $even_number_found");
// even number found: 12

$odd_number_found = $array_find_v2(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd number found: $odd_number_found");
// odd number found: 27

echo("\n// using JavaScript-like Array.find() function \"array_find_v3\"");

$even_number_found = $array_find_v3(fn($number) => $number % 2 === 0, $numbers);
echo("\neven number found: $even_number_found");
// even number found: 12

$odd_number_found = $array_find_v3(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd number found: $odd_number_found");
// odd number found: 27

echo("\n// using JavaScript-like Array.find() function \"array_find_v4\"");

$even_number_found = $array_find_v4(fn($number) => $number % 2 === 0, $numbers);
echo("\neven number found: $even_number_found");
// even number found: 12

$odd_number_found = $array_find_v4(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd number found: $odd_number_found");
// odd number found: 27

echo("\n// using JavaScript-like Array.find() function \"array_find_v5\"");

$even_number_found = $array_find_v5(fn($number) => $number % 2 === 0, $numbers);
echo("\neven number found: $even_number_found");
// even number found: 12

$odd_number_found = $array_find_v5(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd number found: $odd_number_found");
// odd number found: 27

echo("\n// using JavaScript-like Array.find() function \"array_find_v6\"");

$even_number_found = $array_find_v6(fn($number) => $number % 2 === 0, $numbers);
echo("\neven number found: $even_number_found");
// even number found: 12

$odd_number_found = $array_find_v6(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd number found: $odd_number_found");
// odd number found: 27

echo("\n\n// JavaScript-like Array.find() in PHP Associative Array");

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

echo("\n// using JavaScript-like Array.find() function \"array_find_v1\"");

$product_found = $array_find_v1(fn($product) => @$product['code'] === 'bubble_gum', $products);
echo("\nproduct found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("\n// using JavaScript-like Array.find() function \"array_find_v2\"");

$product_found = $array_find_v2(fn($product) => @$product['code'] === 'bubble_gum', $products);
echo("\nproduct found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("\n// using JavaScript-like Array.find() function \"array_find_v3\"");

$product_found = $array_find_v3(fn($product) => @$product['code'] === 'bubble_gum', $products);
echo("\nproduct found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("\n// using JavaScript-like Array.find() function \"array_find_v4\"");

$product_found = $array_find_v4(fn($product) => @$product['code'] === 'bubble_gum', $products);
echo("\nproduct found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("\n// using JavaScript-like Array.find() function \"array_find_v5\"");

$product_found = $array_find_v5(fn($product) => @$product['code'] === 'bubble_gum', $products);
echo("\nproduct found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("\n// using JavaScript-like Array.find() function \"array_find_v6\"");

$product_found = $array_find_v6(fn($product) => @$product['code'] === 'bubble_gum', $products);
echo("\nproduct found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }
