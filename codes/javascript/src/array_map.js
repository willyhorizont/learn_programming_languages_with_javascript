const jsType = { "Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function" };

const isNull = (anything) => (((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null)) || ((Object.prototype.toString.call(anything) === "[object Undefined]") && (anything === undefined)));

const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));

const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");

const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));

const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");

const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));

const isFunction = (anything) => (Object.prototype.toString.call(anything) === "[object Function]");

const getType = (anything) => ((isNull(anything) === true) ? jsType.Null : ((isBoolean(anything) === true) ? jsType.Boolean : ((isString(anything) === true) ? jsType.String : ((isNumeric(anything) === true) ? jsType.Numeric : ((isObject(anything) === true) ? jsType.Object : ((isArray(anything) === true) ? jsType.Array : ((isFunction(anything) === true) ? jsType.Function : Object.prototype.toString.call(anything))))))));

const jsonStringify = (anything, { pretty = false } = {}) => {
    // custom JSON.stringify() function jsonStringifyV3
    const indent = " ".repeat(4);
    let indentLevel = 0;
    const jsonStringifyInner = (anythingInner) => {
        const anythingInnerType = getType(anythingInner);
        if (anythingInnerType === jsType.Null) return "null";
        if (anythingInnerType === jsType.String) return `"${anythingInner}"`;
        if ((anythingInnerType === jsType.Numeric) || (anythingInnerType === jsType.Boolean)) return `${anythingInner}`;
        if (anythingInnerType === jsType.Object) {
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
        if (anythingInnerType === jsType.Array) {
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
        if (anythingInnerType === jsType.Function) return "[object Function]";
        return anythingInnerType;
    };
    return jsonStringifyInner(anything);
};

console.log("\n// Array.map() in JavaScript Array");

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

const numbersLabeled = numbers.map((anyNumber) => ({ [anyNumber]: (((anyNumber % 2) === 0) ? "even" : "odd") }));
console.log(`labeled numbers: ${jsonStringify(numbersLabeled, { pretty: true })}`);
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

console.log("\n// Array.map() in JavaScript Array of Objects");

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

const productsLabeled = products.map((anyProduct) => ({ ...anyProduct, label: ((anyProduct?.price > 100) ? "expensive" : "cheap") }));
console.log(`labeled products: ${jsonStringify(productsLabeled, { pretty: true })}`);
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
