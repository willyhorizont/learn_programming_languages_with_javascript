<?php

// There's no JavaScript-like Array.find() in PHP.
// But, we can create our own function to mimic it in PHP.

function array_find_v1($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    $data_found = null;
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === true) {
            $data_found = $array_item;
            break;
        }
    }
    return $data_found;
};

function array_find_v2($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    $data_found = null;
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) {
            $data_found = $array_item;
            break;
        }
    }
    return $data_found;
};

function array_find_v3($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    foreach ($an_array as $array_item_index => $array_item) {
        $is_condition_match = $callback_function($array_item, $array_item_index, $an_array);
        if ($is_condition_match === true) {
            return $array_item;
        }
    }
    return null;
};

function array_find_v4($callback_function, $an_array) {
    // JavaScript-like Array.find() function
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === true) {
            return $array_item;
        }
    }
    return null;
};

echo("\n// JavaScript-like Array.find() in PHP array" . "\n");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("numbers: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers))) . "\n");

echo("// using JavaScript-like Array.find() function \"array_find_v1\"" . "\n");

$even_number_found = array_find_v1(fn($number) => (($number % 2) === 0), $numbers);
echo("even number found: $even_number_found" . "\n");
// even number found: 12

$odd_number_found = array_find_v1(fn($number) => (($number % 2) !== 0), $numbers);
echo("odd number found: $odd_number_found" . "\n");
// odd number found: 27

echo("// using JavaScript-like Array.find() function \"array_find_v2\"" . "\n");

$even_number_found = array_find_v2(fn($number) => (($number % 2) === 0), $numbers);
echo("even number found: $even_number_found" . "\n");
// even number found: 12

$odd_number_found = array_find_v2(fn($number) => (($number % 2) !== 0), $numbers);
echo("odd number found: $odd_number_found" . "\n");
// odd number found: 27

echo("// using JavaScript-like Array.find() function \"array_find_v3\"" . "\n");

$even_number_found = array_find_v3(fn($number) => (($number % 2) === 0), $numbers);
echo("even number found: $even_number_found" . "\n");
// even number found: 12

$odd_number_found = array_find_v3(fn($number) => (($number % 2) !== 0), $numbers);
echo("odd number found: $odd_number_found" . "\n");
// odd number found: 27

echo("// using JavaScript-like Array.find() function \"array_find_v4\"" . "\n");

$even_number_found = array_find_v4(fn($number) => (($number % 2) === 0), $numbers);
echo("even number found: $even_number_found" . "\n");
// even number found: 12

$odd_number_found = array_find_v4(fn($number) => (($number % 2) !== 0), $numbers);
echo("odd number found: $odd_number_found" . "\n");
// odd number found: 27

echo("\n// JavaScript-like Array.find() in PHP array of associative-arrays" . "\n");

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

$product_to_find = "bubble_gum";
echo("product to find: " . $product_to_find . "\n");

echo("// using JavaScript-like Array.find() function \"array_find_v1\"" . "\n");

$product_found = array_find_v1(fn($product) => ($product['code'] === $product_to_find), $products);
echo("product found: " . str_replace("/\n$/", "", json_encode($product_found, JSON_PRETTY_PRINT)) . "\n");
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("// using JavaScript-like Array.find() function \"array_find_v2\"" . "\n");

$product_found = array_find_v2(fn($product) => ($product['code'] === $product_to_find), $products);
echo("product found: " . str_replace("/\n$/", "", json_encode($product_found, JSON_PRETTY_PRINT)) . "\n");
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("// using JavaScript-like Array.find() function \"array_find_v3\"" . "\n");

$product_found = array_find_v3(fn($product) => ($product['code'] === $product_to_find), $products);
echo("product found: " . str_replace("/\n$/", "", json_encode($product_found, JSON_PRETTY_PRINT)) . "\n");
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("// using JavaScript-like Array.find() function \"array_find_v4\"" . "\n");

$product_found = array_find_v4(fn($product) => ($product['code'] === $product_to_find), $products);
echo("product found: " . str_replace("/\n$/", "", json_encode($product_found, JSON_PRETTY_PRINT)) . "\n");
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }
