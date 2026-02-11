import {
    jsonStringify,
} from "./utils.js";

console.log("// console.log()");

const anyString = "foo";
const anyNumeric1 = 123;
const anyNumeric2 = 123.789;
const anyNumeric3 = -123;
const anyNumeric4 = -123.789;
const anyBoolean1 = true;
const anyBoolean2 = false;
const anyNull = null;
const anyUndefined = undefined;
const anyArray = [1, 2, 3];
const anyObject = { "foo": "bar" };
const anyFunction = (a, b) => (a * b);

// its add whitespace as separator by default
console.log("anyString: ", anyString, ", anyNumeric1: ", anyNumeric1, ", anyNumeric2: ", anyNumeric2, ", anyNumeric3: ", anyNumeric3, ", anyNumeric4: ", anyNumeric4, ", anyBoolean1: ", anyBoolean1, ", anyBoolean2: ", anyBoolean2, ", anyNull: ", anyNull, ", anyUndefined: ", anyUndefined, ", anyArray: ", anyArray, ", anyObject: ", anyObject, ", anyFunction: ", anyFunction);

console.log("anyString: ", jsonStringify(anyString), ", anyNumeric1: ", jsonStringify(anyNumeric1), ", anyNumeric2: ", jsonStringify(anyNumeric2), ", anyNumeric3: ", jsonStringify(anyNumeric3), ", anyNumeric4: ", jsonStringify(anyNumeric4), ", anyBoolean1: ", jsonStringify(anyBoolean1), ", anyBoolean2: ", jsonStringify(anyBoolean2), ", anyNull: ", jsonStringify(anyNull), ", anyUndefined: ", jsonStringify(anyUndefined), ", anyArray: ", jsonStringify(anyArray), ", anyObject: ", jsonStringify(anyObject), ", anyFunction: ", jsonStringify(anyFunction));

console.log("anyString:", jsonStringify(anyString), "anyNumeric1:", jsonStringify(anyNumeric1), "anyNumeric2:", jsonStringify(anyNumeric2), "anyNumeric3:", jsonStringify(anyNumeric3), "anyNumeric4:", jsonStringify(anyNumeric4), "anyBoolean1:", jsonStringify(anyBoolean1), "anyBoolean2:", jsonStringify(anyBoolean2), "anyNull:", jsonStringify(anyNull), "anyUndefined:", jsonStringify(anyUndefined), "anyArray:", jsonStringify(anyArray), "anyObject:", jsonStringify(anyObject), "anyFunction:", jsonStringify(anyFunction));

// ⭐⭐⭐⭐⭐ // using Template literals / Template strings (String Interpolation)
console.log(`anyString: ${jsonStringify(anyString)}, anyNumeric1: ${jsonStringify(anyNumeric1)}, anyNumeric2: ${jsonStringify(anyNumeric2)}, anyNumeric3: ${jsonStringify(anyNumeric3)}, anyNumeric4: ${jsonStringify(anyNumeric4)}, anyBoolean1: ${jsonStringify(anyBoolean1)}, anyBoolean2: ${jsonStringify(anyBoolean2)}, anyNull: ${jsonStringify(anyNull)}, anyUndefined: ${jsonStringify(anyUndefined)}, anyArray: ${jsonStringify(anyArray)}, anyObject: ${jsonStringify(anyObject)}, anyFunction: ${jsonStringify(anyFunction)}`);
