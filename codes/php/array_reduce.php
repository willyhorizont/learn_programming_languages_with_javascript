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

function array_reduce_v2($callback_function, $an_array, $initial_value) {
    // JavaScript-like Array.reduce() function
    $result = $initial_value;
    foreach ($an_array as $array_item_index => $array_item) {
        $result = $callback_function($result, $array_item, $array_item_index, $an_array);
    }
    return $result;
};

echo("\n\n// JavaScript-like Array.reduce() in PHP Array");

$numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
echo("\nnumbers: " . pretty_array_of_primitives($numbers));

echo("\n// using JavaScript-like Array.reduce() function \"array_reduce\"");

$numbers_total = array_reduce_v2(fn($current_result, $current_number) => $current_result + $current_number, $numbers, 0);
echo("\ntotal number: $numbers_total");
// total number: 41.2

echo("\n// using PHP Array.reduce() built-in function \"array_reduce\"");

$numbers_total = array_reduce($numbers,  fn($current_result, $current_number) => $current_result + $current_number, 0);
echo("\ntotal number: $numbers_total");
// total number: 41.2

echo("\n\n// JavaScript-like Array.reduce() in PHP Array of Associative-Arrays");

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

echo("\n// using JavaScript-like Array.reduce() function \"array_reduce\"");

$products_grouped = array_reduce_v2(fn($current_result, $current_product) => (($current_product['price'] > 100) ? [...$current_result, 'expensive' => [...$current_result['expensive'], $current_product]] : [...$current_result, 'cheap' => [...$current_result['cheap'], $current_product]]), $products, ['expensive' => [], 'cheap' => []]);
echo("\ngrouped products: " . json_encode($products_grouped, JSON_PRETTY_PRINT));
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }

echo("\n// using PHP Array.reduce() built-in function \"array_reduce\"");

$products_grouped = array_reduce($products,  fn($current_result, $current_product) => (($current_product['price'] > 100) ? [...$current_result, 'expensive' => [...$current_result['expensive'], $current_product]] : [...$current_result, 'cheap' => [...$current_result['cheap'], $current_product]]), ['expensive' => [], 'cheap' => []]);
echo("\ngrouped products: " . json_encode($products_grouped, JSON_PRETTY_PRINT));
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }
