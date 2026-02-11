import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.push() in JavaScript Array");

const fruits = ["Mango", "Melon", "Banana"];
console.log(`fruits: ${jsonStringify(fruits)}`);
// fruits: ["Mango", "Melon", "Banana"]

console.log(`fruits.push("Orange"): ${jsonStringify(fruits.push("Orange"))}`);
// fruits.push("Orange"): 4

console.log(`fruits: ${jsonStringify(fruits)}`);
// fruits: ["Mango", "Melon", "Banana", "Orange"]
