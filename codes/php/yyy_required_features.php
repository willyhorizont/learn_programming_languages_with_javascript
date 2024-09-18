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

/*
1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
```javascript
let something = "foo";
console.log(`something: ${something}`);
something = 123;
console.log(`something: ${something}`);
something = true;
console.log(`something: ${something}`);
something = null;
console.log(`something: ${something}`);
something = [1, 2, 3];
console.log(`something: ${something}`);
something = { "foo": "bar" };
console.log(`something: ${something}`);
```
```go
type Any interface{}
```
*/
$something = "foo";
console_log(string_interpolation("something: ", json_stringify($something, ["pretty" => true])));
$something = 123;
console_log(string_interpolation("something: ", json_stringify($something, ["pretty" => true])));
$something = true;
console_log(string_interpolation("something: ", json_stringify($something, ["pretty" => true])));
$something = null;
console_log(string_interpolation("something: ", json_stringify($something, ["pretty" => true])));
$something = [1, 2, 3];
console_log(string_interpolation("something: ", json_stringify($something, ["pretty" => true])));
$something = ["foo" => "bar"];
console_log(string_interpolation("something: ", json_stringify($something, ["pretty" => true])));

/*
2. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
```javascript
function getModifiedIndentLevel() {
    let indentLevel = 0;
    function changeIndentLevel() {
        indentLevel += 1;
        if (indentLevel < 5) changeIndentLevel();
        return indentLevel;
    }
    return changeIndentLevel();
}
console.log(`getModifiedIndentLevel(): ${getModifiedIndentLevel()}`);
function createNewGame(initialCredit) {
    let currentCredit = initialCredit;
    console.log(`initial credit: ${initialCredit}`);
    return function () {
        currentCredit -= 1;
        if (currentCredit === 0) {
            console.log("not enough credits");
            return;
        }
        console.log(`playing game, ${currentCredit} credit(s) remaining`);
    };
}
const playGame = createNewGame(3);
playGame();
playGame();
playGame();
```
*/
function get_modified_indent_level() {
    $indent_level = 0;
    $change_indent_level = function() use (&$indent_level, &$change_indent_level) {
        $indent_level += 1;
        if ($indent_level < 5) $change_indent_level();
        return $indent_level;
    };
    return $change_indent_level();
};
console_log(string_interpolation("get_modified_indent_level(): ", [get_modified_indent_level()]));
function create_new_game($initial_credit) {
    $current_credit = $initial_credit;
    console_log(string_interpolation("initial_credit: ", [$initial_credit]));
    return function () use (&$current_credit) {
        $current_credit -= 1;
        if ($current_credit === 0) {
            console_log("not enough credits");
            return;
        }
        console_log(string_interpolation("playing game, ", [$current_credit], " credit(s) remaining"));
    };
};
$play_game = create_new_game(3);
$play_game();
$play_game();
$play_game();

/*
3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
```javascript
const myObject = {
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`myObject: ${myObject}`);
```
*/
$my_object = [
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => true,
    "my_null" => null,
    "my_array" => [1, 2, 3],
    "my_object" => [
        "foo" => "bar"
    ]
];
console_log(string_interpolation("my_object: ", json_stringify($my_object, ["pretty" => true])));

/*
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
*/
$my_array = ["foo", 123, true, null, [1, 2, 3], ["foo" => "bar"]];
console_log(string_interpolation("my_array: ", json_stringify($my_array, ["pretty" => true])));

/*
5. support passing functions as arguments to other functions
```javascript
function sayHello(callbackFunction) {
    console.log("hello");
    callbackFunction();
}
function sayHowAreYou() {
    console.log("how are you?");
}
sayHello(sayHowAreYou);
sayHello(function () {
    console.log("how are you?");
});
```
*/
function say_hello($callback_function) {
    console_log("hello");
    $callback_function();
};
function say_how_are_you() {
    console_log("how are you?");
};
say_hello("say_how_are_you"); // 🤮
say_hello(function() {
    console_log("how are you?");
});
say_hello(fn() => console_log("how are you?"));

/*
6. support returning functions as values from other functions
```javascript
function multiply(a) {
    return function (b) {
        return (a * b);
    };
}
const multiplyBy2 = multiply(2);
const multiplyBy2Result = multiplyBy2(10);
console.log(`multiplyBy2Result: ${multiplyBy2Result}`);
```
*/
function multiply($a) {
    return function ($b) use ($a) {
        return ($a * $b);
    };
};
$multiply_by2 = multiply(2);
$multiply_by2_result = $multiply_by2(10);
console_log(string_interpolation("multiply_by2_result: ", $multiply_by2_result));

/*
7. support assigning functions to variables
```javascript
const getRectangleAreaV1 = function (rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}`);
const getRectangleAreaV2 = (rectangleWidth, rectangleLength) => {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}`);
const getRectangleAreaV3 = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
console.log(`getRectangleAreaV3(7, 5): ${getRectangleAreaV3(7, 5)}`);
```
*/
$get_rectangle_area_v1 = function ($rectangle_width, $rectangle_length) {
    return ($rectangle_width * $rectangle_length);
};
console_log(string_interpolation("get_rectangle_area_v1(7, 5): ", $get_rectangle_area_v1(7, 5)));
$get_rectangle_area_v2 = fn($rectangle_width, $rectangle_length) => ($rectangle_width * $rectangle_length);
console_log(string_interpolation("get_rectangle_area_v2(7, 5): ", $get_rectangle_area_v2(7, 5)));

/*
8. support storing functions in data structures like array/list/slice/ordered-list-data-structure or object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure
```javascript
const myArray2 = [
    function (a, b) {
        return (a * b);
    },
    "foo",
    123,
    true,
    null,
    [1, 2, 3],
    { "foo": "bar" }
];
console.log(`myArray2[0](7, 5): ${myArray2[0](7, 5)}`);
const myObject2 = {
    "my_function": function (a, b) {
        return (a * b);
    },
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`myObject2["my_function"](7, 5): ${myObject2["my_function"](7, 5)}`);
```
*/
$my_array2 = [
    function ($a, $b) {
        return ($a * $b);
    },
    "foo",
    123,
    true,
    null,
    [1, 2, 3],
    ["foo" => "bar"]
];
console_log(string_interpolation("myArray2[0](7, 5): ", @$my_array2[0](7, 5)));
$my_object2 = [
    "my_function" => function ($a, $b) {
        return ($a * $b);
    },
    "my_string" => "foo",
    "my_number" => 123,
    "my_bool" => true,
    "my_null" => null,
    "my_array" => [1, 2, 3],
    "my_object" => [
        "foo" => "bar"
    ]
];
console_log(string_interpolation('myObject2["my_function"](7, 5): ', @$my_object2["my_function"](7, 5)));
