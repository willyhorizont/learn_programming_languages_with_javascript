const jsType = { "Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function" };

const isNull = (anything) => (((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null)) || ((Object.prototype.toString.call(anything) === "[object Undefined]") && (anything === undefined)));

const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));

const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");

const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));

const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");

const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));

const isFunction = (anything) => (Object.prototype.toString.call(anything) === "[object Function]");

const getType = (anything) => ((isNull(anything) === true) ? jsType.Null : ((isBoolean(anything) === true) ? jsType.Boolean : ((isString(anything) === true) ? jsType.String : ((isNumeric(anything) === true) ? jsType.Numeric : ((isObject(anything) === true) ? jsType.Object : ((isArray(anything) === true) ? jsType.Array : ((isFunction(anything) === true) ? jsType.Function : Object.prototype.toString.call(anything))))))));

const jsonStringify = (anything, { pretty = false, indent = " ".repeat(4), indentLevel = 0, argumentType = getType(anything) } = {}) => ((argumentType === jsType.Null) ? "null" : ((argumentType === jsType.String) ? `"${anything}"` : (((argumentType === jsType.Numeric) || (argumentType === jsType.Boolean)) ? `${anything}` : ((argumentType === jsType.Object) ? ((Object.keys(anything).length === 0) ? "{}" : (`${((pretty === true) ? (`{\n${indent.repeat(indentLevel + 1)}`) : "{ ")}${Object.entries(anything).reduce((currentResult, [objectKey, objectValue], objectEntryIndex) => (`${currentResult}${(((objectEntryIndex + 1) !== Object.keys(anything).length) ? `"${objectKey}": ${jsonStringify(objectValue, { pretty, indentLevel: (indentLevel + 1) })}${((pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", ")}` : `"${objectKey}": ${jsonStringify(objectValue, { pretty, indentLevel: (indentLevel + 1) })}`)}`), "")}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`)) : ((argumentType === jsType.Array) ? ((anything.length === 0) ? "[]" : (`${((pretty === true) ? (`[\n${indent.repeat(indentLevel + 1)}`) : "[")}${anything.reduce((currentResult, arrayItem, arrayItemIndex) => ((((arrayItemIndex + 1) !== anything.length) ? `${currentResult}${jsonStringify(arrayItem, { pretty, indentLevel: (indentLevel + 1) })}${((pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", ")}` : `${currentResult}${jsonStringify(arrayItem, { pretty, indentLevel: (indentLevel + 1) })}`)), "")}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}]`) : "]")}`)) : ((argumentType === jsType.Function) ? "[object Function]" : argumentType)))))); // custom JSON.stringify() function jsonStringifyV4

const fibonacci = (stopper) => {
    let numLeft = 0;
    let numRight = 1;
    let plusNumLeftNumRight = (numLeft + numRight);
    let result = (numLeft.toString() + ", " + numRight.toString() + ", " + plusNumLeftNumRight.toString());
    let i = 0;
    while (i <= stopper) {
        numLeft = numRight;
        numRight = plusNumLeftNumRight;
        plusNumLeftNumRight = (numLeft + numRight);
        result += ", " + plusNumLeftNumRight.toString();
        i += 1;
    }
    return result;
};

console.log(`fibonacci(9): ${fibonacci(9)}`);
// 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144

const generateFibonacciUntil = (stopper = 5) => {
    let iterator = 0;
    let fibonacci = [0, 1];
    while (iterator <= stopper) {
        const lastIndex = (fibonacci.length - 1);
        const lastNumberLeft = fibonacci[lastIndex - 1];
        const lastNumberRight = fibonacci[lastIndex];
        fibonacci = [...fibonacci, (lastNumberRight + lastNumberLeft)];
        iterator += 1;
    }
    return fibonacci;
};

console.log(`generateFibonacciUntil(9): ${generateFibonacciUntil(9).join(", ")}`);

const generateFibonacciArray = (n) => {
    if (n <= 0) return [];
    if (n === 1) return [0];
    let numLeft = 0;
    let numRight = 1;
    let result = [numLeft, numRight];
    for (let i = 2; (i < n); i += 1) {
        const nextNum = (numLeft + numRight);
        result.push(nextNum);
        numLeft = numRight;
        numRight = nextNum;
    }
    return result;
};
console.log(`generateFibonacciArray(5): ${generateFibonacciArray(5).join(", ")}`);

const generateFibonacciString = (n) => {
    if (n <= 0) return "";
    if (n === 1) return "0";
    let numLeft = 0;
    let numRight = 1;
    let result = `${numLeft}, ${numRight}`;
    for (let i = 2; (i < n); i += 1) {
        const nextNum = (numLeft + numRight);
        result += `, ${nextNum}`;
        numLeft = numRight;
        numRight = nextNum;
    }
    return result;
};
console.log(`generateFibonacciString(5): ${generateFibonacciString(5)}`);
