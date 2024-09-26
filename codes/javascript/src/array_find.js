const jsType = {
    "Null": "Null",
    "Boolean": "Boolean",
    "String": "String",
    "Numeric": "Numeric",
    "Object": "Object",
    "Array": "Array",
    "Function": "Function"
};

const isNull = (anything) => (((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null)) || ((Object.prototype.toString.call(anything) === "[object Undefined]") && (anything === undefined)));

const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));

const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");

const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));

const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");

const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));

const isFunction = (anything) => (Object.prototype.toString.call(anything) === "[object Function]");

const getType = (anything) => {
    if (isNull(anything) === true) return jsType.Null;
    if (isBoolean(anything) === true) return jsType.Boolean;
    if (isString(anything) === true) return jsType.String;
    if (isNumeric(anything) === true) return jsType.Numeric;
    if (isObject(anything) === true) return jsType.Object;
    if (isArray(anything) === true) return jsType.Array;
    if (isFunction(anything) === true) return jsType.Function;
    return Object.prototype.toString.call(anything);
};

const jsonStringify = (anything, { pretty = false } = {}) => {
    // custom JSON.stringify() function jsonStringifyV3
    const indent = " ".repeat(4);
    let indentLevel = 0;
    const jsonStringifyInner = (anythingInner) => {
        if (getType(anythingInner) === jsType.Null) return "null";
        if (getType(anythingInner) === jsType.String) return `"${anythingInner}"`;
        if ((getType(anythingInner) === jsType.Numeric) || (getType(anythingInner) === jsType.Boolean)) return `${anythingInner}`;
        if (getType(anythingInner) === jsType.Object) {
            if (Object.keys(anythingInner).length === 0) return "{}";
            indentLevel += 1;
            let result = ((pretty === true) ? (`{\n${indent.repeat(indentLevel)}`) : "{ ");
            Object.entries(anythingInner).forEach(([objectKey, objectValue], objectEntryIndex) => {
                result = `${result}"${objectKey}": ${jsonStringifyInner(objectValue)}`;
                if ((objectEntryIndex + 1) !== Object.keys(anythingInner).length) {
                    result = `${result}${((pretty === true) ? (`,\n${indent.repeat(indentLevel)}`) : ", ")}`;
                }
            });
            indentLevel -= 1;
            result = `${result}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`;
            return result;
        }
        if (getType(anythingInner) === jsType.Array) {
            if (anythingInner.length === 0) return "[]";
            indentLevel += 1;
            let result = ((pretty === true) ? (`[\n${indent.repeat(indentLevel)}`) : "[");
            anythingInner.forEach((arrayItem, arrayItemIndex) => {
                result = `${result}${jsonStringifyInner(arrayItem)}`;
                if ((arrayItemIndex + 1) !== anythingInner.length) {
                    result = `${result}${((pretty === true) ? (`,\n${indent.repeat(indentLevel)}`) : ", ")}`;
                }
            });
            indentLevel -= 1;
            result = `${result}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}]`) : "]")}`;
            return result;
        }
        if (getType(anythingInner) === jsType.Function) return '"[object Function]"';
        return `"${getType(anything)}"`;
    };
    return jsonStringifyInner(anything);
};

console.log("\n// Array.find() in JavaScript Array");

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

const evenNumberFound = numbers.find((anyNumber) => ((anyNumber % 2) === 0));
console.log(`even number found: ${evenNumberFound}`);
// even number found: 12

const oddNumberFound = numbers.find((anyNumber) => ((anyNumber % 2) !== 0));
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

const productFound = products.find((anyProduct) => (anyProduct?.code === productToFind));
console.log(`product found: ${jsonStringify(productFound, { pretty: true })}`);
// product found: {
//     "code": "bubble_gum",
//     "price": 233
// }
