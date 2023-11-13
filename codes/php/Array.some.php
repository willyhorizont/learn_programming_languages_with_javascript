<?php

// There's no JavaScript-like Array.some() in PHP.
// But, we can create our own function to mimic it in PHP.

function pretty_array_of_primitives($an_array_of_primitives) {
    $result = "[";
    foreach ($an_array_of_primitives as $array_item_index => $array_item) {
        if (is_numeric($array_item) === false && (gettype($array_item) !== "string")) {
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

function array_some_v1($callback_function, $an_array) {
    // JavaScript-like Array.some() function
    $is_condition_match = false;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) break;
    }
    return $is_condition_match;
};

function array_some_v2($callback_function, $an_array) {
    // JavaScript-like Array.some() function
    $is_condition_match = false;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) return $is_condition_match;
    }
    return $is_condition_match;
};

function array_some_v3($callback_function, $an_array) {
    // JavaScript-like Array.some() function
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match) return true;
    }
    return false;
};

function array_some_v4($callback_function, $an_array) {
    // JavaScript-like Array.some() function
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) return true;
    }
    return false;
};

echo("\n\n// JavaScript-like Array.some() in PHP Array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\nnumbers: " . pretty_array_of_primitives($numbers));

echo("\n// using JavaScript-like Array.some() function \"array_some_v1\"");

$is_any_number_less_than_500 = array_some_v1(fn($number) => $number < 500, $numbers) === false ? 'false' : 'true';
echo("\nis any number < 500: $is_any_number_less_than_500");
// is any number < 500: true

$is_any_number_more_than_500 = array_some_v1(fn($number) => $number > 500, $numbers) === false ? 'false' : 'true';
echo("\nis any number > 500: $is_any_number_more_than_500");
// is any number > 500: false

echo("\n// using JavaScript-like Array.some() function \"array_some_v2\"");

$is_any_number_less_than_500 = array_some_v2(fn($number) => $number < 500, $numbers) === false ? 'false' : 'true';
echo("\nis any number < 500: $is_any_number_less_than_500");
// is any number < 500: true

$is_any_number_more_than_500 = array_some_v2(fn($number) => $number > 500, $numbers) === false ? 'false' : 'true';
echo("\nis any number > 500: $is_any_number_more_than_500");
// is any number > 500: false

echo("\n// using JavaScript-like Array.some() function \"array_some_v3\"");

$is_any_number_less_than_500 = array_some_v3(fn($number) => $number < 500, $numbers) === false ? 'false' : 'true';
echo("\nis any number < 500: $is_any_number_less_than_500");
// is any number < 500: true

$is_any_number_more_than_500 = array_some_v3(fn($number) => $number > 500, $numbers) === false ? 'false' : 'true';
echo("\nis any number > 500: $is_any_number_more_than_500");
// is any number > 500: false

echo("\n// using JavaScript-like Array.some() function \"array_some_v4\"");

$is_any_number_less_than_500 = array_some_v4(fn($number) => $number < 500, $numbers) === false ? 'false' : 'true';
echo("\nis any number < 500: $is_any_number_less_than_500");
// is any number < 500: true

$is_any_number_more_than_500 = array_some_v4(fn($number) => $number > 500, $numbers) === false ? 'false' : 'true';
echo("\nis any number > 500: $is_any_number_more_than_500");
// is any number > 500: false

// ======================================================================================================================================================

echo("\n\n// JavaScript-like Array.some() in PHP Array of Associative-Arrays");

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

echo("\n// using JavaScript-like Array.some() function \"array_some_v1\"");

$is_any_product_price_less_than_500 = array_some_v1(fn($product) => @$product['price'] < 500, $products) === false ? 'false' : 'true';
echo("\nis any product price < 500: $is_any_product_price_less_than_500");
// is any product price < 500: true

$is_any_product_price_more_than_500 = array_some_v1(fn($product) => @$product['price'] > 500, $products) === false ? 'false' : 'true';
echo("\nis any product price > 500: $is_any_product_price_more_than_500");
// is any product price > 500: false

echo("\n// using JavaScript-like Array.some() function \"array_some_v2\"");

$is_any_product_price_less_than_500 = array_some_v2(fn($product) => @$product['price'] < 500, $products) === false ? 'false' : 'true';
echo("\nis any product price < 500: $is_any_product_price_less_than_500");
// is any product price < 500: true

$is_any_product_price_more_than_500 = array_some_v2(fn($product) => @$product['price'] > 500, $products) === false ? 'false' : 'true';
echo("\nis any product price > 500: $is_any_product_price_more_than_500");
// is any product price > 500: false

echo("\n// using JavaScript-like Array.some() function \"array_some_v3\"");

$is_any_product_price_less_than_500 = array_some_v3(fn($product) => @$product['price'] < 500, $products) === false ? 'false' : 'true';
echo("\nis any product price < 500: $is_any_product_price_less_than_500");
// is any product price < 500: true

$is_any_product_price_more_than_500 = array_some_v3(fn($product) => @$product['price'] > 500, $products) === false ? 'false' : 'true';
echo("\nis any product price > 500: $is_any_product_price_more_than_500");
// is any product price > 500: false

echo("\n// using JavaScript-like Array.some() function \"array_some_v4\"");

$is_any_product_price_less_than_500 = array_some_v4(fn($product) => @$product['price'] < 500, $products) === false ? 'false' : 'true';
echo("\nis any product price < 500: $is_any_product_price_less_than_500");
// is any product price < 500: true

$is_any_product_price_more_than_500 = array_some_v4(fn($product) => @$product['price'] > 500, $products) === false ? 'false' : 'true';
echo("\nis any product price > 500: $is_any_product_price_more_than_500");
// is any product price > 500: false
