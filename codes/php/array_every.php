<?php

// There's no JavaScript-like Array.every() in PHP.
// But, we can create our own function to mimic it in PHP.

function array_every_v1($callback_function, $an_array) {
    // JavaScript-like Array.every() function
    $is_condition_match = false;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === false) break;
    }
    return $is_condition_match;
};

function array_every_v2($callback_function, $an_array) {
    // JavaScript-like Array.every() function
    $is_condition_match = false;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === false) return $is_condition_match;
    }
    return $is_condition_match;
};

function array_every_v3($callback_function, $an_array) {
    // JavaScript-like Array.every() function
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === false) return false;
    }
    return true;
};

function array_every_v4($callback_function, $an_array) {
    // JavaScript-like Array.every() function
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === false) return false;
    }
    return true;
};

echo("\n// JavaScript-like Array.every() in PHP array" . "\n");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("numbers: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers))) . "\n");

echo("// using JavaScript-like Array.every() function \"array_every_v1\"" . "\n");

$is_all_number_less_than_500 = array_every_v1(fn($number) => ($number < 500), $numbers);
echo("is all number < 500: " . json_encode($is_all_number_less_than_500) . "\n");
// is all number < 500: true

$is_all_number_more_than_500 = array_every_v1(fn($number) => ($number > 500), $numbers);
echo("is all number > 500: " . json_encode($is_all_number_more_than_500) . "\n");
// is all number > 500: false

echo("// using JavaScript-like Array.every() function \"array_every_v2\"" . "\n");

$is_all_number_less_than_500 = array_every_v2(fn($number) => ($number < 500), $numbers);
echo("is all number < 500: " . json_encode($is_all_number_less_than_500) . "\n");
// is all number < 500: true

$is_all_number_more_than_500 = array_every_v2(fn($number) => ($number > 500), $numbers);
echo("is all number > 500: " . json_encode($is_all_number_more_than_500) . "\n");
// is all number > 500: false

echo("// using JavaScript-like Array.every() function \"array_every_v3\"" . "\n");

$is_all_number_less_than_500 = array_every_v3(fn($number) => ($number < 500), $numbers);
echo("is all number < 500: " . json_encode($is_all_number_less_than_500) . "\n");
// is all number < 500: true

$is_all_number_more_than_500 = array_every_v3(fn($number) => ($number > 500), $numbers);
echo("is all number > 500: " . json_encode($is_all_number_more_than_500) . "\n");
// is all number > 500: false

echo("// using JavaScript-like Array.every() function \"array_every_v4\"" . "\n");

$is_all_number_less_than_500 = array_every_v4(fn($number) => ($number < 500), $numbers);
echo("is all number < 500: " . json_encode($is_all_number_less_than_500) . "\n");
// is all number < 500: true

$is_all_number_more_than_500 = array_every_v4(fn($number) => ($number > 500), $numbers);
echo("is all number > 500: " . json_encode($is_all_number_more_than_500) . "\n");
// is all number > 500: false

echo("\n// JavaScript-like Array.every() in PHP array of associative-arrays" . "\n");

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

echo("// using JavaScript-like Array.every() function \"array_every_v1\"" . "\n");

$is_all_product_price_less_than_500 = array_every_v1(fn($product) => ($product['price'] < 500), $products);
echo("is all product price < 500: " . json_encode($is_all_product_price_less_than_500) . "\n");
// is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v1(fn($product) => ($product['price'] > 500), $products);
echo("is all product price > 500: " . json_encode($is_all_product_price_more_than_500) . "\n");
// is all product price > 500: false

echo("// using JavaScript-like Array.every() function \"array_every_v2\"" . "\n");

$is_all_product_price_less_than_500 = array_every_v2(fn($product) => ($product['price'] < 500), $products);
echo("is all product price < 500: " . json_encode($is_all_product_price_less_than_500) . "\n");
// is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v2(fn($product) => ($product['price'] > 500), $products);
echo("is all product price > 500: " . json_encode($is_all_product_price_more_than_500) . "\n");
// is all product price > 500: false

echo("// using JavaScript-like Array.every() function \"array_every_v3\"" . "\n");

$is_all_product_price_less_than_500 = array_every_v3(fn($product) => ($product['price'] < 500), $products);
echo("is all product price < 500: " . json_encode($is_all_product_price_less_than_500) . "\n");
// is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v3(fn($product) => ($product['price'] > 500), $products);
echo("is all product price > 500: " . json_encode($is_all_product_price_more_than_500) . "\n");
// is all product price > 500: false

echo("// using JavaScript-like Array.every() function \"array_every_v4\"" . "\n");

$is_all_product_price_less_than_500 = array_every_v4(fn($product) => ($product['price'] < 500), $products);
echo("is all product price < 500: " . json_encode($is_all_product_price_less_than_500) . "\n");
// is all product price < 500: true

$is_all_product_price_more_than_500 = array_every_v4(fn($product) => ($product['price'] > 500), $products);
echo("is all product price > 500: " . json_encode($is_all_product_price_more_than_500) . "\n");
// is all product price > 500: false