console.log('\n// Array.reduce() in JavaScript Array');

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(',').join(', ')}`);

const numbersTotal = numbers.reduce((currentResult, currentNumber) => currentResult + currentNumber, 0);
console.log('total number:', numbersTotal);
// total numbers: 635

console.log('\n// Array.reduce() in JavaScript Array of Objects');

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
console.log(`products: ${JSON.stringify(products, null, ' '.repeat(4))}`);

const productsGrouped = products.reduce((currentResult, currentProduct) => (currentProduct.price > 100 ? { ...currentResult, expensive: [...currentResult.expensive, currentProduct] } : { ...currentResult, cheap: [...currentResult.cheap, currentProduct] }), { expensive: [], cheap: [] });
console.log('grouped products:', JSON.stringify(productsGrouped, null, ' '.repeat(4)));
// grouped products: {
//     "expensive": [
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
//             "code": "pasta",
//             "price": 30
//         },
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }
