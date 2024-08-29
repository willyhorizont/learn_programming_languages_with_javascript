console.log("\n// Array.reduce() in JavaScript Array");

const numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3];
console.log(`numbers: ${JSON.stringify(numbers).split(",").join(", ")}`);

const numbersTotal = numbers.reduce((currentResult, currentNumber) => (currentResult + currentNumber), 0);
console.log("total number:", numbersTotal);
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
console.log(`products: ${JSON.stringify(products, null, " ".repeat(4))}`);

const productsGrouped = products.reduce((currentResult, currentProduct) => ((currentProduct.price > 100) ? { ...currentResult, expensive: [...currentResult.expensive, currentProduct] } : { ...currentResult, cheap: [...currentResult.cheap, currentProduct] }), { expensive: [], cheap: [] });
console.log("grouped products:", JSON.stringify(productsGrouped, null, " ".repeat(4)));
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
