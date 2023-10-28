console.log('\n// Array.filter() in JavaScript Array');

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(',').join(', ')}`);

const evenNumbersOnly = numbers.filter((number) => number % 2 === 0);
console.log(`even numbers only: ${JSON.stringify(evenNumbersOnly).split(',').join(', ')}`);
// even numbers only: [12, 34, 36, 4, 254]

const oddNumbersOnly = numbers.filter((number) => number % 2 !== 0);
console.log(`odd numbers only: ${JSON.stringify(oddNumbersOnly).split(',').join(', ')}`);
// odd numbers only: [27, 23, 65, 93, 87]

console.log('\n// Array.filter() in JavaScript Array of Objects');

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

const productsWithPriceLessThanOrEqualTo100Only = products.filter((product) => product.price <= 100);
console.log(`products with price <= 100 only: ${JSON.stringify(productsWithPriceLessThanOrEqualTo100Only, null, ' '.repeat(4))}`);
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

const productsWithPriceMoreThanOrEqualTo100Only = products.filter((product) => product.price >= 100);
console.log(`products with price >= 100 only: ${JSON.stringify(productsWithPriceMoreThanOrEqualTo100Only, null, ' '.repeat(4))}`);
// products with price >= 100 only: [
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
