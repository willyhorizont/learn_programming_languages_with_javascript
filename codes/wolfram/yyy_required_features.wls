JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

(*
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
*)
Something = "foo";
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = 123;
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = True;
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = Null;
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = {1, 2, 3};
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];
Something = <|"foo" -> "bar"|>;
Print["Something: ", JsonStringify[Something, "Pretty" -> True]];

(*
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
*)
GetModifiedIndentLevel = (Module[{IndentLevel},
    IndentLevel = 0;
    ChangeIndentLevel = (Module[{},
        IndentLevel += 1;
        If[(IndentLevel < 5), ChangeIndentLevel[]];
        Return[IndentLevel, Module];
    ] &);
    Return[ChangeIndentLevel[], Module];
] &);
Print["GetModifiedIndentLevel(): ", GetModifiedIndentLevel[]];
CreateNewGame := (Module[{InitialCredit = #, CurrentCredit},
    CurrentCredit = InitialCredit;
    Print["initial credit: ", InitialCredit];
    Return[(Module[{},
        CurrentCredit -= 1;
        If[(CurrentCredit == 0),
            Print["not enough credits"];
            Return[Null, Module];
        ];
        Print["playing game, ", CurrentCredit, " credit(s) remaining"];
    ] &), Module];
] &);
PlayGame = CreateNewGame[3];
PlayGame[];
PlayGame[];
PlayGame[];

(*
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
*)
MyObject = <|
    "my_string" -> "foo",
    "my_number" -> 123,
    "my_bool" -> True,
    "my_null" -> Null,
    "my_array" -> {1, 2, 3},
    "my_object" -> <|
        "foo" -> "bar"
    |>
|>;
Print["MyObject: ", JsonStringify[MyObject, "Pretty" -> True]];

(*
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
*)
MyArray = {"foo", 123, True, Null, {1, 2, 3}, <|"foo" -> "bar"|>};
Print["MyArray: ", JsonStringify[MyArray, "Pretty" -> True]];

(*
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
*)
SayHello[CallbackFunction_] := Module[{},
    Print["hello"];
    CallbackFunction[];
];
SayHowAreYou[] := Module[{},
    Print["how are you?"];
];
SayHello[SayHowAreYou];
SayHello[(Module[{},
    Print["how are you?"];
] &)];
SayHello[(Module[{}, Print["how are you?"]] &)];

(*
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
*)
Multiply = (Module[{A = #},
    Return[(Module[{B = #},
        Return[(A * B), Module];
    ] &), Module];
] &);
MultiplyBy2 = Multiply[2];
MultiplyBy2Result = MultiplyBy2[10];
Print["MultiplyBy2Result: ", MultiplyBy2Result];

(*
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
*)
GetRectangleAreaV1 = (Module[{RectangleWidth = #1, RectangleLength = #2},
    Return[(RectangleWidth * RectangleLength), Module];
] &);
Print["GetRectangleAreaV1[7, 5]: ", GetRectangleAreaV1[7, 5]];
GetRectangleAreaV2 = (Module[{RectangleWidth = #1, RectangleLength = #2}, (RectangleWidth * RectangleLength)] &);
Print["GetRectangleAreaV2[7, 5]: ", GetRectangleAreaV2[7, 5]];

(*
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
*)
MyArray2 = {
    (Module[{A = #1, B = #2},
        Return[(A * B), Module];
    ] &),
    "foo",
    123,
    True,
    Null,
    {1, 2, 3},
    <|"foo" -> "bar"|>
};
Print["myArray2[0](7, 5): ", MyArray2[[1]][7, 5]];
MyObject = <|
    "my_function" -> (Module[{A = #1, B = #2},
        Return[(A * B), Module];
    ] &),
    "my_string" -> "foo",
    "my_number" -> 123,
    "my_bool" -> True,
    "my_null" -> Null,
    "my_array" -> {1, 2, 3},
    "my_object" -> <|
        "foo" -> "bar"
    |>
|>;
Print["myObject2[\"my_function\"](7, 5): ", MyObject[["my_function"]][7, 5]];
