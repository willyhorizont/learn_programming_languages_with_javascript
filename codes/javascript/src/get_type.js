const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// get type of something in JavaScript");

const isNull = (anything) => ((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null));
const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));
const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");
const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));
const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");
const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));

const getType = (anything) => {
    if (isNull(anything) === true) return "Null";
    if (isBoolean(anything) === true) return "Boolean";
    if (isString(anything) === true) return "String";
    if (isNumeric(anything) === true) return "Numeric";
    if (isObject(anything) === true) return "Object";
    if (isArray(anything) === true) return "Array";
    return Object.prototype.toString.call(anything).split("[object ").join("").slice(0, -1);
};

const anyString = "foo";
console.log(`anyString: ${jsonStringify(anyString)}`);
console.log(`type of anyString: ${getType(anyString)}`);

const anyNumeric = 123;
console.log(`anyNumeric: ${jsonStringify(anyNumeric)}`);
console.log(`type of anyNumeric: "${getType(anyNumeric)}"`);

const anyBoolean = true;
console.log(`anyBoolean: ${jsonStringify(anyBoolean)}`);
console.log(`type of anyBoolean: "${getType(anyBoolean)}"`);

const anyNull = null;
console.log(`anyNull: ${jsonStringify(anyNull)}`);
console.log(`type of anyNull: "${getType(anyNull)}"`);

const anyArray = [1, 2, 3];
console.log(`anyArray: ${jsonStringify(anyArray)}`);
console.log(`type of anyArray: "${getType(anyArray)}"`);

const anyObject = { "foo": "bar" };
console.log(`anyObject: ${jsonStringify(anyObject)}`);
console.log(`type of anyObject: "${getType(anyObject)}"`);
