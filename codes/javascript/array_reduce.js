import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.reduce() in JavaScript Array");

const numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
console.log(`numbers: ${jsonStringify(numbers)}`);

const numbersTotal = numbers.reduce((currentResult, currentNumber) => (currentResult + currentNumber), 0);
console.log(`total number: ${numbersTotal}`);
// total number: 41.2

console.log("\n// Array.reduce() in JavaScript Array of Objects");

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

const productsGrouped = products.reduce((currentResult, currentProduct) => ((currentProduct["price_in_USD"] > 5) ? { ...currentResult, expensive: [...currentResult["expensive"], currentProduct] } : { ...currentResult, cheap: [...currentResult["cheap"], currentProduct] }), { expensive: [], cheap: [] });
console.log(`grouped products: ${jsonStringify(productsGrouped, { pretty: true })}`);
/*
grouped products: {
    "expensive": [
        {
            "id": "p6",
            "title": "Listerine",
            "price_in_USD": 6.75,
            "created_at": "2024-06-05T17:09:43.000Z"
        },
        {
            "id": "p10",
            "title": "Nescafe",
            "price_in_USD": 7.49,
            "created_at": "2024-12-08T09:48:39.000Z"
        }
    ],
    "cheap": [
        {
            "id": "p1",
            "title": "Coca-Cola",
            "price_in_USD": 1.49,
            "created_at": "2024-09-12T15:22:01.000Z"
        },
        {
            "id": "p2",
            "title": "Pepsi",
            "price_in_USD": 1.39,
            "created_at": "2023-12-30T08:14:55.000Z"
        },
        {
            "id": "p5",
            "title": "Nutella",
            "price_in_USD": 4.99,
            "created_at": "2025-01-21T11:40:18.000Z"
        },
        {
            "id": "p7",
            "title": "Colgate",
            "price_in_USD": 3.25,
            "created_at": "2023-11-02T03:56:29.000Z"
        },
        {
            "id": "p9",
            "title": "Oreo",
            "price_in_USD": 2.99,
            "created_at": "2024-02-18T21:36:12.000Z"
        }
    ]
}
*/
