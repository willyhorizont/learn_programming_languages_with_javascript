console.log("\n// Array.every() in JavaScript Array");

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers).split(",").join(", ")}`);

const isAllNumberLessThan500 = numbers.every((number) => (number < 500));
console.log(`is all number < 500: ${isAllNumberLessThan500}`);
// is all number < 500: true

const isAllNumberMoreThan500 = numbers.every((number) => (number > 500));
console.log(`is all number > 500: ${isAllNumberMoreThan500}`);
// is all number > 500: false

console.log("\n// Array.every() in JavaScript Array of Objects");

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

const isAllProductPriceLessThan500 = products.every((product) => (product?.price < 500));
console.log(`is all product price < 500: ${isAllProductPriceLessThan500}`);
// is all product price < 500: true

const isAllProductPriceMoreThan500 = products.every((product) => (product?.price > 500));
console.log(`is all product price > 500: ${isAllProductPriceMoreThan500}`);
// is all product price > 500: false
