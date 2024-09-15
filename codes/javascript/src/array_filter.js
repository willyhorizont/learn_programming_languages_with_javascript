const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Array.filter() in JavaScript Array");

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

const numbersEven = numbers.filter((number) => ((number % 2) === 0));
console.log(`even numbers only: ${jsonStringify(numbersEven)}`);
// even numbers only: [12, 34, 36, 4, 254]

const numbersOdd = numbers.filter((number) => ((number % 2) !== 0));
console.log(`odd numbers only: ${jsonStringify(numbersOdd)}`);
// odd numbers only: [27, 23, 65, 93, 87]

console.log("\n// Array.filter() in JavaScript Array of Objects");

const products = [
    {
        "code": "pasta",
        "price": 321
    },
    {
        "code": "bubble_gum",
        "price": 233
    },
    {
        "code": "potato_chips",
        "price": 5
    },
    {
        "code": "towel",
        "price": 499
    }
];
console.log(`products: ${jsonStringify(products, { pretty: true })}`);

const productsBelow100 = products.filter((product) => (product?.price <= 100));
console.log(`products with price <= 100 only: ${jsonStringify(productsBelow100, { pretty: true })}`);
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

const productsAbove100 = products.filter((product) => (product?.price > 100));
console.log(`products with price > 100 only: ${jsonStringify(productsAbove100, { pretty: true })}`);
// products with price > 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]
