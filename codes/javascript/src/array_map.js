console.log('\n// Array.map() in JavaScript Array');

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(',').join(', ')}`);

const numbersLabeled = numbers.map((number) => ({ [number]: (((number % 2) === 0) ? 'even' : 'odd') }));
console.log(`labeled numbers: ${JSON.stringify(numbersLabeled, null, ' '.repeat(4))}`);
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

console.log('\n// Array.map() in JavaScript Array of Objects');

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

const productsLabeled = products.map((product) => ({ ...product, label: ((product?.price > 100) ? 'expensive' : 'cheap') }));
console.log(`labeled products: ${JSON.stringify(productsLabeled, null, ' '.repeat(4))}`);
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]
