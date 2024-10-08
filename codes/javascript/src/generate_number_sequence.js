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

const generateNumberSequence = (startNumber, stopNumber) => {
    if (stopNumber === undefined) throw new Error("expected (start_number, stop_number)");
    if ((getType(startNumber) !== jsType.Numeric) && (getType(stopNumber) !== jsType.Numeric)) throw new Error("expected (numeric_value, numeric_value)");
    if (stopNumber === startNumber) throw new Error("expected (stop_number > start_number) or (start_number > stop_number)");
    if (stopNumber > startNumber) {
        const numberSequenceArrayAscending = [];
        for (let aNumber = startNumber; (aNumber <= stopNumber); aNumber += 1) {
            numberSequenceArrayAscending.push(aNumber);
        }
        return numberSequenceArrayAscending;
    }
    if (startNumber > stopNumber) {
        const numberSequenceArrayDescending = [];
        for (let aNumber = startNumber; (aNumber >= stopNumber); aNumber -= 1) {
            numberSequenceArrayDescending.push(aNumber);
        }
        return numberSequenceArrayDescending;
    }
    throw new Error("something weird happened in generateNumberSequence");
};

console.log(`generateNumberSequence(0, 9): ${jsonStringify(generateNumberSequence(0, 9))}`);
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
console.log(`generateNumberSequence(1, 10): ${jsonStringify(generateNumberSequence(1, 10))}`);
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console.log(`generateNumberSequence(10, 1): ${jsonStringify(generateNumberSequence(10, 1))}`);
// [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
console.log(`generateNumberSequence(9, 0): ${jsonStringify(generateNumberSequence(9, 0))}`);
// [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
// console.log(`generateNumberSequence(10): ${jsonStringify(generateNumberSequence(10))}`); // error
// console.log(`generateNumberSequence(1, "bg"): ${jsonStringify(generateNumberSequence(1, "bg"))}`); // error
// console.log(`generateNumberSequence(5, 5): ${jsonStringify(generateNumberSequence(5, 5))}`); // error
