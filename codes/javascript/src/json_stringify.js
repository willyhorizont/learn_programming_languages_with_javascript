/* eslint-disable func-names */

console.log("// JSON.stringify() in JavaScript");

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

const jsonStringifyV1 = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

const jsonStringifyV2 = (anything, { pretty = false } = {}) => {
    // custom JSON.stringify() function jsonStringifyV2
    const indent = " ".repeat(4);
    const jsonStringifyInner = (anythingInner) => {
        const anythingInnerType = getType(anythingInner);
        if ((anythingInnerType === jsType.Null) || (anythingInnerType === jsType.String) || (anythingInnerType === jsType.Numeric) || (anythingInnerType === jsType.Boolean)) return anythingInner;
        if (anythingInnerType === jsType.Object) {
            const newObject = {};
            Object.entries(anythingInner).forEach(([objectKey, objectValue]) => {
                newObject[objectKey] = jsonStringifyInner(objectValue);
            });
            return newObject;
        }
        if (anythingInnerType === jsType.Array) {
            const newArray = [];
            anythingInner.forEach((arrayItem) => {
                newArray.push(jsonStringifyInner(arrayItem));
            });
            return newArray;
        }
        if (anythingInnerType === jsType.Function) return "[object Function]";
        return anythingInnerType;
    };
    const jsonStringifyInnerResult = jsonStringifyInner(anything);
    return ((pretty === true) ? (JSON.stringify(jsonStringifyInnerResult, null, indent)) : (JSON.stringify(jsonStringifyInnerResult)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")))?.split?.('"[object Function]"')?.join?.("[object Function]")?.split?.('"[object "')?.join?.("[object ")?.split?.(']"')?.join?.("]");
};

const jsonStringifyV3 = (anything, { pretty = false } = {}) => {
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

const myArray = [
    function (a, b) {
        return (a * b);
    },
    "foo",
    123,
    true,
    null,
    [1, 2, 3],
    { "foo": "bar" }
];
console.log(`JSON.stringify(myArray)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }"): ${JSON.stringify(myArray)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")}`); // turns function to null
console.log(`jsonStringifyV1(myArray): ${jsonStringifyV1(myArray)}`); // turns function to null
console.log(`jsonStringifyV2(myArray): ${jsonStringifyV2(myArray)}`);
console.log(`jsonStringifyV3(myArray): ${jsonStringifyV3(myArray)}`);
console.log(`jsonStringify(myArray): ${jsonStringify(myArray)}`);
console.log(`JSON.stringify(myArray, null, " ".repeat(4)): ${JSON.stringify(myArray, null, " ".repeat(4))}`); // turns function to null
console.log(`jsonStringifyV1(myArray, { pretty: true }): ${jsonStringifyV1(myArray, { pretty: true })}`); // turns function to null
console.log(`jsonStringifyV2(myArray, { pretty: true }): ${jsonStringifyV2(myArray, { pretty: true })}`);
console.log(`jsonStringifyV3(myArray, { pretty: true }): ${jsonStringifyV3(myArray, { pretty: true })}`);
console.log(`jsonStringify(myArray, { pretty: true }): ${jsonStringify(myArray, { pretty: true })}`);

const myObject = {
    "my_function": function (a, b) {
        return (a * b);
    },
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`JSON.stringify(myObject)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }"): ${JSON.stringify(myObject)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")}`);
console.log(`jsonStringifyV1(myObject): ${jsonStringifyV1(myObject)}`); // completely remove function
console.log(`jsonStringifyV2(myObject): ${jsonStringifyV2(myObject)}`);
console.log(`jsonStringifyV3(myObject): ${jsonStringifyV3(myObject)}`);
console.log(`jsonStringify(myObject): ${jsonStringify(myObject)}`);
console.log(`JSON.stringify(myObject, null, " ".repeat(4)): ${JSON.stringify(myObject, null, " ".repeat(4))}`); // completely remove function
console.log(`jsonStringifyV1(myObject, { pretty: true }): ${jsonStringifyV1(myObject, { pretty: true })}`);
console.log(`jsonStringifyV2(myObject, { pretty: true }): ${jsonStringifyV2(myObject, { pretty: true })}`);
console.log(`jsonStringifyV3(myObject, { pretty: true }): ${jsonStringifyV3(myObject, { pretty: true })}`);
console.log(`jsonStringify(myObject, { pretty: true }): ${jsonStringify(myObject, { pretty: true })}`);
