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

function array_map_v1($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array_item = $callback_function($array_item, $array_item_index, $an_array);
        $new_array[count($new_array)] = $new_array_item;
    }
    return $new_array;
};

function array_map_v2($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array_item = $callback_function($array_item, $array_item_index, $an_array);
        $new_array = [...$new_array, $new_array_item];
    }
    return $new_array;
};

function array_map_v3($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array[count($new_array)] = $callback_function($array_item, $array_item_index, $an_array);
    }
    return $new_array;
};

function array_map_v4($callback_function, $an_array) {
    // JavaScript-like Array.map() function
    $new_array = [];
    foreach ($an_array as $array_item_index => $array_item) {
        $new_array = [...$new_array, $callback_function($array_item, $array_item_index, $an_array)];
    }
    return $new_array;
};

echo("\n\n// JavaScript-like Array.map() in PHP array");

$numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
echo("\n" . "numbers: " . pretty_array_of_primitives($numbers));

echo("\n// using JavaScript-like Array.map() function \"array_map_v1\"");

$numbers_labeled = array_map_v1(fn($number) => [$number => ((($number % 2) === 0) ? 'even' : 'odd')], $numbers);
echo("\n" . "labeled numbers: " . json_encode($numbers_labeled, JSON_PRETTY_PRINT));
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

$numbers_labeled = array_map_v2(fn($number) => [$number => ((($number % 2) === 0) ? 'even' : 'odd')], $numbers);
echo("\n" . "labeled numbers: " . json_encode($numbers_labeled, JSON_PRETTY_PRINT));
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

$numbers_labeled = array_map_v3(fn($number) => [$number => ((($number % 2) === 0) ? 'even' : 'odd')], $numbers);
echo("\n" . "labeled numbers: " . json_encode($numbers_labeled, JSON_PRETTY_PRINT));
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

$numbers_labeled = array_map_v4(fn($number) => [$number => ((($number % 2) === 0) ? 'even' : 'odd')], $numbers);
echo("\n" . "labeled numbers: " . json_encode($numbers_labeled, JSON_PRETTY_PRINT));
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

$numbers_labeled = array_map(fn($number) => [$number => ((($number % 2) === 0) ? 'even' : 'odd')], $numbers);
echo("\n" . "labeled numbers: " . json_encode($numbers_labeled, JSON_PRETTY_PRINT));
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

echo("\n\n// JavaScript-like Array.map() in PHP array of associative-arrays");

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

echo("\n// using JavaScript-like Array.map() function \"array_map_v1\"");

$products_labeled = array_map_v1(fn($product) => [...$product, 'label' => (($product['price'] > 100) ? 'expensive' : 'cheap')], $products);
echo("\n" . "labeled products: " . json_encode($products_labeled, JSON_PRETTY_PRINT));
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

$products_labeled = array_map_v2(fn($product) => [...$product, 'label' => (($product['price'] > 100) ? 'expensive' : 'cheap')], $products);
echo("\n" . "labeled products: " . json_encode($products_labeled, JSON_PRETTY_PRINT));
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

$products_labeled = array_map_v3(fn($product) => [...$product, 'label' => (($product['price'] > 100) ? 'expensive' : 'cheap')], $products);
echo("\n" . "labeled products: " . json_encode($products_labeled, JSON_PRETTY_PRINT));
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

$products_labeled = array_map_v4(fn($product) => [...$product, 'label' => (($product['price'] > 100) ? 'expensive' : 'cheap')], $products);
echo("\n" . "labeled products: " . json_encode($products_labeled, JSON_PRETTY_PRINT));
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

$products_labeled = array_map(fn($product) => [...$product, 'label' => (($product['price'] > 100) ? 'expensive' : 'cheap')], $products);
echo("\n" . "labeled products: " . json_encode($products_labeled, JSON_PRETTY_PRINT));
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
