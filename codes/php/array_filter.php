<?php

function array_filter_v1($callback_function, $an_array) {
    // JavaScript-like Array.filter() function
    $data_filtered = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) $data_filtered[count($data_filtered)] = $array_item;
    }
    return $data_filtered;
};

function array_filter_v2($callback_function, $an_array) {
    // JavaScript-like Array.filter() function
    $data_filtered = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) $data_filtered = [...$data_filtered, $array_item];
    }
    return $data_filtered;
};

function array_filter_v3($callback_function, $an_array) {
    // JavaScript-like Array.filter() function
    $data_filtered = [];
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) $data_filtered[count($data_filtered)] = $array_item;
    }
    return $data_filtered;
};

function array_filter_v4($callback_function, $an_array) {
    // JavaScript-like Array.filter() function
    $data_filtered = [];
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) $data_filtered = [...$data_filtered, $array_item];
    }
    return $data_filtered;
};

echo("\n// JavaScript-like Array.filter() in PHP array" . "\n");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("numbers: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers))) . "\n");

echo("// using JavaScript-like Array.filter() function \"array_filter_v1\"" . "\n");

$numbers_even = array_filter_v1(fn($number) => (($number % 2) === 0), $numbers);
echo("even numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_even))) . "\n");
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_filter_v1(fn($number) => (($number % 2) !== 0), $numbers);
echo("odd numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_odd))) . "\n");
// odd numbers only: [27,23,65,93,87]

echo("// using JavaScript-like Array.filter() function \"array_filter_v2\"" . "\n");

$numbers_even = array_filter_v2(fn($number) => (($number % 2) === 0), $numbers);
echo("even numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_even))) . "\n");
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_filter_v2(fn($number) => (($number % 2) !== 0), $numbers);
echo("odd numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_odd))) . "\n");
// odd numbers only: [27,23,65,93,87]

echo("// using JavaScript-like Array.filter() function \"array_filter_v3\"" . "\n");

$numbers_even = array_filter_v3(fn($number) => (($number % 2) === 0), $numbers);
echo("even numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_even))) . "\n");
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_filter_v3(fn($number) => (($number % 2) !== 0), $numbers);
echo("odd numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_odd))) . "\n");
// odd numbers only: [27,23,65,93,87]

echo("// using JavaScript-like Array.filter() function \"array_filter_v4\"" . "\n");

$numbers_even = array_filter_v4(fn($number) => (($number % 2) === 0), $numbers);
echo("even numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_even))) . "\n");
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_filter_v4(fn($number) => (($number % 2) !== 0), $numbers);
echo("odd numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_odd))) . "\n");
// odd numbers only: [27,23,65,93,87]

echo("// using PHP Array.filter() built-in function \"array_values(array_filter)\"" . "\n");

$numbers_even = array_values(array_filter($numbers, fn($number) => (($number % 2) === 0)));
echo("even numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_even))) . "\n");
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_values(array_filter($numbers, fn($number) => (($number % 2) !== 0)));
echo("odd numbers only: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers_odd))) . "\n");
// odd numbers only: [27,23,65,93,87]

echo("\n// JavaScript-like Array.filter() in PHP array of associative-arrays" . "\n");

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

echo("// using JavaScript-like Array.filter() function \"array_filter_v1\"" . "\n");

$products_below_100 = array_filter_v1(fn($product) => ($product['price'] <= 100), $products);
echo("products with price <= 100 only: " . str_replace("/\n$/", "", json_encode($products_below_100, JSON_PRETTY_PRINT)) . "\n");
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v1(fn($product) => ($product['price'] > 100), $products);
echo("products with price > 100 only: " . str_replace("/\n$/", "", json_encode($products_above_100, JSON_PRETTY_PRINT)) . "\n");
// products with price > 100 only: [
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

echo("// using JavaScript-like Array.filter() function \"array_filter_v2\"" . "\n");

$products_below_100 = array_filter_v2(fn($product) => ($product['price'] <= 100), $products);
echo("products with price <= 100 only: " . str_replace("/\n$/", "", json_encode($products_below_100, JSON_PRETTY_PRINT)) . "\n");
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v2(fn($product) => ($product['price'] > 100), $products);
echo("products with price > 100 only: " . str_replace("/\n$/", "", json_encode($products_above_100, JSON_PRETTY_PRINT)) . "\n");
// products with price > 100 only: [
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

echo("// using JavaScript-like Array.filter() function \"array_filter_v3\"" . "\n");

$products_below_100 = array_filter_v3(fn($product) => ($product['price'] <= 100), $products);
echo("products with price <= 100 only: " . str_replace("/\n$/", "", json_encode($products_below_100, JSON_PRETTY_PRINT)) . "\n");
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v3(fn($product) => ($product['price'] > 100), $products);
echo("products with price > 100 only: " . str_replace("/\n$/", "", json_encode($products_above_100, JSON_PRETTY_PRINT)) . "\n");
// products with price > 100 only: [
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

echo("// using JavaScript-like Array.filter() function \"array_filter_v4\"" . "\n");

$products_below_100 = array_filter_v4(fn($product) => ($product['price'] <= 100), $products);
echo("products with price <= 100 only: " . str_replace("/\n$/", "", json_encode($products_below_100, JSON_PRETTY_PRINT)) . "\n");
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v4(fn($product) => ($product['price'] > 100), $products);
echo("products with price > 100 only: " . str_replace("/\n$/", "", json_encode($products_above_100, JSON_PRETTY_PRINT)) . "\n");
// products with price > 100 only: [
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

echo("// using PHP Array.filter() built-in function \"array_values(array_filter)\"" . "\n");

$products_below_100 = array_values(array_filter($products, fn($product) => ($product['price'] <= 100)));
echo("products with price <= 100 only: " . str_replace("/\n$/", "", json_encode($products_below_100, JSON_PRETTY_PRINT)) . "\n");
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_values(array_filter($products, fn($product) => ($product['price'] > 100)));
echo("products with price > 100 only: " . str_replace("/\n$/", "", json_encode($products_above_100, JSON_PRETTY_PRINT)) . "\n");
// products with price > 100 only: [
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
