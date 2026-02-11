import {
    jsonStringify,
} from "./utils.js";

/*
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
*/
let something;
something = "foo";
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = 123;
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = 123.789;
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = -123;
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = -123.789;
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = true;
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = false;
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = undefined;
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = null;
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = [1, 2, 3];
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = { "foo": "bar" };
console.log(`something: ${jsonStringify(something, { pretty: true })}`);
something = (a, b) => (a * b);
console.log(`something: ${jsonStringify(something, { pretty: true })}`);

/*
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
*/
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

/*
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
*/
const myObject = {
    "my_string": "foo",
    "my_number_1": 123,
    "my_number_2": 123.789,
    "my_number_3": -123,
    "my_number_4": -123.789,
    "my_boolean_1": true,
    "my_boolean_2": false,
    "my_undefined": undefined,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": { "foo": "bar" },
    "my_function": (a, b) => (a * b),
};
console.log(`myObject: ${jsonStringify(myObject, { pretty: true })}`);

/*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
*/
const myArray = [
    "foo",
    123,
    123.789,
    -123,
    -123.789,
    true,
    false,
    undefined,
    null,
    [1, 2, 3],
    { "foo": "bar" },
    (a, b) => (a * b),
];
console.log(`myArray: ${jsonStringify(myArray, { pretty: true })}`);

/*
x. support passing functions as arguments to other functions
*/
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

/*
x. support returning functions as values from other functions
*/
function multiply(a) {
    return function (b) {
        return (a * b);
    };
}
const multiplyBy2 = multiply(2);
const multiplyBy2Result = multiplyBy2(10);
console.log(`multiplyBy2(10): ${multiplyBy2Result}`);

/*
x. support assigning functions to variables
*/
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

/*
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
*/
const myObject2 = {
    "my_string": "foo",
    "my_number_1": 123,
    "my_number_2": 123.789,
    "my_number_3": -123,
    "my_number_4": -123.789,
    "my_boolean_1": true,
    "my_boolean_2": false,
    "my_undefined": undefined,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": { "foo": "bar" },
    "my_function": (a, b) => (a * b),
};
console.log(`myObject2["my_function"](7, 5): ${myObject2["my_function"](7, 5)}`);
const myArray2 = [
    "foo",
    123,
    123.789,
    -123,
    -123.789,
    true,
    false,
    undefined,
    null,
    [1, 2, 3],
    { "foo": "bar" },
    (a, b) => (a * b),
];
console.log(`myArray2[0](7, 5): ${myArray2.at(-1)(7, 5)}`);
