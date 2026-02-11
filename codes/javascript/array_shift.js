import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.shift() in JavaScript Array");

const emptyArray = [];
console.log(`emptyArray: ${jsonStringify(emptyArray)}`);
// emptyArray: []

console.log(`emptyArray.shift(): ${jsonStringify(emptyArray.shift())}`);
// emptyArray.shift(): undefined

console.log(`emptyArray: ${jsonStringify(emptyArray)}`);
// emptyArray: []

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);
// numbers: [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]

console.log(`numbers.shift(): ${jsonStringify(numbers.shift())}`);
// numbers.shift(): 12

console.log(`numbers: ${jsonStringify(numbers)}`);
// numbers: [34, 27, 23, 65, 93, 36, 87, 4, 254]

const fruits = ["Mango", "Melon", "Banana"];
console.log(`fruits: ${jsonStringify(fruits)}`);
// fruits: ["Mango", "Melon", "Banana"]

console.log(`fruits.shift(): ${jsonStringify(fruits.shift())}`);
// fruits.shift(): "Mango"

console.log(`fruits: ${jsonStringify(fruits)}`);
// fruits: ["Melon", "Banana"]
