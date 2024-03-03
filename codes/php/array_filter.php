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

echo("\n\n// JavaScript-like Array.filter() in PHP Array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\nnumbers: " . pretty_array_of_primitives($numbers));

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v1\"");

$numbers_even = array_filter_v1(fn($number) => (($number % 2) === 0), $numbers);
echo("\neven numbers only: " . pretty_array_of_primitives($numbers_even));
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_filter_v1(fn($number) => (($number % 2) !== 0), $numbers);
echo("\nodd numbers only: " . pretty_array_of_primitives($numbers_odd));
// odd numbers only: [27,23,65,93,87]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v2\"");

$numbers_even = array_filter_v2(fn($number) => (($number % 2) === 0), $numbers);
echo("\neven numbers only: " . pretty_array_of_primitives($numbers_even));
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_filter_v2(fn($number) => (($number % 2) !== 0), $numbers);
echo("\nodd numbers only: " . pretty_array_of_primitives($numbers_odd));
// odd numbers only: [27,23,65,93,87]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v3\"");

$numbers_even = array_filter_v3(fn($number) => (($number % 2) === 0), $numbers);
echo("\neven numbers only: " . pretty_array_of_primitives($numbers_even));
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_filter_v3(fn($number) => (($number % 2) !== 0), $numbers);
echo("\nodd numbers only: " . pretty_array_of_primitives($numbers_odd));
// odd numbers only: [27,23,65,93,87]

echo("\n// using JavaScript-like Array.filter() function \"array_filter_v4\"");

$numbers_even = array_filter_v4(fn($number) => (($number % 2) === 0), $numbers);
echo("\neven numbers only: " . pretty_array_of_primitives($numbers_even));
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_filter_v4(fn($number) => (($number % 2) !== 0), $numbers);
echo("\nodd numbers only: " . pretty_array_of_primitives($numbers_odd));
// odd numbers only: [27,23,65,93,87]

echo("\n// using PHP Array.filter() built-in function \"array_values(array_filter)\"");

$numbers_even = array_values(array_filter($numbers, fn($number) => (($number % 2) === 0)));
echo("\neven numbers only: " . pretty_array_of_primitives($numbers_even));
// even numbers only: [12,34,36,4,254]

$numbers_odd = array_values(array_filter($numbers, fn($number) => (($number % 2) !== 0)));
echo("\nodd numbers only: " . pretty_array_of_primitives($numbers_odd));
// odd numbers only: [27,23,65,93,87]

echo("\n\n// JavaScript-like Array.filter() in PHP Array of Associative-Arrays");

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

$products_below_100 = array_filter_v1(fn($product) => $product['price'] <= 100, $products);
echo("\nproducts with price <= 100 only: " . json_encode($products_below_100, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v1(fn($product) => $product['price'] >= 100, $products);
echo("\nproducts with price >= 100 only: " . json_encode($products_above_100, JSON_PRETTY_PRINT));
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

$products_below_100 = array_filter_v2(fn($product) => $product['price'] <= 100, $products);
echo("\nproducts with price <= 100 only: " . json_encode($products_below_100, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v2(fn($product) => $product['price'] >= 100, $products);
echo("\nproducts with price >= 100 only: " . json_encode($products_above_100, JSON_PRETTY_PRINT));
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

$products_below_100 = array_filter_v3(fn($product) => $product['price'] <= 100, $products);
echo("\nproducts with price <= 100 only: " . json_encode($products_below_100, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v3(fn($product) => $product['price'] >= 100, $products);
echo("\nproducts with price >= 100 only: " . json_encode($products_above_100, JSON_PRETTY_PRINT));
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

$products_below_100 = array_filter_v4(fn($product) => $product['price'] <= 100, $products);
echo("\nproducts with price <= 100 only: " . json_encode($products_below_100, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_filter_v4(fn($product) => $product['price'] >= 100, $products);
echo("\nproducts with price >= 100 only: " . json_encode($products_above_100, JSON_PRETTY_PRINT));
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

echo("\n// using PHP Array.filter() built-in function \"array_values(array_filter)\"");

$products_below_100 = array_values(array_filter($products, fn($product) => $product['price'] <= 100));
echo("\nproducts with price <= 100 only: " . json_encode($products_below_100, JSON_PRETTY_PRINT));
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

$products_above_100 = array_values(array_filter($products, fn($product) => $product['price'] >= 100));
echo("\nproducts with price >= 100 only: " . json_encode($products_above_100, JSON_PRETTY_PRINT));
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
