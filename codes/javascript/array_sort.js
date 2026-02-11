import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.sort() in JavaScript Array");

{
    const months = ["Mar", "Jan", "Feb", "Dec"];
    console.log(`months:
${jsonStringify(months)}`);
    // months:
    // ["Mar", "Jan", "Feb", "Dec"]

    console.log(`sort month ascending:
${jsonStringify(months.sort((a, b) => (a - b)))}`);
    // sort month ascending:
    // ["Mar", "Jan", "Feb", "Dec"]

    console.log(`months:
${jsonStringify(months)}`);
    // months:
    // ["Mar", "Jan", "Feb", "Dec"]
}

{
    const months = ["Mar", "Jan", "Feb", "Dec"];
    console.log(`months:
${jsonStringify(months)}`);
    // months:
    // ["Mar", "Jan", "Feb", "Dec"]

    console.log(`sort month descending:
${jsonStringify(months.sort((a, b) => (b - a)))}`);
    // sort month descending:
    // ["Mar", "Jan", "Feb", "Dec"]

    console.log(`months:
${jsonStringify(months)}`);
    // months:
    // ["Mar", "Jan", "Feb", "Dec"]
}

{
    const numbers = [1, 30, 4, 21, 100];
    console.log(`numbers:
${jsonStringify(numbers)}`);
    // numbers:
    // [1, 30, 4, 21, 100]

    console.log(`sort numbers ascending:
${jsonStringify(numbers.sort((a, b) => (a - b)))}`);
    // sort numbers ascending:
    // [1, 4, 21, 30, 100]

    console.log(`numbers:
${jsonStringify(numbers)}`);
    // numbers:
    // [1, 4, 21, 30, 100]
}

{
    const numbers = [1, 30, 4, 21, 100];
    console.log(`numbers:
${jsonStringify(numbers)}`);
    // numbers:
    // [1, 30, 4, 21, 100]

    console.log(`sort numbers descending:
${jsonStringify(numbers.sort((a, b) => (b - a)))}`);
    // sort numbers descending:
    // [100, 30, 21, 4, 1]

    console.log(`numbers:
${jsonStringify(numbers)}`);
    // numbers:
    // [100, 30, 21, 4, 1]
}

{
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

    console.log(`sort products by created_at ascending: ${jsonStringify(products.sort(({ created_at: a }, { created_at: b}) => (new Date(a) - new Date(b))), { pretty: true })}`);

    console.log(`sort products by created_at descending: ${jsonStringify(products.sort(({ created_at: a }, { created_at: b}) => (new Date(b) - new Date(a))), { pretty: true })}`);
}
