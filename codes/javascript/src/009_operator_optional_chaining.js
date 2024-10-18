/* eslint-disable dot-notation */

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

console.log("\n// Optional Chaining Operator (?.) in JavaScript");

const JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    },
    "fruits": ["apple", "mango", "banana"],
    "get_rectangle_area": (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength)
};
console.log(`JSON_OBJECT: ${jsonStringify(JSON_OBJECT, { pretty: true })}`);

console.log(`JSON_OBJECT?.foo?.bar: ${JSON_OBJECT?.foo?.bar}`);
// JSON_OBJECT?.foo?.bar: baz

console.log(`JSON_OBJECT?.foo?.baz: ${JSON_OBJECT?.foo?.baz}`);
// JSON_OBJECT?.foo?.baz: undefined

console.log(`JSON_OBJECT?.fruits?.[2]: ${JSON_OBJECT?.fruits?.[2]}`);
// JSON_OBJECT?.fruits?.[2]: banana

console.log(`JSON_OBJECT?.fruits?.[5]: ${JSON_OBJECT?.fruits?.[5]}`);
// JSON_OBJECT?.fruits?.[5]: undefined

console.log(`JSON_OBJECT?.get_rectangle_area?.(7, 5): ${JSON_OBJECT?.get_rectangle_area?.(7, 5)}`);
// JSON_OBJECT?.get_rectangle_area?.(7, 5): 35

console.log(`JSON_OBJECT?.get_circle_area?.(7): ${JSON_OBJECT?.get_circle_area?.(7)}`);
// JSON_OBJECT?.get_circle_area?.(7): undefined

console.log(`JSON_OBJECT?.["foo"]?.["bar"]: ${JSON_OBJECT?.["foo"]?.["bar"]}`);
// JSON_OBJECT?.["foo"]?.["bar"]: baz

console.log(`JSON_OBJECT?.["foo"]?.["baz"]: ${JSON_OBJECT?.["foo"]?.["baz"]}`);
// JSON_OBJECT?.["foo"]?.["baz"]: undefined

console.log(`JSON_OBJECT?.["fruits"]?.[2]: ${JSON_OBJECT?.["fruits"]?.[2]}`);
// JSON_OBJECT?.["fruits"]?.[2]: banana

console.log(`JSON_OBJECT?.["fruits"]?.[5]: ${JSON_OBJECT?.["fruits"]?.[5]}`);
// JSON_OBJECT?.["fruits"]?.[5]: undefined

console.log(`JSON_OBJECT?.["get_rectangle_area"]?.(7, 5): ${JSON_OBJECT?.["get_rectangle_area"]?.(7, 5)}`);
// JSON_OBJECT?.["get_rectangle_area"]?.(7, 5): 35

console.log(`JSON_OBJECT?.["get_circle_area"]?.(7): ${JSON_OBJECT?.["get_circle_area"]?.(7)}`);
// JSON_OBJECT?.["get_circle_area"]?.(7): undefined
