/* eslint-disable no-undef-init */

const jsType = { "Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function" };

const isNull = (anything) => (((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null)) || ((Object.prototype.toString.call(anything) === "[object Undefined]") && (anything === undefined)));

const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));

const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");

const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));

const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");

const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));

const isFunction = (anything) => (Object.prototype.toString.call(anything) === "[object Function]");

const getType = (anything) => ((isNull(anything) === true) ? jsType.Null : ((isBoolean(anything) === true) ? jsType.Boolean : ((isString(anything) === true) ? jsType.String : ((isNumeric(anything) === true) ? jsType.Numeric : ((isObject(anything) === true) ? jsType.Object : ((isArray(anything) === true) ? jsType.Array : ((isFunction(anything) === true) ? jsType.Function : Object.prototype.toString.call(anything))))))));

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

const plus25 = (anyNumber) => (anyNumber + 25);

const multiplyBy10 = (anyNumber) => (anyNumber * 10);

console.log(multiplyBy10(plus25(17))); // read from inside to outside

pipe(17, plus25, multiplyBy10, console.log); // read from left to right

console.log(pipe(17, plus25, multiplyBy10)); // read from left to right

const makeNumberEasyToSay = (anyNumber) => (`${Math.trunc(anyNumber)}.something`);

const getCircleAreaInSquareCm = (radiusInCm) => (3.14 * (radiusInCm ** 2));

const getCylinderVolumeInMlOrCubicCm = (circleAreaInSquareCm, heightInCm) => (circleAreaInSquareCm * heightInCm);

const getMassInMlOrCubicCm = (volumeInMlOrCubicCm, densityInGramPerMlOrCubicCm) => (volumeInMlOrCubicCm * densityInGramPerMlOrCubicCm);

console.log(makeNumberEasyToSay(getMassInMlOrCubicCm(getCylinderVolumeInMlOrCubicCm(getCircleAreaInSquareCm(7), 10), 0.72587))); // read from inside to outside

pipe(7, getCircleAreaInSquareCm, (x) => getCylinderVolumeInMlOrCubicCm(x, 10), (x) => getMassInMlOrCubicCm(x, 0.72587), makeNumberEasyToSay, console.log); // read from left to right

console.log(pipe(7, getCircleAreaInSquareCm, (x) => getCylinderVolumeInMlOrCubicCm(x, 10), (x) => getMassInMlOrCubicCm(x, 0.72587), makeNumberEasyToSay)); // read from left to right
