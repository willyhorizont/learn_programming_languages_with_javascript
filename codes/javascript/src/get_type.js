/* eslint-disable arrow-body-style */

const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// get type of something in JavaScript");

const getType = (anything) => {
    if ((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null)) return "Null";
    if ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false))) return "Boolean";
    if (Object.prototype.toString.call(anything) === "[object String]") return "String";
    if ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true)) return "Numeric";
    if (Object.prototype.toString.call(anything) === "[object Object]") return "Object";
    if ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true)) return "Array";
    return Object.prototype.toString.call(anything).split("[object ").join("").slice(0, -1);
};

const anyString = "foo";
console.log(`anyString: ${jsonStringify(anyString)}`);
console.log(`type of anyString is ${getType(anyString)}`);

const anyNumeric = 123;
console.log(`anyNumeric: ${jsonStringify(anyNumeric)}`);
console.log(`type of anyNumeric is ${getType(anyNumeric)}`);

const anyBoolean = true;
console.log(`anyBoolean: ${jsonStringify(anyBoolean)}`);
console.log(`type of anyBoolean is ${getType(anyBoolean)}`);

const anyNull = null;
console.log(`anyNull: ${jsonStringify(anyNull)}`);
console.log(`type of anyNull is ${getType(anyNull)}`);

const anyArray = [1, 2, 3];
console.log(`anyArray: ${jsonStringify(anyArray)}`);
console.log(`type of anyArray is ${getType(anyArray)}`);

const anyObject = { "foo": "bar" };
console.log(`anyObject: ${jsonStringify(anyObject)}`);
console.log(`type of anyObject is ${getType(anyObject)}`);
