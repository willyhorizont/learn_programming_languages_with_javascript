<?php

function array_reduce_v2($callback_function, $an_array, $initial_value) {
    // JavaScript-like Array.reduce() function
    $result = $initial_value;
    foreach ($an_array as $array_item_index => $array_item) {
        $result = $callback_function($result, $array_item, $array_item_index, $an_array);
    }
    return $result;
};

echo("\n// JavaScript-like Array.reduce() in PHP array" . "\n");

$numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
echo("numbers: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers))) . "\n");

echo("// using JavaScript-like Array.reduce() function \"array_reduce\"" . "\n");

$numbers_total = array_reduce_v2(fn($current_result, $current_number) => ($current_result + $current_number), $numbers, 0);
echo("total number: $numbers_total" . "\n");
// total number: 41.2

echo("// using PHP Array.reduce() built-in function \"array_reduce\"" . "\n");

$numbers_total = array_reduce($numbers,  fn($current_result, $current_number) => ($current_result + $current_number), 0);
echo("total number: $numbers_total" . "\n");
// total number: 41.2

echo("\n// JavaScript-like Array.reduce() in PHP array of associative-arrays" . "\n");

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

echo("// using JavaScript-like Array.reduce() function \"array_reduce\"" . "\n");

$products_grouped = array_reduce_v2(fn($current_result, $current_product) => (($current_product['price'] > 100) ? [...$current_result, 'expensive' => [...$current_result['expensive'], $current_product]] : [...$current_result, 'cheap' => [...$current_result['cheap'], $current_product]]), $products, ['expensive' => [], 'cheap' => []]);
echo("grouped products: " . str_replace("/\n$/", "", json_encode($products_grouped, JSON_PRETTY_PRINT)) . "\n");
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

echo("// using PHP Array.reduce() built-in function \"array_reduce\"" . "\n");

$products_grouped = array_reduce($products,  fn($current_result, $current_product) => (($current_product['price'] > 100) ? [...$current_result, 'expensive' => [...$current_result['expensive'], $current_product]] : [...$current_result, 'cheap' => [...$current_result['cheap'], $current_product]]), ['expensive' => [], 'cheap' => []]);
echo("grouped products: " . str_replace("/\n$/", "", json_encode($products_grouped, JSON_PRETTY_PRINT)) . "\n");
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
