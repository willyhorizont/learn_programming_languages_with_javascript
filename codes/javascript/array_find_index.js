import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.findIndex() in JavaScript Array");

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

const numberToFind = 27;
console.log(`number to find: ${numberToFind}`);

const numberFoundIndex = numbers.findIndex((anyNumber) => (anyNumber === numberToFind));
console.log(`number found index: ${numberFoundIndex}`);
// number found index: 2

console.log("\n// Array.findIndex() in JavaScript Array of Objects");

const products = [
    {"id": "p1", "title": "Coca-Cola", "price_in_USD": 1.49, "created_at": "2024-09-12T15:22:01.000Z"},
    {"id": "p2", "title": "Pepsi", "price_in_USD": 1.39, "created_at": "2023-12-30T08:14:55.000Z"},
    {"id": "p5", "title": "Nutella", "price_in_USD": 4.99, "created_at": "2025-01-21T11:40:18.000Z"},
    {"id": "p6", "title": "Listerine", "price_in_USD": 6.75, "created_at": "2024-06-05T17:09:43.000Z"},
    {"id": "p7", "title": "Colgate", "price_in_USD": 3.25, "created_at": "2023-11-02T03:56:29.000Z"},
    {"id": "p9", "title": "Oreo", "price_in_USD": 2.99, "created_at": "2024-02-18T21:36:12.000Z"},
    {"id": "p10", "title": "Nescafe", "price_in_USD": 7.49, "created_at": "2024-12-08T09:48:39.000Z"}
];
console.log(`products: ${jsonStringify(products, { pretty: true })}`);

const productToFind = "Coca-Cola";
console.log(`product to find: ${productToFind}`);

const productFoundIndex = products.findIndex((anyProduct) => (anyProduct["title"] === productToFind));
console.log(`product found index: ${productFoundIndex}`);
// product found index: 0
