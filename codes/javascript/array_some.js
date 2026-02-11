import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.some() in JavaScript Array");

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

const isAnyNumberLessThan500 = numbers.some((anyNumber) => (anyNumber < 500));
console.log(`is any number < 500: ${isAnyNumberLessThan500}`);
// is any number < 500: true

const isAnyNumberMoreThan500 = numbers.some((anyNumber) => (anyNumber > 500));
console.log(`is any number > 500: ${isAnyNumberMoreThan500}`);
// is any number > 500: false

console.log("\n// Array.some() in JavaScript Array of Objects");

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

const isAnyProductPriceLessThan500 = products.some((anyProduct) => (anyProduct["price_in_USD"] < 8));
console.log(`is any product price_in_USD < 8: ${isAnyProductPriceLessThan500}`);
// is any product price_in_USD < 8: true

const isAnyProductPriceMoreThan500 = products.some((anyProduct) => (anyProduct["price_in_USD"] > 8));
console.log(`is any product price_in_USD > 8: ${isAnyProductPriceMoreThan500}`);
// is any product price_in_USD > 8: false
