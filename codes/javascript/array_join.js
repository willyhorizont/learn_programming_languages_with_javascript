import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.join() in JavaScript Array");

const emptyArray = [];
console.log(`emptyArray: ${jsonStringify(emptyArray)}`);

console.log(`emptyArray.join(): ${jsonStringify(emptyArray.join())}`);
// emptyArray.join(): ""

console.log(`emptyArray.join(""): ${jsonStringify(emptyArray.join(""))}`);
// emptyArray.join(""): ""

console.log(`emptyArray.join(" "): ${jsonStringify(emptyArray.join(" "))}`);
// emptyArray.join(" "): ""

console.log(`emptyArray.join(", "): ${jsonStringify(emptyArray.join(", "))}`);
// emptyArray.join(", "): ""

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

console.log(`numbers.join(): ${jsonStringify(numbers.join())}`);
// numbers.join(): "12,34,27,23,65,93,36,87,4,254"

console.log(`numbers.join(""): ${jsonStringify(numbers.join(""))}`);
// numbers.join(""): "12342723659336874254"

console.log(`numbers.join(" "): ${jsonStringify(numbers.join(" "))}`);
// numbers.join(" "): "12 34 27 23 65 93 36 87 4 254"

console.log(`numbers.join(", "): ${jsonStringify(numbers.join(", "))}`);
// numbers.join(", "): "12, 34, 27, 23, 65, 93, 36, 87, 4, 254"

const fruits = ["Mango", "Melon", "Banana"];
console.log(`fruits: ${jsonStringify(fruits)}`);

console.log(`fruits.join(): ${jsonStringify(fruits.join())}`);
// fruits.join(): "Mango,Melon,Banana"

console.log(`fruits.join(""): ${jsonStringify(fruits.join(""))}`);
// fruits.join(""): "MangoMelonBanana"

console.log(`fruits.join(" "): ${jsonStringify(fruits.join(" "))}`);
// fruits.join(" "): "Mango Melon Banana"

console.log(`fruits.join(", "): ${jsonStringify(fruits.join(", "))}`);
// fruits.join(", "): "Mango, Melon, Banana"
