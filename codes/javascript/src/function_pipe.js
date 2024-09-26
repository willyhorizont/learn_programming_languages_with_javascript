/* eslint-disable no-undef-init */

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

console.log("// Pipe Function in JavaScript");

const pipe = (...restArguments) => {
    let pipeLastResult = undefined;
    const pipeResult = restArguments.reduce((currentResult, currentArgument) => {
        pipeLastResult = currentResult;
        if (getType(currentResult) === jsType.Null) return currentArgument;
        if (getType(currentArgument) === jsType.Function) return currentArgument?.(currentResult);
        return undefined;
    }, undefined);
    if (getType(pipeResult) === jsType.Function) return pipeResult?.(pipeLastResult);
    return pipeResult;
};

const plus25 = (aNumber) => (aNumber + 25);

const multiplyBy10 = (aNumber) => (aNumber * 10);

console.log(multiplyBy10(plus25(17))); // read from inside to outside

pipe(17, plus25, multiplyBy10, console.log); // read from left to right

console.log(pipe(17, plus25, multiplyBy10)); // read from left to right

const makeNumbersEasyToSay = (aNumber) => (`${Math.trunc(aNumber)}.something`);

const getCircleAreaInSquareCm = (radiusInCm) => (3.14 * (radiusInCm ** 2));

const getCylinderVolumeInMlOrCubicCm = (circleAreaInSquareCm, heightInCm) => (circleAreaInSquareCm * heightInCm);

const getMassInMlOrCubicCm = (volumeInMlOrCubicCm, densityInGramPerMlOrCubicCm) => (volumeInMlOrCubicCm * densityInGramPerMlOrCubicCm);

console.log(makeNumbersEasyToSay(getMassInMlOrCubicCm(getCylinderVolumeInMlOrCubicCm(getCircleAreaInSquareCm(7), 10), 0.72587))); // read from inside to outside

pipe(7, getCircleAreaInSquareCm, (x) => getCylinderVolumeInMlOrCubicCm(x, 10), (x) => getMassInMlOrCubicCm(x, 0.72587), makeNumbersEasyToSay, console.log); // read from left to right

console.log(pipe(7, getCircleAreaInSquareCm, (x) => getCylinderVolumeInMlOrCubicCm(x, 10), (x) => getMassInMlOrCubicCm(x, 0.72587), makeNumbersEasyToSay)); // read from left to right
