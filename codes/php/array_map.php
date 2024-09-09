<?php

function array_map_v1($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array_item = $callback_function($array_item, $array_item_index, $an_array);
        $new_array = [...$new_array, $new_array_item];
    }
    return $new_array;
};

function array_map_v2($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array = [...$new_array, $callback_function($array_item, $array_item_index, $an_array)];
    }
    return $new_array;
};

echo("\n// JavaScript-like Array.map() in PHP array" . "\n");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("numbers: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($numbers))) . "\n");

echo("// using JavaScript-like Array.map() function \"array_map_v1\"" . "\n");

$numbers_labeled = array_map_v1(fn($number) => [$number => ((($number % 2) === 0) ? 'even' : 'odd')], $numbers);
echo("labeled numbers: " . str_replace("/\n$/", "", json_encode($numbers_labeled, JSON_PRETTY_PRINT)) . "\n");
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

echo("// using JavaScript-like Array.map() function \"array_map_v2\"" . "\n");

$numbers_labeled = array_map_v2(fn($number) => [$number => ((($number % 2) === 0) ? 'even' : 'odd')], $numbers);
echo("labeled numbers: " . str_replace("/\n$/", "", json_encode($numbers_labeled, JSON_PRETTY_PRINT)) . "\n");
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

echo("// using PHP Array.map() built-in function \"array_map\"" . "\n");

$numbers_labeled = array_map(fn($number) => [$number => ((($number % 2) === 0) ? 'even' : 'odd')], $numbers);
echo("labeled numbers: " . str_replace("/\n$/", "", json_encode($numbers_labeled, JSON_PRETTY_PRINT)) . "\n");
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

echo("\n// JavaScript-like Array.map() in PHP array of associative-arrays" . "\n");

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

echo("// using JavaScript-like Array.map() function \"array_map_v1\"" . "\n");

$products_labeled = array_map_v1(fn($product) => [...$product, 'label' => (($product['price'] > 100) ? 'expensive' : 'cheap')], $products);
echo("labeled products: " . str_replace("/\n$/", "", json_encode($products_labeled, JSON_PRETTY_PRINT)) . "\n");
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]

echo("// using JavaScript-like Array.map() function \"array_map_v2\"" . "\n");

$products_labeled = array_map_v2(fn($product) => [...$product, 'label' => (($product['price'] > 100) ? 'expensive' : 'cheap')], $products);
echo("labeled products: " . str_replace("/\n$/", "", json_encode($products_labeled, JSON_PRETTY_PRINT)) . "\n");
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]

echo("// using PHP Array.map() built-in function \"array_map\"" . "\n");

$products_labeled = array_map(fn($product) => [...$product, 'label' => (($product['price'] > 100) ? 'expensive' : 'cheap')], $products);
echo("labeled products: " . str_replace("/\n$/", "", json_encode($products_labeled, JSON_PRETTY_PRINT)) . "\n");
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]
