<?php

echo("\n\n// JavaScript-like Spread Syntax (...) in PHP");

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

$fruits = ["Mango", "Melon", "Banana"];
echo("\n" . "fruits: " . pretty_array_of_primitives($fruits));

$vegetables = ["Carrot", "Tomato"];
echo("\n" . "vegetables: " . pretty_array_of_primitives($vegetables));

$country_capitals_in_asia = [
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
];
echo("\n" . "country_capitals_in_asia: " . json_encode($country_capitals_in_asia, JSON_PRETTY_PRINT));

$country_capitals_in_europe = [
    "France" => "Paris",
    "England" => "London"
];
echo("\n" . "country_capitals_in_asia: " . json_encode($country_capitals_in_europe, JSON_PRETTY_PRINT));

echo("\n\n// [...array1, ...array2]:\n");

$combination1 = [...$fruits, ...$vegetables];
echo("\n" . "\$combination1: " . json_encode($combination1, JSON_PRETTY_PRINT));
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

$combination2 = [...$fruits, ...["Cucumber", "Cabbage"]];
echo("\n" . "\$combination2: " . json_encode($combination2, JSON_PRETTY_PRINT));
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

echo("\n\n// { ...object1, ...object2 }:\n");

$combination3 = [...$country_capitals_in_asia, ...$country_capitals_in_europe];
echo("\n" . "\$combination3: " . json_encode($combination3, JSON_PRETTY_PRINT));
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

$combination4 = [...$country_capitals_in_asia, ...["Germany" => "Berlin", "Italy" => "Rome"]];
echo("\n" . "\$combination4: " . json_encode($combination4, JSON_PRETTY_PRINT));
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

echo("\n\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n");

$combination5 = [...$fruits, $vegetables];
echo("\n" . "\$combination5: " . json_encode($combination5, JSON_PRETTY_PRINT));
// combination5: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Carrot",
//         "Tomato"
//     ]
// ]

$combination6 = [...$fruits, ["Cucumber", "Cabbage"]];
echo("\n" . "\$combination6: " . json_encode($combination6, JSON_PRETTY_PRINT));
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Cabbage"
//     ]
// ]

echo("\n\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n");

$combination7 = [...$fruits, $country_capitals_in_asia];
echo("\n" . "\$combination7: " . json_encode($combination7, JSON_PRETTY_PRINT));
// combination7: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Thailand": "Bangkok",
//         "China": "Beijing",
//         "Japan": "Tokyo"
//     }
// ]

$combination8 = [...$fruits, ["Germany" => "Berlin", "Italy" => "Rome"]];
echo("\n" . "\$combination8: " . json_encode($combination8, JSON_PRETTY_PRINT));
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

echo("\n\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n");

$combination9 = [...$country_capitals_in_asia, "country_capitals_in_europe" => $country_capitals_in_europe];
echo("\n" . "\$combination9: " . json_encode($combination9, JSON_PRETTY_PRINT));
// combination9: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "country_capitals_in_europe" : {
//       "France" : "Paris",
//       "England" : "London"
//    }
// }

$combination10 = [...$country_capitals_in_asia, "country_capitals_in_europe" => ["Germany" => "Berlin", "Italy" => "Rome"]];
echo("\n" . "\$combination10: " . json_encode($combination10, JSON_PRETTY_PRINT));
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "country_capitals_in_europe": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

echo("\n\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n");

$combination11 = [...$country_capitals_in_asia, "vegetables" => $vegetables];
echo("\n" . "\$combination11: " . json_encode($combination11, JSON_PRETTY_PRINT));
// combination11: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Carrot",
//         "Tomato"
//     ]
// }

$combination12 = [...$country_capitals_in_asia, "vegetables" => ["Cucumber", "Cabbage"]];
echo("\n" . "\$combination12: " . json_encode($combination12, JSON_PRETTY_PRINT));
// combination12: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Cucumber",
//         "Cabbage"
//     ]
// }

echo("\n\n// { ...object1, ...array2 }:\n");

$combination13 = [...$country_capitals_in_asia, ...$vegetables];
echo("\n" . "\$combination13: " . json_encode($combination13, JSON_PRETTY_PRINT));
// combination13: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Carrot",
//    "1" : "Tomato"
// }

$combination14 = [...$country_capitals_in_asia, ...["Cucumber", "Cabbage"]];
echo("\n" . "\$combination14: " . json_encode($combination14, JSON_PRETTY_PRINT));
// combination14: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Cucumber",
//    "1" : "Cabbage"
// }

// echo("\n\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n");

// this combination throw an error in JavaScript
// $combinationErrorInJavaScript1 = [...$fruits, ...$country_capitals_in_asia];
// echo("\n" . "\$combinationErrorInJavaScript1: " . json_encode($combinationErrorInJavaScript1, JSON_PRETTY_PRINT));

// this combination throw an error in JavaScript
// $combinationErrorInJavaScript2 = [...$fruits, ...["Germany" => "Berlin", "Italy" => "Rome"]];
// echo("\n" . "\$combinationErrorInJavaScript2: " . json_encode($combinationErrorInJavaScript2, JSON_PRETTY_PRINT));
