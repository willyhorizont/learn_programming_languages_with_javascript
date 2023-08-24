<?php

$array_map_v1 = function ($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array_item = $callback_function($array_item, $array_item_index, $an_array);
        array_push($new_array, $new_array_item);
    }
    return $new_array;
};

$array_map_v2 = function ($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array_item = $callback_function($array_item, $array_item_index, $an_array);
        $new_array = [...$new_array, $new_array_item];
    }
    return $new_array;
};

$array_map_v3 = function ($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        array_push($new_array, $callback_function($array_item, $array_item_index, $an_array));
    }
    return $new_array;
};

$array_map_v4 = function ($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array = [...$new_array, $callback_function($array_item, $array_item_index, $an_array)];
    }
    return $new_array;
};

echo("\n\n// JavaScript-like Array.map() in PHP Array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\nnumbers: " . str_replace(",", ", ", json_encode($numbers)));

echo("\n// using JavaScript-like Array.map() function \"array_map_v1\"");

$labeled_numbers = $array_map_v1(fn($number) => [$number => $number % 2 === 0 ? 'even' : 'odd'], $numbers);
echo("\nlabeled numbers: " . json_encode($labeled_numbers, JSON_PRETTY_PRINT));
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

echo("\n// using JavaScript-like Array.map() function \"array_map_v2\"");

$labeled_numbers = $array_map_v2(fn($number) => [$number => $number % 2 === 0 ? 'even' : 'odd'], $numbers);
echo("\nlabeled numbers: " . json_encode($labeled_numbers, JSON_PRETTY_PRINT));
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

echo("\n// using JavaScript-like Array.map() function \"array_map_v3\"");

$labeled_numbers = $array_map_v3(fn($number) => [$number => $number % 2 === 0 ? 'even' : 'odd'], $numbers);
echo("\nlabeled numbers: " . json_encode($labeled_numbers, JSON_PRETTY_PRINT));
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

echo("\n// using JavaScript-like Array.map() function \"array_map_v4\"");

$labeled_numbers = $array_map_v4(fn($number) => [$number => $number % 2 === 0 ? 'even' : 'odd'], $numbers);
echo("\nlabeled numbers: " . json_encode($labeled_numbers, JSON_PRETTY_PRINT));
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

echo("\n// using PHP Array.map() built-in function \"array_map\"");

$labeled_numbers = array_map(fn($number) => [$number => $number % 2 === 0 ? 'even' : 'odd'], $numbers);
echo("\nlabeled numbers: " . json_encode($labeled_numbers, JSON_PRETTY_PRINT));
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

echo("\n\n// JavaScript-like Array.map() in PHP Associative Array");

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

echo("\n// using JavaScript-like Array.map() function \"array_map_v1\"");

$labeled_products = $array_map_v1(fn($product) => [...$product, 'label' => $product['price'] > 100 ? 'expensive' : 'cheap'], $products);
echo("\nlabeled products: " . json_encode($labeled_products, JSON_PRETTY_PRINT));
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

echo("\n// using JavaScript-like Array.map() function \"array_map_v2\"");

$labeled_products = $array_map_v2(fn($product) => [...$product, 'label' => $product['price'] > 100 ? 'expensive' : 'cheap'], $products);
echo("\nlabeled products: " . json_encode($labeled_products, JSON_PRETTY_PRINT));
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

echo("\n// using JavaScript-like Array.map() function \"array_map_v3\"");

$labeled_products = $array_map_v3(fn($product) => [...$product, 'label' => $product['price'] > 100 ? 'expensive' : 'cheap'], $products);
echo("\nlabeled products: " . json_encode($labeled_products, JSON_PRETTY_PRINT));
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

echo("\n// using JavaScript-like Array.map() function \"array_map_v4\"");

$labeled_products = $array_map_v4(fn($product) => [...$product, 'label' => $product['price'] > 100 ? 'expensive' : 'cheap'], $products);
echo("\nlabeled products: " . json_encode($labeled_products, JSON_PRETTY_PRINT));
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

echo("\n// using PHP Array.map() built-in function \"array_map\"");

$labeled_products = array_map(fn($product) => [...$product, 'label' => $product['price'] > 100 ? 'expensive' : 'cheap'], $products);
echo("\nlabeled products: " . json_encode($labeled_products, JSON_PRETTY_PRINT));
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
