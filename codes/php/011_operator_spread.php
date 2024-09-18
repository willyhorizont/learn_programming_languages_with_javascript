<?php

function json_stringify($anything, $optional_argument = ["pretty" => false]) {
    return (((@$optional_argument["pretty"] ?? false) === true) ? (str_replace("/\n$/", "", json_encode($anything, JSON_PRETTY_PRINT))) : (str_replace("{", "{ ", str_replace("}", " }", str_replace(",", ", ", str_replace(":", ": ", json_encode($anything)))))));
};

function array_every($callback_function, $an_array) {
    // JavaScript-like Array.every() function array_every_v4
    foreach ($an_array as $array_item_index => $array_item) {
        if ($callback_function($array_item, $array_item_index, $an_array) === false) return false;
    }
    return true;
};

function is_like_js_null($anything) {
    return (((gettype($anything) === "null") || (gettype($anything) === "NULL")) && (is_null($anything) === true) && (isset($anything) === false));
};

function is_like_js_boolean($anything) {
    return (((gettype($anything) === "boolean") || (gettype($anything) === "bool")) && (is_bool($anything) === true) && (($anything === true) || ($anything === false)));
};

function is_like_js_string($anything) {
    return ((gettype($anything) === "string") && (is_string($anything) === true));
};

function is_like_js_numeric($anything) {
    return (((gettype($anything) === "integer") || (gettype($anything) === "int") || (gettype($anything) === "float") || (gettype($anything) === "double")) && ((is_int($anything) === true) || (is_integer($anything) === true) || (is_float($anything) === true) || (is_double($anything) === true)) && (is_numeric($anything) === true));
};

function is_like_js_array($anything) {
    return ((gettype($anything) === "array") && (is_array($anything) === true));
};

function is_like_js_object($anything) {
    if (is_like_js_array($anything) === false) return false;
    return array_every(fn($array_item) => (is_like_js_string($array_item) === true), array_keys($anything));
};

function get_type($anything) {
    if (is_like_js_null($anything) === true) return "Null";
    if (is_like_js_boolean($anything) === true) return "Boolean";
    if (is_like_js_string($anything) === true) return "String";
    if (is_like_js_numeric($anything) === true) return "Numeric";
    if (is_like_js_object($anything) === true) return "Object";
    if (is_like_js_array($anything) === true) return "Array";
    return ucwords(strtolower(gettype($anything)));
};

function string_interpolation(...$rest_arguments) {
    return array_reduce($rest_arguments,  (fn($current_result, $current_argument) => ($current_result . ((get_type($current_argument) === "String") ? ($current_argument) : (((get_type($current_argument) === "Array") && (count($current_argument) === 1)) ? (json_stringify(@$current_argument[0])) : (json_stringify($current_argument)))))), "");
};

function console_log(...$rest_arguments) {
    echo string_interpolation(...$rest_arguments) . "\n";
};

console_log("\n// JavaScript-like Spread Syntax (...) in PHP");

$fruits = ["Mango", "Melon", "Banana"];
console_log(string_interpolation("fruits: ", [$fruits]));

$vegetables = ["Carrot", "Tomato"];
console_log(string_interpolation("vegetables: ", [$vegetables]));

$country_capitals_in_asia = [
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
];
console_log(string_interpolation("country_capitals_in_asia: ", json_stringify($country_capitals_in_asia, ["pretty" => true])));

$country_capitals_in_europe = [
    "France" => "Paris",
    "England" => "London"
];
console_log(string_interpolation("country_capitals_in_asia: ", json_stringify($country_capitals_in_europe, ["pretty" => true])));

console_log("\n// [...array1, ...array2]:\n");

$combination1 = [...$fruits, ...$vegetables];
console_log(string_interpolation("combination1: ", json_stringify($combination1, ["pretty" => true])));
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

$combination2 = [...$fruits, ...["Cucumber", "Cabbage"]];
console_log(string_interpolation("combination2: ", json_stringify($combination2, ["pretty" => true])));
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

console_log("\n// { ...object1, ...object2 }:\n");

$combination3 = [...$country_capitals_in_asia, ...$country_capitals_in_europe];
console_log(string_interpolation("combination3: ", json_stringify($combination3, ["pretty" => true])));
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

$combination4 = [...$country_capitals_in_asia, ...["Germany" => "Berlin", "Italy" => "Rome"]];
console_log(string_interpolation("combination4: ", json_stringify($combination4, ["pretty" => true])));
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

console_log("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n");

$combination5 = [...$fruits, $vegetables];
console_log(string_interpolation("combination5: ", json_stringify($combination5, ["pretty" => true])));
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
console_log(string_interpolation("combination6: ", json_stringify($combination6, ["pretty" => true])));
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Cabbage"
//     ]
// ]

console_log("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n");

$combination7 = [...$fruits, $country_capitals_in_asia];
console_log(string_interpolation("combination7: ", json_stringify($combination7, ["pretty" => true])));
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
console_log(string_interpolation("combination8: ", json_stringify($combination8, ["pretty" => true])));
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

console_log("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n");

$combination9 = [...$country_capitals_in_asia, "country_capitals_in_europe" => $country_capitals_in_europe];
console_log(string_interpolation("combination9: ", json_stringify($combination9, ["pretty" => true])));
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
console_log(string_interpolation("combination10: ", json_stringify($combination10, ["pretty" => true])));
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "country_capitals_in_europe": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

console_log("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n");

$combination11 = [...$country_capitals_in_asia, "vegetables" => $vegetables];
console_log(string_interpolation("combination11: ", json_stringify($combination11, ["pretty" => true])));
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
console_log(string_interpolation("combination12: ", json_stringify($combination12, ["pretty" => true])));
// combination12: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Cucumber",
//         "Cabbage"
//     ]
// }

console_log("\n// { ...object1, ...array2 }:\n");

$combination13 = [...$country_capitals_in_asia, ...$vegetables];
console_log(string_interpolation("combination13: ", json_stringify($combination13, ["pretty" => true])));
// combination13: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Carrot",
//    "1" : "Tomato"
// }

$combination14 = [...$country_capitals_in_asia, ...["Cucumber", "Cabbage"]];
console_log(string_interpolation("combination14: ", json_stringify($combination14, ["pretty" => true])));
// combination14: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Cucumber",
//    "1" : "Cabbage"
// }

// console_log("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n");

// this combination throw an error in JavaScript
// $combinationErrorInJavaScript1 = [...$fruits, ...$country_capitals_in_asia];
// console_log(string_interpolation("combinationErrorInJavaScript1: ", json_stringify($combinationErrorInJavaScript1, ["pretty" => true])));

// this combination throw an error in JavaScript
// $combinationErrorInJavaScript2 = [...$fruits, ...["Germany" => "Berlin", "Italy" => "Rome"]];
// console_log(string_interpolation("combinationErrorInJavaScript2: ", json_stringify($combinationErrorInJavaScript2, ["pretty" => true])));
