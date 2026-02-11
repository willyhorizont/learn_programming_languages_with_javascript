import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.entries() in JavaScript");

const fruits = ["apple", "banana", "cherry"];
console.log(`fruits: ${jsonStringify(fruits, { pretty: true })}`);

console.log(`fruits entries: ${jsonStringify(Object.fromEntries(fruits.entries()), { pretty: true })}`);
// fruits entries: {
//     "0": "apple",
//     "1": "banana",
//     "2": "cherry"
// }
