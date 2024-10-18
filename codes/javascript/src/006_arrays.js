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

console.log("// JavaScript Array");

const fruits = ["apple", "mango", "orange"];
console.log(`fruits: ${jsonStringify(fruits)}`);

console.log(`fruits, length: ${fruits.length}`);
// fruits, length: 3

console.log(`fruits, get mango: ${jsonStringify(fruits[1])}`);
// fruits, get mango: "mango"

console.log(`fruits, get mango: ${jsonStringify(fruits?.[1])}`);
// fruits, get mango: "mango"

console.log(`fruits, get mango: ${jsonStringify(fruits.at(1))}`);
// fruits, get mango: "mango"

console.log(`fruits, get mango: ${jsonStringify(fruits?.at?.(1))}`);
// fruits, get mango: "mango"

console.log(`fruits, first element: ${jsonStringify(fruits[0])}`);
// fruits, first element: "apple"

console.log(`fruits, first element: ${jsonStringify(fruits?.[0])}`);
// fruits, first element: "apple"

console.log(`fruits, first element: ${jsonStringify(fruits.at(0))}`);
// fruits, first element: "apple"

console.log(`fruits, first element: ${jsonStringify(fruits?.at?.(0))}`);
// fruits, first element: "apple"

console.log(`fruits, last element: ${jsonStringify(fruits[fruits.length - 1])}`);
// fruits, last element: "orange"

console.log(`fruits, last element: ${jsonStringify(fruits?.[fruits.length - 1])}`);
// fruits, last element: "orange"

console.log(`fruits, last element: ${jsonStringify(fruits.at(fruits.length - 1))}`);
// fruits, last element: "orange"

console.log(`fruits, last element: ${jsonStringify(fruits?.at?.(fruits.length - 1))}`);
// fruits, last element: "orange"

console.log(`fruits, last element: ${jsonStringify(fruits?.at?.(-1))}`);
// fruits, last element: "orange"

// iterate over and print each item and index
for (let arrayItemIndex = 0; (arrayItemIndex < fruits.length); arrayItemIndex += 1) {
    const arrayItem = fruits[arrayItemIndex];
    console.log(`fruits, index: ${arrayItemIndex}, item: ${jsonStringify(arrayItem)}, for loop`);
}
// fruits, index: 0, item: "apple", for loop
// fruits, index: 1, item: "mango", for loop
// fruits, index: 2, item: "orange", for loop

// iterate over and print each item and index
fruits.forEach((arrayItem, arrayItemIndex) => console.log(`fruits, index: ${arrayItemIndex}, item: ${jsonStringify(arrayItem)}, for each loop`));
// fruits, index: 0, item: "apple", for each loop
// fruits, index: 1, item: "mango", for each loop
// fruits, index: 2, item: "orange", for each loop

fruits.push("banana");
console.log(`fruits: ${jsonStringify(fruits)}`);
// fruits: ["apple", "mango", "orange", "banana"]
