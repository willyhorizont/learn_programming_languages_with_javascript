// Array

const fruits = ["apple", "mango", "orange"];
console.log(`fruits: ${JSON.stringify(fruits).split(',').join(', ')}`);

console.log("fruits, length:", fruits.length);
// fruits, length: 3

console.log("fruits, get mango:", fruits[1]);
// fruits, get mango: mango

console.log("fruits, first element:", fruits[0]);
// fruits, first element: apple

console.log("fruits, last element:", fruits[fruits.length - 1]);
// fruits, last element: orange

fruits.forEach((arrayItem, arrayItemIndex) => console.log(`fruits, foreach loop, index: ${arrayItemIndex}, value: ${arrayItem}`));
// fruits, foreach loop, index: 0, value: apple
// fruits, foreach loop, index: 1, value: mango
// fruits, foreach loop, index: 2, value: orange

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
console.log(`products: ${JSON.stringify(products, null, ' '.repeat(4))}`);

products.forEach((product, productIndex) => Object.entries(product).forEach(([objectKey, objectValue]) => console.log(`products, foreach loop, index: ${productIndex}, key: ${objectKey}, value: ${objectValue}`)));
// products, foreach loop, index: 0, key: id, value: P1
// products, foreach loop, index: 0, key: name, value: bubble gum
// products, foreach loop, index: 1, key: id, value: P2
// products, foreach loop, index: 1, key: name, value: potato chips
