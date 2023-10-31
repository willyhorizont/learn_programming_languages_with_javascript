console.log('\n// Array.findIndex() in JavaScript Array');

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(',').join(', ')}`);

const myLuckyNumber = 27;
console.log(`my lucky number: ${myLuckyNumber}`);

const myLuckyNumberIndex = numbers.findIndex((number) => number === myLuckyNumber);
console.log(`my lucky number is at index: ${myLuckyNumberIndex}`);
// my lucky number is at index: 2

console.log('\n// Array.findIndex() in JavaScript Array of Objects');

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

const productToBuy = 'pasta';
console.log(`product to buy: ${productToBuy}`);

const productToBuyIndex = products.findIndex((product) => product.code === productToBuy);
console.log(`product to buy is at index: ${productToBuyIndex}`);
// product to buy is at index: 0
