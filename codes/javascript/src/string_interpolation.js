const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// Template literals / Template strings (String Interpolation) in JavaScript");

const myName = "Alisa";
const myAge = 25;
console.log(`my name is ${myName} and I am ${myAge}.`);

console.log(`1 + 2 + 3 + 4 = ${1 + 2 + 3 + 4}`);

function getRectangleArea(rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
}
console.log(`getRectangleArea(7, 5): ${getRectangleArea(7, 5)}`);

const anyString = "foo";
console.log(`any string: ${jsonStringify(anyString)}`);

const anyNumeric = 123;
console.log(`any numeric: ${jsonStringify(anyNumeric)}`);

const anyBoolean = true;
console.log(`any boolean: ${jsonStringify(anyBoolean)}`);

const anyNull = null;
console.log(`any null: ${jsonStringify(anyNull)}`);

const anyArray = [1, 2, 3];
console.log(`any array: ${jsonStringify(anyArray)}`);
console.log(`any array first element: ${jsonStringify(anyArray?.[0])}`);

const anyObject = { "foo": "bar" };
console.log(`any object: ${jsonStringify(anyObject)}`);
console.log(`any object foo value: ${jsonStringify(anyObject?.foo)}`);
