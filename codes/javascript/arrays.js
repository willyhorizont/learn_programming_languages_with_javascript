import {
    jsonStringify,
} from "./utils.js";

console.log("// JavaScript Array");

const fruits = ["apple", "mango", "orange"];
console.log(`fruits: ${jsonStringify(fruits)}`);

console.log(`fruits, length: ${fruits.length}`);
// fruits, length: 3

console.log(`fruits, get mango: ${jsonStringify(fruits[1])}`);
// fruits, get mango: "mango"

console.log(`fruits, get mango: ${jsonStringify(fruits.at(1))}`);
// fruits, get mango: "mango"

console.log(`fruits, first element: ${jsonStringify(fruits[0])}`);
// fruits, first element: "apple"

console.log(`fruits, first element: ${jsonStringify(fruits.at(0))}`);
// fruits, first element: "apple"

console.log(`fruits, last element: ${jsonStringify(fruits[fruits.length - 1])}`);
// fruits, last element: "orange"

console.log(`fruits, last element: ${jsonStringify(fruits.at(fruits.length - 1))}`);
// fruits, last element: "orange"

// iterate over and print each item and index
for (let arrayItemIndex = 0; (arrayItemIndex < fruits.length); arrayItemIndex += 1) {
    const arrayItem = fruits[arrayItemIndex];
    console.log(`fruits, index: ${arrayItemIndex}, item: ${jsonStringify(arrayItem)}, for loop`);
}
// fruits, index: 0, item: "apple", for loop
// fruits, index: 1, item: "mango", for loop
// fruits, index: 2, item: "orange", for loop

// iterate over and print each item and index
fruits.forEach((arrayItem, arrayItemIndex) => {
    console.log(`fruits, index: ${arrayItemIndex}, item: ${jsonStringify(arrayItem)}, for each loop`);
});
// fruits, index: 0, item: "apple", for each loop
// fruits, index: 1, item: "mango", for each loop
// fruits, index: 2, item: "orange", for each loop

fruits.push("banana");
console.log(`add item to end, fruits: ${jsonStringify(fruits)}`);
