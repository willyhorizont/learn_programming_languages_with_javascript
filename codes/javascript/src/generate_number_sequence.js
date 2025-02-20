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

const generateNumberSequence = (startNumber, stopNumber) => {
    const numberSequenceArray = [];
    if (stopNumber > startNumber) {
        for (let anyNumber = startNumber; (anyNumber <= stopNumber); anyNumber += 1) {
            numberSequenceArray.push(anyNumber);
        }
        return numberSequenceArray;
    }
    if (startNumber > stopNumber) {
        for (let anyNumber = startNumber; (anyNumber >= stopNumber); anyNumber -= 1) {
            numberSequenceArray.push(anyNumber);
        }
        return numberSequenceArray;
    }
    return numberSequenceArray;
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
