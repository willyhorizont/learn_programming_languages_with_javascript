console.log('\n// Array.filter() in JavaScript Array');

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(',').join(', ')}`);

const numbersEven = numbers.filter((number) => ((number % 2) === 0));
console.log(`even numbers only: ${JSON.stringify(numbersEven).split(',').join(', ')}`);
// even numbers only: [12, 34, 36, 4, 254]

const numbersOdd = numbers.filter((number) => ((number % 2) !== 0));
console.log(`odd numbers only: ${JSON.stringify(numbersOdd).split(',').join(', ')}`);
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

const productsBelow100 = products.filter((product) => product.price <= 100);
console.log(`products with price <= 100 only: ${JSON.stringify(productsBelow100, null, ' '.repeat(4))}`);
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

const productsAbove100 = products.filter((product) => product.price >= 100);
console.log(`products with price >= 100 only: ${JSON.stringify(productsAbove100, null, ' '.repeat(4))}`);
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
