<?php

/*
    1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
    ```javascript
    let something = "foo";
    console.log("something:", something);
    something = 123;
    console.log("something:", something);
    something = true;
    console.log("something:", something);
    something = null;
    console.log("something:", something);
    something = [1, 2, 3];
    console.log("something:", something);
    something = { "foo": "bar" };
    console.log("something:", something);
    ```
    ```go
    type Any interface{}
    ```
*/
$something = "foo";
echo("something: " . str_replace("/\n$/", "", json_encode($something, JSON_PRETTY_PRINT)) . "\n");
$something = 123;
echo("something: " . str_replace("/\n$/", "", json_encode($something, JSON_PRETTY_PRINT)) . "\n");
$something = true;
echo("something: " . str_replace("/\n$/", "", json_encode($something, JSON_PRETTY_PRINT)) . "\n");
$something = null;
echo("something: " . str_replace("/\n$/", "", json_encode($something, JSON_PRETTY_PRINT)) . "\n");
$something = [1, 2, 3];
echo("something: " . str_replace("/\n$/", "", json_encode($something, JSON_PRETTY_PRINT)) . "\n");
$something = ["foo" => "bar"];
echo("something: " . str_replace("/\n$/", "", json_encode($something, JSON_PRETTY_PRINT)) . "\n");

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
    console.log("getModifiedIndentLevel():", getModifiedIndentLevel());
    function createNewGame(initialCredit) {
        let currentCredit = initialCredit;
        console.log("initial credit:", initialCredit);
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
}
echo("get_modified_indent_level(): " . get_modified_indent_level() . "\n");
function create_new_game($initial_credit) {
    $current_credit = $initial_credit;
    echo("initial credit: " . $initial_credit . "\n");
    return function () use (&$current_credit) {
        $current_credit -= 1;
        if ($current_credit === 0) {
            echo("not enough credits" . "\n");
            return;
        }
        echo("playing game, " . $current_credit . " credit(s) remaining" . "\n");
    };
}
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
    console.log("myObject:", myObject);
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
echo("my_object: " . str_replace("/\n$/", "", json_encode($my_object, JSON_PRETTY_PRINT)) . "\n");

/*
    4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    ```javascript
    const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
    console.log("myArray:", myArray);
    ```
*/
$my_array = ["foo", 123, true, null, [1, 2, 3], ["foo" => "bar"]];
echo("my_array: " . str_replace("/\n$/", "", json_encode($my_array, JSON_PRETTY_PRINT)) . "\n");

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
    echo("hello" . "\n");
    $callback_function();
}
function say_how_are_you() {
    echo("how are you?" . "\n");
}
say_hello("say_how_are_you");
say_hello(function() {
    echo("how are you?" . "\n");
});

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
    console.log("multiplyBy2Result:", multiplyBy2Result);
    ```
*/
function multiply($a) {
    return function ($b) use ($a) {
        return $a * $b;
    };
}
$multiply_by2 = multiply(2);
$multiply_by2_result = $multiply_by2(10);
echo("multiply_by2_result: " . $multiply_by2_result . "\n");

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
    return $rectangle_width * $rectangle_length;
};
echo("get_rectangle_area_v1(7, 5): " . $get_rectangle_area_v1(7, 5) . "\n");
$get_rectangle_area_v2 = fn($rectangle_width, $rectangle_length) => $rectangle_width * $rectangle_length;
echo("get_rectangle_area_v2(7, 5): " . $get_rectangle_area_v2(7, 5) . "\n");

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
    console.log("myArray2[0](7, 5):", myArray2[0](7, 5));

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
    console.log("myObject2["my_function"](7, 5):", myObject2["my_function"](7, 5));
    ```
*/
$my_array2 = [
    function ($a, $b) {
        return $a * $b;
    },
    "foo",
    123,
    true,
    null,
    [1, 2, 3],
    ["foo" => "bar"]
];
echo("myArray2[0](7, 5): " . $my_array2[0](7, 5) . "\n");

$my_object2 = [
    "my_function" => function ($a, $b) {
        return $a * $b;
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
echo("myObject2[\"my_function\"](7, 5): " . $my_object2["my_function"](7, 5) . "\n");
