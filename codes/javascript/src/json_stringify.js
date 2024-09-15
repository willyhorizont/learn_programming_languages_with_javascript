console.log("// JSON.stringify() in JavaScript");

const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${JSON.stringify(numbers)?.split?.(",")?.join?.(", ")}`);
console.log(`numbers: ${jsonStringify(numbers)}`);

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
console.log(`products: ${jsonStringify(products, { pretty: true })}`);
