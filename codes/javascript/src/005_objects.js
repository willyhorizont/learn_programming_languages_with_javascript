/* eslint-disable dot-notation */

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

console.log("// JavaScript Object");

const friend1 = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

console.log(`friend1, get total object keys: ${Object.keys(friend1).length}`);
// friend1, get total object keys: 3

console.log(`friend1, get country: ${jsonStringify(friend1["country"])}`);
// friend1, get country: "Finland"

console.log(`friend1, get country: ${jsonStringify(friend1?.["country"])}`);
// friend1, get country: "Finland"

console.log(`friend1, get country: ${jsonStringify(friend1.country)}`);
// friend1, get country: "Finland"

console.log(`friend1, get country: ${jsonStringify(friend1?.country)}`);
// friend1, get country: "Finland"

// iterate over and print each key-value pair and object entry index
Object.entries(friend1).forEach(([objectKey, objectValue], objectEntryIndex) => console.log(`friend1, for each loop, object entry index: ${objectEntryIndex}, key: ${jsonStringify(objectKey)}, value: ${jsonStringify(objectValue)}`));
// friend1, for each loop, object entry index: 0, key: "name", value: "Alisa"
// friend1, for each loop, object entry index: 1, key: "country", value: "Finland"
// friend1, for each loop, object entry index: 2, key: "age", value: 25

friend1["age"] = 27;
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

friend1["gender"] = "Female";
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

friend1.job = "Streamer";
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

delete friend1.country;
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
const deliveryResponseKeyMessage = "message";
const deliveryResponse = {
    [deliveryResponseKeyMessage]: "ok"
};
console.log(`deliveryResponse: ${jsonStringify(deliveryResponse, { pretty: true })}`);
const deliveryResponseKeyStatus = "status";
deliveryResponse[deliveryResponseKeyStatus] = 200;
console.log(`deliveryResponse: ${jsonStringify(deliveryResponse, { pretty: true })}`);

const friend2 = new Map([
    ["name", "Alisa"],
    ["country", "Finland"],
    ["age", 25]
]);
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

console.log(`friend2, get total object keys: ${Array.from(friend2.keys()).length}`);
// friend2, get total object keys: 3

console.log(`friend2, get country: ${jsonStringify(Object.fromEntries(friend2)["country"])}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(Object.fromEntries(friend2)?.["country"])}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(Object.fromEntries(friend2).country)}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(Object.fromEntries(friend2)?.country)}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(friend2.get("country"))}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(friend2?.get?.("country"))}`);
// friend2, get country: "Finland"

// iterate over and print each key-value pair and object entry index
Object.entries(Object.fromEntries([...friend2])).forEach(([objectKey, objectValue], objectEntryIndex) => console.log(`friend2, for each loop, object entry index: ${objectEntryIndex}, key: ${jsonStringify(objectKey)}, value: ${jsonStringify(objectValue)}`));
// friend2, for each loop, object entry index: 0, key: "name", value: "Alisa"
// friend2, for each loop, object entry index: 1, key: "country", value: "Finland"
// friend2, for each loop, object entry index: 2, key: "age", value: 25

friend2.set("age", 27);
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

friend2.set("gender", "Female");
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

friend2.set("job", "Streamer");
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

friend2.delete("country");
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);
