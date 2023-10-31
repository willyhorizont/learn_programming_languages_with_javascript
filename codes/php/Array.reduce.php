<?php

function pretty_array_of_primitives($an_array_of_primitives) {
    return str_replace(",", ", ", json_encode($an_array_of_primitives));
};

function array_reduce_v1($callback_function, $an_array, $initial_value) {
    // JavaScript-like Array.reduce() function
    $result = null;
    foreach ($an_array as $array_item_index => $array_item) {
        $result = $result === null ? $initial_value : $result;
        if (gettype($initial_value) === "array" || gettype($initial_value) === "object") {
            $result = $result === null ? [] : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
        if (is_numeric($initial_value) === true) {
            $result = $result === null ? 0 : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
        if (gettype($initial_value) === "string") {
            $result = $result === null ? "" : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
        if (gettype($initial_value) === "boolean") {
            $result = $result === null ? false : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
        if ($initial_value === null || is_null($initial_value) || gettype($initial_value) === "NULL") {
            $result = $result === null ? null : $result;
            $result = $callback_function($result, $array_item, $array_item_index, $an_array);
            continue;
        }
    }
    return $result;
};

echo("\n\n// JavaScript-like Array.reduce() in PHP Array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\nnumbers: " . pretty_array_of_primitives($numbers));

echo("\n// using JavaScript-like Array.reduce() function \"array_reduce\"");

$numbers_total = array_reduce_v1(fn($current_result, $current_number) => $current_result + $current_number, $numbers, 0);
echo("\ntotal number: $numbers_total");
// total number: 635

echo("\n// using PHP Array.reduce() built-in function \"array_reduce\"");

$numbers_total = array_reduce($numbers,  fn($current_result, $current_number) => $current_result + $current_number, 0);
echo("\ntotal number: $numbers_total");
// total number: 635

echo("\n\n// JavaScript-like Array.reduce() in PHP Associative Array");

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

$products_grouped = array_reduce_v1(fn($current_result, $current_product) => $current_product['price'] > 100 ? [...$current_result, 'expensive' => [...$current_result['expensive'], $current_product]] : [...$current_result, 'cheap' => [...$current_result['cheap'], $current_product]], $products, ['expensive' => [], 'cheap' => []]);
echo("\ngrouped products:" . json_encode($products_grouped, JSON_PRETTY_PRINT));
// grouped products: {
//     "expensive": [
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
//             "code": "pasta",
//             "price": 30
//         },
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }

echo("\n// using PHP Array.reduce() built-in function \"array_reduce\"");

$products_grouped = array_reduce($products,  fn($current_result, $current_product) => $current_product['price'] > 100 ? [...$current_result, 'expensive' => [...$current_result['expensive'], $current_product]] : [...$current_result, 'cheap' => [...$current_result['cheap'], $current_product]], ['expensive' => [], 'cheap' => []]);
echo("\ngrouped products:" . json_encode($products_grouped, JSON_PRETTY_PRINT));
// grouped products: {
//     "expensive": [
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
//             "code": "pasta",
//             "price": 30
//         },
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }
