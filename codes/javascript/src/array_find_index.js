console.log('\n// Array.findIndex() in JavaScript Array');

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(',').join(', ')}`);

const numberToFind = 27;
console.log(`number to find: ${numberToFind}`);

const numberFoundIndex = numbers.findIndex((number) => (number === numberToFind));
console.log(`number found index: ${numberFoundIndex}`);
// number found index: 2

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

const productToFind = 'pasta';
console.log(`product to find: ${productToFind}`);

const productFoundIndex = products.findIndex((product) => (product?.code === productToFind));
console.log(`product found index: ${productFoundIndex}`);
// product found index: 0
