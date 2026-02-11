import {
    AnyType,
    getType,
    generateTimestamp,
    jsonStringify,
    isStringIso8601,
} from "./utils.js";

console.log("// JSON.stringify() in JavaScript");

const jsonStringifyV1 = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything).split(",").join(", ").split(":").join(": ").split("{").join("{ ").split("}").join(" }")));

const jsonStringifyV2 = (anything, { pretty = false } = {}) => {
    // custom JSON.stringify() function jsonStringifyV2
    const indent = " ".repeat(4);
    const jsonStringifyInner = (anythingInner) => {
        const anythingInnerType = getType(anythingInner);
        if (anythingInnerType === AnyType["Undefined"]) return "undefined";
        if (anythingInnerType === AnyType["Date"]) return jsonStringifyInner({ "pretty": generateTimestamp(anythingInner), "ISO8601": anythingInner.toISOString() });
        if ((anythingInnerType === AnyType["Null"]) || (anythingInnerType === AnyType["String"]) || (anythingInnerType === AnyType["Numeric"]) || (anythingInnerType === AnyType["Boolean"])) return anythingInner;
        if (anythingInnerType === AnyType["Object"]) {
            const newObject = {};
            Object.entries(anythingInner).forEach(([objectKey, objectValue]) => {
                newObject[objectKey] = jsonStringifyInner(objectValue);
            });
            return newObject;
        }
        if (anythingInnerType === AnyType["Array"]) {
            const newArray = [];
            anythingInner.forEach((arrayItem) => {
                newArray.push(jsonStringifyInner(arrayItem));
            });
            return newArray;
        }
        if (anythingInnerType === AnyType["Function"]) return anythingInner.toString();
        return `${anythingInner}`;
    };
    const jsonStringifyInnerResult = jsonStringifyInner(anything);
    return ((pretty === true) ? (JSON.stringify(jsonStringifyInnerResult, null, indent)) : (JSON.stringify(jsonStringifyInnerResult).split(",").join(", ").split(":").join(": ").split("{").join("{ ").split("}").join(" }")));
};

const jsonStringifyV3 = (anything, { pretty = false } = {}) => {
    // custom JSON.stringify() function jsonStringifyV3
    const indent = " ".repeat(4);
    let indentLevel = 0;
    const jsonStringifyInner = (anythingInner) => {
        if (isStringIso8601(anythingInner) === true) jsonStringifyInner({ "pretty": generateTimestamp(anythingInner), "ISO8601": anythingInner });
        const anythingInnerType = getType(anythingInner);
        if (anythingInnerType === AnyType["Undefined"]) return '"undefined"';
        if (anythingInnerType === AnyType["Null"]) return "null";
        if (anythingInnerType === AnyType["Date"]) return jsonStringifyInner({ "pretty": generateTimestamp(anythingInner), "ISO8601": anythingInner.toISOString() });
        if (anythingInnerType === AnyType["Error"]) return `"${anythingInner.toString()}"`;
        if (anythingInnerType === AnyType["String"]) return `"${anythingInner}"`;
        if ((anythingInnerType === AnyType["Numeric"]) || (anythingInnerType === AnyType["Boolean"])) return `${anythingInner}`;
        if (anythingInnerType === AnyType["Object"]) {
            if (Object.keys(anythingInner).length === 0) return "{}";
            if (Object.keys(anythingInner).includes("ISO8601") === true) {
                indentLevel += 1;
                let result = ((pretty === true) ? (`{\n${indent.repeat(indentLevel)}`) : "{ ");
                result = (`${result}"pretty": "${anythingInner["pretty"]}"${(pretty === true) ? (`,\n${indent.repeat(indentLevel)}`) : ", "}"ISO8601": "${anythingInner["ISO8601"]}"${(pretty === true) ? "," : ""}`);
                indentLevel -= 1;
                result = `${result}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`;
                return result;
            }
            indentLevel += 1;
            let result = ((pretty === true) ? (`{\n${indent.repeat(indentLevel)}`) : "{ ");
            Object.entries(anythingInner).forEach(([objectKey, objectValue], objectEntryIndex) => {
                result = (`${result}"${objectKey}": ${jsonStringifyInner(objectValue)}${((objectEntryIndex + 1) !== Object.keys(anythingInner).length) ? ((pretty === true) ? (`,\n${indent.repeat(indentLevel)}`) : ", ") : ""}`);
            });
            indentLevel -= 1;
            result = `${result}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`;
            return result;
        }
        if (anythingInnerType === AnyType["Array"]) {
            if (anythingInner.length === 0) return "[]";
            indentLevel += 1;
            let result = ((pretty === true) ? (`[\n${indent.repeat(indentLevel)}`) : "[");
            anythingInner.forEach((arrayItem, arrayItemIndex) => {
                result = (`${result}${jsonStringifyInner(arrayItem)}${((arrayItemIndex + 1) !== anythingInner.length) ? ((pretty === true) ? (`,\n${indent.repeat(indentLevel)}`) : ", ") : ""}`);
            });
            indentLevel -= 1;
            result = `${result}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}]`) : "]")}`;
            return result;
        }
        if (anythingInnerType === AnyType["Function"]) return `"${anythingInner.toString()}"`;
        return `${anythingInner}`;
    };
    return jsonStringifyInner(anything);
};

const jsonStringifyV4 = (anything, { pretty = false, indent = " ".repeat(4), indentLevel = 0, argumentType = getType(anything) } = {}) => {
    // custom JSON.stringify() function jsonStringifyV4
    if (isStringIso8601(anything) === true) return jsonStringifyV4({ "pretty": generateTimestamp(anything), "ISO8601": anything }, { pretty, indentLevel });
    if (argumentType === AnyType["Undefined"]) return '"undefined"';
    if (argumentType === AnyType["Null"]) return "null";
    if (argumentType === AnyType["Error"]) return `"${anything.toString()}"`;
    if (argumentType === AnyType["Date"]) return jsonStringifyV4({ "pretty": generateTimestamp(anything), "ISO8601": anything.toISOString() }, { pretty, indentLevel });
    if (argumentType === AnyType["String"]) return `"${anything}"`;
    if ((argumentType === AnyType["Numeric"]) || (argumentType === AnyType["Boolean"])) return `${anything}`;
    if (argumentType === AnyType["Object"]) {
        if (Object.keys(anything).length === 0) return "{}";
        if (Object.keys(anything).includes("ISO8601") === true) return `${((pretty === true) ? (`{\n${indent.repeat(indentLevel + 1)}`) : "{ ")}${(`"pretty": "${anything["pretty"]}"${(pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", "}"ISO8601": "${anything["ISO8601"]}"${(pretty === true) ? "," : ""}`)}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`;
        return `${((pretty === true) ? (`{\n${indent.repeat(indentLevel + 1)}`) : "{ ")}${Object.entries(anything).reduce((currentResult, [objectKey, objectValue], objectEntryIndex) => (`${currentResult}"${objectKey}": ${jsonStringifyV4(objectValue, { pretty, indentLevel: (indentLevel + 1) })}${((objectEntryIndex + 1) !== Object.keys(anything).length) ? ((pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", ") : ""}`), "")}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`;
    }
    if (argumentType === AnyType["Array"]) {
        if (anything.length === 0) return "[]";
        return `${((pretty === true) ? (`[\n${indent.repeat(indentLevel + 1)}`) : "[")}${anything.reduce((currentResult, arrayItem, arrayItemIndex) => (`${currentResult}${jsonStringifyV4(arrayItem, { pretty, indentLevel: (indentLevel + 1) })}${((arrayItemIndex + 1) !== anything.length) ? ((pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", ") : ""}`), "")}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}]`) : "]")}`;
    }
    if (argumentType === AnyType["Function"]) return `"${anything.toString()}"`;
    return `${anything}`;
};

const jsonStringifyV5 = jsonStringify;

const myArray = [
    "foo",
    123,
    123.789,
    -123,
    -123.789,
    true,
    false,
    null,
    undefined,
    [1, 2, 3],
    { "foo": "bar" },
    (a, b) => (a * b),
    new Date(),
    new Error("Something went wrong"),
];
console.log(`JSON.stringify(myArray).split(",").join(", ").split(":").join(": ").split("{").join("{ ").split("}").join(" }"): ${JSON.stringify(myArray).split(",").join(", ").split(":").join(": ").split("{").join("{ ").split("}").join(" }")}`); // turns function to null
console.log(`jsonStringifyV1(myArray): ${jsonStringifyV1(myArray)}`); // turns function to null
console.log(`jsonStringifyV2(myArray): ${jsonStringifyV2(myArray)}`);
console.log(`jsonStringifyV3(myArray): ${jsonStringifyV3(myArray)}`);
console.log(`jsonStringifyV4(myArray): ${jsonStringifyV4(myArray)}`);
console.log(`jsonStringifyV5(myArray): ${jsonStringifyV5(myArray)}`);
console.log(`jsonStringify(myArray): ${jsonStringify(myArray)}`);
console.log(`JSON.stringify(myArray, null, " ".repeat(4)): ${JSON.stringify(myArray, null, " ".repeat(4))}`); // turns function to null
console.log(`jsonStringifyV1(myArray, { pretty: true }): ${jsonStringifyV1(myArray, { pretty: true })}`); // turns function to null
console.log(`jsonStringifyV2(myArray, { pretty: true }): ${jsonStringifyV2(myArray, { pretty: true })}`);
console.log(`jsonStringifyV3(myArray, { pretty: true }): ${jsonStringifyV3(myArray, { pretty: true })}`);
console.log(`jsonStringifyV4(myArray, { pretty: true }): ${jsonStringifyV4(myArray, { pretty: true })}`);
console.log(`jsonStringifyV5(myArray, { pretty: true }): ${jsonStringifyV5(myArray, { pretty: true })}`);
console.log(`jsonStringify(myArray, { pretty: true }): ${jsonStringify(myArray, { pretty: true })}`);

const myObject = {
    "my_string": "foo",
    "my_number_a": 123,
    "my_number_b": 123.789,
    "my_number_c": -123,
    "my_number_d": -123.789,
    "my_boolean_a": true,
    "my_boolean_b": false,
    "my_null": null,
    "my_undefiend": undefined,
    "my_array": [1, 2, 3],
    "my_object": { "foo": "bar" },
    "my_function": (a, b) => (a * b),
    "my_date": new Date(),
    "my_error": new Error("Something went wrong"),
};
console.log(`JSON.stringify(myObject).split(",").join(", ").split(":").join(": ").split("{").join("{ ").split("}").join(" }"): ${JSON.stringify(myObject).split(",").join(", ").split(":").join(": ").split("{").join("{ ").split("}").join(" }")}`);
console.log(`jsonStringifyV1(myObject): ${jsonStringifyV1(myObject)}`); // completely remove function
console.log(`jsonStringifyV2(myObject): ${jsonStringifyV2(myObject)}`);
console.log(`jsonStringifyV3(myObject): ${jsonStringifyV3(myObject)}`);
console.log(`jsonStringifyV4(myObject): ${jsonStringifyV4(myObject)}`);
console.log(`jsonStringifyV5(myObject): ${jsonStringifyV5(myObject)}`);
console.log(`jsonStringify(myObject): ${jsonStringify(myObject)}`);
console.log(`JSON.stringify(myObject, null, " ".repeat(4)): ${JSON.stringify(myObject, null, " ".repeat(4))}`); // completely remove function
console.log(`jsonStringifyV1(myObject, { pretty: true }): ${jsonStringifyV1(myObject, { pretty: true })}`);
console.log(`jsonStringifyV2(myObject, { pretty: true }): ${jsonStringifyV2(myObject, { pretty: true })}`);
console.log(`jsonStringifyV3(myObject, { pretty: true }): ${jsonStringifyV3(myObject, { pretty: true })}`);
console.log(`jsonStringifyV4(myObject, { pretty: true }): ${jsonStringifyV4(myObject, { pretty: true })}`);
console.log(`jsonStringifyV5(myObject, { pretty: true }): ${jsonStringifyV5(myObject, { pretty: true })}`);
console.log(`jsonStringify(myObject, { pretty: true }): ${jsonStringify(myObject, { pretty: true })}`);
