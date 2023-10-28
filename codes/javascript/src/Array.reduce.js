console.log('\n// Array.reduce() in JavaScript Array');

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(',').join(', ')}`);

const totalNumber = numbers.reduce((currentTotalNumber, currentNumber) => currentTotalNumber + currentNumber, 0);
console.log('total number:', totalNumber);
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

const groupedProducts = products.reduce((currentGroupedProducts, currentProduct) => (currentProduct.price > 100 ? { ...currentGroupedProducts, expensive: [...currentGroupedProducts.expensive, currentProduct] } : { ...currentGroupedProducts, cheap: [...currentGroupedProducts.cheap, currentProduct] }), { expensive: [], cheap: [] });
console.log('grouped products:', JSON.stringify(groupedProducts, null, ' '.repeat(4)));
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
