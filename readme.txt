In this repository, I am attempting to learn every programming language that has behavior and capabilities similar to JavaScript, like:
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
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    ```javascript
    const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
    console.log(`myArray: ${myArray}`);
    ```
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
    }
    console.log(`myObject2["my_function"](7, 5): ${myObject2["my_function"](7, 5)}`);
    ```

HOW TO RUN THE CODES:

to run JavaScript code:
1. cd codes/javascript/src
2. node filename.js

to run Python code:
1. cd codes/python
2. python filename.py

to run PHP code:
1. cd codes/php
2. php ./filename.php

to run Go code:
1. cd codes/go/foldername
2. go run filename.go

to run Perl code:
1. cd codes/perl
2. perl filename.pl

to run Julia code:
1. cd codes/julia
2. julia filename.jl

to run Lua code:
1. cd codes/lua
2. lua filename.lua

to run Ruby code:
1. cd codes/ruby
2. ruby filename.rb

to run R code:
1. cd codes/r
2. Rscript filename.r

to compile and run Kotlin code:
1. cd codes/kotlin
2. kotlinc filename.kt -include-runtime -d filename.jar && kotlin filename.jar

to compile and run Swift code:
1. cd codes/swift
2. swiftc filename.swift && ./filename

to run Dart code:
1. cd codes/dart
2. dart run filename.dart

to compile and run Visual Basic (.NET) code:
1. cd codes/visual_basic_dotnet
2. vbc filename.vb && ./filename.exe

to compile and run C# code:
1. cd codes/c#
2. csc filename.cs && ./filename.exe

to run Matlab code:
1. cd codes/matlab
2. matlab -batch run('filename.m');

to run Octave code:
1. cd codes/gnu_octave
2. octave-cli filename.m

to run Wolfram code:
1. cd codes/wolfram
2. wolframscript -file filename.wls

to run Raku code:
1. cd codes/raku
2. raku filename.raku

to run Scala code:
1. cd codes/scala
2. scala filename.scala

https://github.com/willyhorizont
https://github.com/willyhorizont/learn_programming_languages_with_javascript
