const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Array.find() in JavaScript Array");

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

const evenNumberFound = numbers.find((number) => ((number % 2) === 0));
console.log(`even number found: ${evenNumberFound}`);
// even number found: 12

const oddNumberFound = numbers.find((number) => ((number % 2) !== 0));
console.log(`odd number found: ${oddNumberFound}`);
// odd number found: 27

console.log("\n// Array.find() in JavaScript Array of Objects");

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
console.log(`products: ${jsonStringify(products, { pretty: true })}`);

const productToFind = "bubble_gum";
console.log(`product to find: "${productToFind}"`);

const productFound = products.find((product) => (product?.code === productToFind));
console.log(`product found: ${jsonStringify(productFound, { pretty: true })}`);
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }
