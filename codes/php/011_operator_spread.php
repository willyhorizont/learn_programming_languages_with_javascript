<?php

echo("\n// JavaScript-like Spread Syntax (...) in PHP" . "\n");

$fruits = ["Mango", "Melon", "Banana"];
echo("fruits: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($fruits))) . "\n");

$vegetables = ["Carrot", "Tomato"];
echo("vegetables: " . str_replace(",", ", ", str_replace(":", ": ", json_encode($vegetables))) . "\n");

$country_capitals_in_asia = [
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
];
echo("country_capitals_in_asia: " . str_replace("/\n$/", "", json_encode($country_capitals_in_asia, JSON_PRETTY_PRINT)) . "\n");

$country_capitals_in_europe = [
    "France" => "Paris",
    "England" => "London"
];
echo("country_capitals_in_asia: " . str_replace("/\n$/", "", json_encode($country_capitals_in_europe, JSON_PRETTY_PRINT)) . "\n");

echo("\n// [...array1, ...array2]:\n" . "\n");

$combination1 = [...$fruits, ...$vegetables];
echo("\$combination1: " . str_replace("/\n$/", "", json_encode($combination1, JSON_PRETTY_PRINT)) . "\n");
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

$combination2 = [...$fruits, ...["Cucumber", "Cabbage"]];
echo("\$combination2: " . str_replace("/\n$/", "", json_encode($combination2, JSON_PRETTY_PRINT)) . "\n");
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

echo("\n// { ...object1, ...object2 }:\n" . "\n");

$combination3 = [...$country_capitals_in_asia, ...$country_capitals_in_europe];
echo("\$combination3: " . str_replace("/\n$/", "", json_encode($combination3, JSON_PRETTY_PRINT)) . "\n");
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

$combination4 = [...$country_capitals_in_asia, ...["Germany" => "Berlin", "Italy" => "Rome"]];
echo("\$combination4: " . str_replace("/\n$/", "", json_encode($combination4, JSON_PRETTY_PRINT)) . "\n");
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

echo("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n" . "\n");

$combination5 = [...$fruits, $vegetables];
echo("\$combination5: " . str_replace("/\n$/", "", json_encode($combination5, JSON_PRETTY_PRINT)) . "\n");
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
echo("\$combination6: " . str_replace("/\n$/", "", json_encode($combination6, JSON_PRETTY_PRINT)) . "\n");
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Cabbage"
//     ]
// ]

echo("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n" . "\n");

$combination7 = [...$fruits, $country_capitals_in_asia];
echo("\$combination7: " . str_replace("/\n$/", "", json_encode($combination7, JSON_PRETTY_PRINT)) . "\n");
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
echo("\$combination8: " . str_replace("/\n$/", "", json_encode($combination8, JSON_PRETTY_PRINT)) . "\n");
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

echo("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n" . "\n");

$combination9 = [...$country_capitals_in_asia, "country_capitals_in_europe" => $country_capitals_in_europe];
echo("\$combination9: " . str_replace("/\n$/", "", json_encode($combination9, JSON_PRETTY_PRINT)) . "\n");
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
echo("\$combination10: " . str_replace("/\n$/", "", json_encode($combination10, JSON_PRETTY_PRINT)) . "\n");
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "country_capitals_in_europe": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

echo("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n" . "\n");

$combination11 = [...$country_capitals_in_asia, "vegetables" => $vegetables];
echo("\$combination11: " . str_replace("/\n$/", "", json_encode($combination11, JSON_PRETTY_PRINT)) . "\n");
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
echo("\$combination12: " . str_replace("/\n$/", "", json_encode($combination12, JSON_PRETTY_PRINT)) . "\n");
// combination12: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Cucumber",
//         "Cabbage"
//     ]
// }

echo("\n// { ...object1, ...array2 }:\n" . "\n");

$combination13 = [...$country_capitals_in_asia, ...$vegetables];
echo("\$combination13: " . str_replace("/\n$/", "", json_encode($combination13, JSON_PRETTY_PRINT)) . "\n");
// combination13: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Carrot",
//    "1" : "Tomato"
// }

$combination14 = [...$country_capitals_in_asia, ...["Cucumber", "Cabbage"]];
echo("\$combination14: " . str_replace("/\n$/", "", json_encode($combination14, JSON_PRETTY_PRINT)) . "\n");
// combination14: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Cucumber",
//    "1" : "Cabbage"
// }

// echo("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n" . "\n");

// this combination throw an error in JavaScript
// $combinationErrorInJavaScript1 = [...$fruits, ...$country_capitals_in_asia];
// echo("\$combinationErrorInJavaScript1: " . str_replace("/\n$/", "", json_encode($combinationErrorInJavaScript1, JSON_PRETTY_PRINT)) . "\n");

// this combination throw an error in JavaScript
// $combinationErrorInJavaScript2 = [...$fruits, ...["Germany" => "Berlin", "Italy" => "Rome"]];
// echo("\$combinationErrorInJavaScript2: " . str_replace("/\n$/", "", json_encode($combinationErrorInJavaScript2, JSON_PRETTY_PRINT)) . "\n");
