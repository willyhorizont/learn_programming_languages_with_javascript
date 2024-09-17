const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// console.log()");

const anyString = "foo";
const anyNumeric = 123;
const anyBoolean = true;
const anyNull = null;
const anyArray = [1, 2, 3];
const anyObject = { "foo": "bar" };

// its add whitespace as separator by default
console.log("any String: ", anyString, ", any Numeric: ", anyNumeric, ", any Boolean: ", anyBoolean, ", any Null: ", anyNull, ", any Array: ", anyArray, ", any Object: ", anyObject);

console.log("any String: ", jsonStringify(anyString), ", any Numeric: ", jsonStringify(anyNumeric), ", any Boolean: ", jsonStringify(anyBoolean), ", any Null: ", jsonStringify(anyNull), ", any Array: ", jsonStringify(anyArray), ", any Object: ", jsonStringify(anyObject));

console.log("any String:", jsonStringify(anyString), "any Numeric:", jsonStringify(anyNumeric), "any Boolean:", jsonStringify(anyBoolean), "any Null:", jsonStringify(anyNull), "any Array:", jsonStringify(anyArray), "any Object:", jsonStringify(anyObject));

// using Template literals / Template strings (String Interpolation)
console.log(`any String: ${jsonStringify(anyString)}, any Numeric: ${jsonStringify(anyNumeric)}, any Boolean: ${jsonStringify(anyBoolean)}, any Null: ${jsonStringify(anyNull)}, any Array: ${jsonStringify(anyArray)}, any Object: ${jsonStringify(anyObject)}`);

const consoleLog = (...restArguments) => console.log(restArguments.join(""));

consoleLog("any String: ", jsonStringify(anyString), ", any Numeric: ", jsonStringify(anyNumeric), ", any Boolean: ", jsonStringify(anyBoolean), ", any Null: ", jsonStringify(anyNull), ", any Array: ", jsonStringify(anyArray), ", any Object: ", jsonStringify(anyObject));
