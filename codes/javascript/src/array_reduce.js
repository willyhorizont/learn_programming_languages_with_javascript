const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Array.reduce() in JavaScript Array");

const numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
console.log(`numbers: ${jsonStringify(numbers)}`);

const numbersTotal = numbers.reduce((currentResult, currentNumber) => (currentResult + currentNumber), 0);
console.log(`total number: ${numbersTotal}`);
// total number: 41.2

console.log("\n// Array.reduce() in JavaScript Array of Objects");

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

const productsGrouped = products.reduce((currentResult, currentProduct) => ((currentProduct.price > 100) ? { ...currentResult, expensive: [...currentResult.expensive, currentProduct] } : { ...currentResult, cheap: [...currentResult.cheap, currentProduct] }), { expensive: [], cheap: [] });
console.log(`grouped products: ${jsonStringify(productsGrouped, { pretty: true })}`);
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }
