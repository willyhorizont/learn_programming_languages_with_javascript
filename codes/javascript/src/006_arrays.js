const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// JavaScript Array");

const fruits = ["apple", "mango", "orange"];
console.log(`fruits: ${jsonStringify(fruits)}`);

console.log(`fruits, length: ${fruits.length}`);
// fruits, length: 3

console.log(`fruits, get mango: ${fruits[1]}`);
// fruits, get mango: mango

console.log(`fruits, get mango: ${fruits?.[1]}`);
// fruits, get mango: mango

console.log(`fruits, get mango: ${fruits.at(1)}`);
// fruits, get mango: mango

console.log(`fruits, get mango: ${fruits?.at?.(1)}`);
// fruits, get mango: mango

console.log(`fruits, first element: ${fruits[0]}`);
// fruits, first element: apple

console.log(`fruits, first element: ${fruits?.[0]}`);
// fruits, first element: apple

console.log(`fruits, first element: ${fruits.at(0)}`);
// fruits, first element: apple

console.log(`fruits, first element: ${fruits?.at?.(0)}`);
// fruits, first element: apple

console.log(`fruits, last element: ${fruits[fruits.length - 1]}`);
// fruits, last element: orange

console.log(`fruits, last element: ${fruits?.[fruits.length - 1]}`);
// fruits, last element: orange

console.log(`fruits, last element: ${fruits.at(fruits.length - 1)}`);
// fruits, last element: orange

console.log(`fruits, last element: ${fruits?.at?.(fruits.length - 1)}`);
// fruits, last element: orange

// iterate over and print each item and index
for (let arrayItemIndex = 0; (arrayItemIndex < fruits.length); arrayItemIndex += 1) {
    const arrayItem = fruits[arrayItemIndex];
    console.log(`fruits, for loop, index: ${arrayItemIndex}, item: ${arrayItem}`);
}
// fruits, for loop, index: 0, item: apple
// fruits, for loop, index: 1, item: mango
// fruits, for loop, index: 2, item: orange

// iterate over and print each item and index
fruits.forEach((arrayItem, arrayItemIndex) => console.log(`fruits, for each loop, index: ${arrayItemIndex}, item: ${arrayItem}`));
// fruits, for each loop, index: 0, item: apple
// fruits, for each loop, index: 1, item: mango
// fruits, for each loop, index: 2, item: orange

fruits.push("banana");
console.log(`fruits: ${jsonStringify(fruits)}`);
// fruits: ["apple", "mango", "orange", "banana"]
