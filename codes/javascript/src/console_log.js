const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// console.log()");

const anyString = "foo";
const anyNumeric = 123;
const anyBoolean = true;
const anyNull = null;
const anyArray = [1, 2, 3];
const anyObject = { "foo": "bar" };

// its add whitespace as separator by default
console.log("any string: ", anyString, ", any numeric: ", anyNumeric, ", any boolean: ", anyBoolean, ", any null: ", anyNull, ", any array: ", anyArray, ", any object: ", anyObject);

console.log("any string: ", jsonStringify(anyString), ", any numeric: ", jsonStringify(anyNumeric), ", any boolean: ", jsonStringify(anyBoolean), ", any null: ", jsonStringify(anyNull), ", any array: ", jsonStringify(anyArray), ", any object: ", jsonStringify(anyObject));

console.log("any string:", jsonStringify(anyString), "any numeric:", jsonStringify(anyNumeric), "any boolean:", jsonStringify(anyBoolean), "any null:", jsonStringify(anyNull), "any array:", jsonStringify(anyArray), "any object:", jsonStringify(anyObject));

// ⭐⭐⭐⭐⭐ // using Template literals / Template strings (String Interpolation)
console.log(`any string: ${jsonStringify(anyString)}, any numeric: ${jsonStringify(anyNumeric)}, any boolean: ${jsonStringify(anyBoolean)}, any null: ${jsonStringify(anyNull)}, any array: ${jsonStringify(anyArray)}, any object: ${jsonStringify(anyObject)}`);

const consoleLog = (...restArguments) => console.log(restArguments.join(""));

consoleLog("any string: ", jsonStringify(anyString), ", any numeric: ", jsonStringify(anyNumeric), ", any boolean: ", jsonStringify(anyBoolean), ", any null: ", jsonStringify(anyNull), ", any array: ", jsonStringify(anyArray), ", any object: ", jsonStringify(anyObject));
