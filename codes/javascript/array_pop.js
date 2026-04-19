import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.pop() in JavaScript Array");

const emptyArray = [];
console.log(`emptyArray: ${jsonStringify(emptyArray)}`);
// emptyArray: []

console.log(`emptyArray.pop(): ${jsonStringify(emptyArray.pop())}`);
// emptyArray.pop(): undefined

console.log(`emptyArray: ${jsonStringify(emptyArray)}`);
// emptyArray: []

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);
// numbers: [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]

console.log(`numbers.pop(): ${jsonStringify(numbers.pop())}`);
// numbers.pop(): 254

console.log(`numbers: ${jsonStringify(numbers)}`);
// numbers: [12, 34, 27, 23, 65, 93, 36, 87, 4]

const fruits = ["Mango", "Melon", "Banana"];
console.log(`fruits: ${jsonStringify(fruits)}`);
// fruits: ["Mango", "Melon", "Banana"]

console.log(`fruits.pop(): ${jsonStringify(fruits.pop())}`);
// fruits.pop(): "Banana"

console.log(`fruits: ${jsonStringify(fruits)}`);
// fruits: ["Mango", "Melon"]
