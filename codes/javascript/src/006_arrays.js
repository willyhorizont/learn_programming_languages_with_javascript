// Array

const fruits = ["apple", "mango", "orange"];
console.log(`fruits: ${JSON.stringify(fruits).split(",").join(", ")}`);

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

fruits[0] = "banana";
console.log(`fruits: ${JSON.stringify(fruits).split(",").join(", ")}`);

// Array of Objects

const products = [
    {
        "id": "P1",
        "name": "bubble gum"
    },
    {
        "id": "P2",
        "name": "potato chips"
    }
];
console.log(`products: ${JSON.stringify(products, null, " ".repeat(4))}`);
