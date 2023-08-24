<?php

$array_filter_v1 = function ($callback_function, $an_array) {
    // JavaScript-like Array.filter() function
    $filtered_data = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) array_push($filtered_data, $array_item);
    }
    return $filtered_data;
};

$array_filter_v2 = function ($callback_function, $an_array) {
    // JavaScript-like Array.filter() function
    $filtered_data = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) $filtered_data = [...$filtered_data, $array_item];
    }
    return $filtered_data;
};

$array_filter_v3 = function ($callback_function, $an_array) {
    // JavaScript-like Array.filter() function
    $filtered_data = [];
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array)) array_push($filtered_data, $array_item);
    }
    return $filtered_data;
};

$array_filter_v4 = function ($callback_function, $an_array) {
    // JavaScript-like Array.filter() function
    $filtered_data = [];
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array)) $filtered_data = [...$filtered_data, $array_item];
    }
    return $filtered_data;
};

echo("\n\n// JavaScript-like Array.filter() in PHP Array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\nnumbers: " . str_replace(",", ", ", json_encode($numbers)));

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v1\"");

$even_numbers_only = $array_filter_v1(fn($number) => $number % 2 === 0, $numbers);
echo("\neven numbers only: " . str_replace(",", ", ", json_encode($even_numbers_only)));
// even numbers only: [12,34,36,4,254]

$odd_numbers_only = $array_filter_v1(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd numbers only: " . str_replace(",", ", ", json_encode($odd_numbers_only)));
// odd numbers only: [27,23,65,93,87]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v2\"");

$even_numbers_only = $array_filter_v2(fn($number) => $number % 2 === 0, $numbers);
echo("\neven numbers only: " . str_replace(",", ", ", json_encode($even_numbers_only)));
// even numbers only: [12,34,36,4,254]

$odd_numbers_only = $array_filter_v2(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd numbers only: " . str_replace(",", ", ", json_encode($odd_numbers_only)));
// odd numbers only: [27,23,65,93,87]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v3\"");

$even_numbers_only = $array_filter_v3(fn($number) => $number % 2 === 0, $numbers);
echo("\neven numbers only: " . str_replace(",", ", ", json_encode($even_numbers_only)));
// even numbers only: [12,34,36,4,254]

$odd_numbers_only = $array_filter_v3(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd numbers only: " . str_replace(",", ", ", json_encode($odd_numbers_only)));
// odd numbers only: [27,23,65,93,87]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v4\"");

$even_numbers_only = $array_filter_v4(fn($number) => $number % 2 === 0, $numbers);
echo("\neven numbers only: " . str_replace(",", ", ", json_encode($even_numbers_only)));
// even numbers only: [12,34,36,4,254]

$odd_numbers_only = $array_filter_v4(fn($number) => $number % 2 !== 0, $numbers);
echo("\nodd numbers only: " . str_replace(",", ", ", json_encode($odd_numbers_only)));
// odd numbers only: [27,23,65,93,87]

echo("\n// using PHP Array.filter() built-in function \"array_filter\"");

$even_numbers_only = array_filter($numbers, fn($number) => $number % 2 === 0);
echo("\neven numbers only: " . str_replace(",", ", ", json_encode($even_numbers_only)));
// even numbers only: [12,34,36,4,254]

$odd_numbers_only = array_filter($numbers, fn($number) => $number % 2 !== 0);
echo("\nodd numbers only: " . str_replace(",", ", ", json_encode($odd_numbers_only)));
// odd numbers only: [27,23,65,93,87]

echo("\n\n// JavaScript-like Array.filter() in PHP Associative Array");

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

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v1\"");

$products_with_price_less_than_or_equal_to_100_only = $array_filter_v1(fn($product) => $product['price'] <= 100, $products);
echo("\nproducts with price <= 100 only: " . json_encode($products_with_price_less_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_with_price_more_than_or_equal_to_100_only = $array_filter_v1(fn($product) => $product['price'] >= 100, $products);
echo("\nproducts with price >= 100 only: " . json_encode($products_with_price_more_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price >= 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v2\"");

$products_with_price_less_than_or_equal_to_100_only = $array_filter_v2(fn($product) => $product['price'] <= 100, $products);
echo("\nproducts with price <= 100 only: " . json_encode($products_with_price_less_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_with_price_more_than_or_equal_to_100_only = $array_filter_v2(fn($product) => $product['price'] >= 100, $products);
echo("\nproducts with price >= 100 only: " . json_encode($products_with_price_more_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price >= 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v3\"");

$products_with_price_less_than_or_equal_to_100_only = $array_filter_v3(fn($product) => $product['price'] <= 100, $products);
echo("\nproducts with price <= 100 only: " . json_encode($products_with_price_less_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_with_price_more_than_or_equal_to_100_only = $array_filter_v3(fn($product) => $product['price'] >= 100, $products);
echo("\nproducts with price >= 100 only: " . json_encode($products_with_price_more_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price >= 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v4\"");

$products_with_price_less_than_or_equal_to_100_only = $array_filter_v4(fn($product) => $product['price'] <= 100, $products);
echo("\nproducts with price <= 100 only: " . json_encode($products_with_price_less_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_with_price_more_than_or_equal_to_100_only = $array_filter_v4(fn($product) => $product['price'] >= 100, $products);
echo("\nproducts with price >= 100 only: " . json_encode($products_with_price_more_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price >= 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

echo("\n// using PHP Array.filter() built-in function \"array_filter\"");

$products_with_price_less_than_or_equal_to_100_only = array_filter($products, fn($product) => $product['price'] <= 100);
echo("\nproducts with price <= 100 only: " . json_encode($products_with_price_less_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_with_price_more_than_or_equal_to_100_only = array_filter($products, fn($product) => $product['price'] >= 100);
echo("\nproducts with price >= 100 only: " . json_encode($products_with_price_more_than_or_equal_to_100_only, JSON_PRETTY_PRINT));
// products with price >= 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]
