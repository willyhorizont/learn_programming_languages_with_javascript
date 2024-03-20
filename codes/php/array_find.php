<?php

// There's no JavaScript-like Array.find() in PHP.
// But, we can create our own function to mimic it in PHP.

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

echo("\n\n// JavaScript-like Array.find() in PHP array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\n" . "numbers: " . pretty_array_of_primitives($numbers));

echo("\n// using JavaScript-like Array.find() function \"array_find_v1\"");

$even_number_found = array_find_v1(fn($number) => (($number % 2) === 0), $numbers);
echo("\n" . "even number found: $even_number_found");
// even number found: 12

$odd_number_found = array_find_v1(fn($number) => (($number % 2) !== 0), $numbers);
echo("\n" . "odd number found: $odd_number_found");
// odd number found: 27

echo("\n// using JavaScript-like Array.find() function \"array_find_v2\"");

$even_number_found = array_find_v2(fn($number) => (($number % 2) === 0), $numbers);
echo("\n" . "even number found: $even_number_found");
// even number found: 12

$odd_number_found = array_find_v2(fn($number) => (($number % 2) !== 0), $numbers);
echo("\n" . "odd number found: $odd_number_found");
// odd number found: 27

echo("\n// using JavaScript-like Array.find() function \"array_find_v3\"");

$even_number_found = array_find_v3(fn($number) => (($number % 2) === 0), $numbers);
echo("\n" . "even number found: $even_number_found");
// even number found: 12

$odd_number_found = array_find_v3(fn($number) => (($number % 2) !== 0), $numbers);
echo("\n" . "odd number found: $odd_number_found");
// odd number found: 27

echo("\n// using JavaScript-like Array.find() function \"array_find_v4\"");

$even_number_found = array_find_v4(fn($number) => (($number % 2) === 0), $numbers);
echo("\n" . "even number found: $even_number_found");
// even number found: 12

$odd_number_found = array_find_v4(fn($number) => (($number % 2) !== 0), $numbers);
echo("\n" . "odd number found: $odd_number_found");
// odd number found: 27

echo("\n\n// JavaScript-like Array.find() in PHP array of associative-arrays");

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
echo("\n" . "products: " . json_encode($products, JSON_PRETTY_PRINT));

$product_to_find = "bubble_gum";
echo("\n" . "product to find: " . $product_to_find);

echo("\n// using JavaScript-like Array.find() function \"array_find_v1\"");

$product_found = array_find_v1(fn($product) => (@$product['code'] === $product_to_find), $products);
echo("\n" . "product found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("\n// using JavaScript-like Array.find() function \"array_find_v2\"");

$product_found = array_find_v2(fn($product) => (@$product['code'] === $product_to_find), $products);
echo("\n" . "product found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("\n// using JavaScript-like Array.find() function \"array_find_v3\"");

$product_found = array_find_v3(fn($product) => (@$product['code'] === $product_to_find), $products);
echo("\n" . "product found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }

echo("\n// using JavaScript-like Array.find() function \"array_find_v4\"");

$product_found = array_find_v4(fn($product) => (@$product['code'] === $product_to_find), $products);
echo("\n" . "product found: " . json_encode($product_found, JSON_PRETTY_PRINT));
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }
