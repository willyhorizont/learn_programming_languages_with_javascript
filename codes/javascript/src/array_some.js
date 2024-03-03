console.log('\n// Array.some() in JavaScript Array');

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(',').join(', ')}`);

const isAnyNumberLessThan500 = numbers.some((number) => (number < 500));
console.log('is any number < 500:', isAnyNumberLessThan500);
// is any number < 500: true

const isAnyNumberMoreThan500 = numbers.some((number) => (number > 500));
console.log('is any number > 500:', isAnyNumberMoreThan500);
// is any number > 500: false

console.log('\n// Array.some() in JavaScript Array of Objects');

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

const isAnyProductPriceLessThan500 = products.some((product) => (product?.price < 500));
console.log('is any product price < 500:', isAnyProductPriceLessThan500);
// is any product price < 500: true

const isAnyProductPriceMoreThan500 = products.some((product) => (product?.price > 500));
console.log('is any product price > 500:', isAnyProductPriceMoreThan500);
// is any product price > 500: false
