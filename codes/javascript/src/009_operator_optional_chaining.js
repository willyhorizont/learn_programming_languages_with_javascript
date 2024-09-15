/* eslint-disable dot-notation */

const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Optional Chaining Operator (?.) in JavaScript");

const JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    },
    "fruits": ["apple", "mango", "banana"]
};
console.log(`JSON_OBJECT: ${jsonStringify(JSON_OBJECT, { pretty: true })}`);

console.log(`JSON_OBJECT?.foo?.bar: ${JSON_OBJECT?.foo?.bar}`);
// JSON_OBJECT?.foo?.bar: baz

console.log(`JSON_OBJECT?.foo?.baz: ${JSON_OBJECT?.foo?.baz}`);
// JSON_OBJECT?.foo?.baz: undefined

console.log(`JSON_OBJECT?.fruits?.[2]: ${JSON_OBJECT?.fruits?.[2]}`);
// JSON_OBJECT?.fruits?.[2]: banana

console.log(`JSON_OBJECT?.fruits?.[5]: ${JSON_OBJECT?.fruits?.[5]}`);
// JSON_OBJECT?.fruits?.[5]: undefined

console.log(`JSON_OBJECT?.["foo"]?.["bar"]: ${JSON_OBJECT?.["foo"]?.["bar"]}`);
// JSON_OBJECT?.["foo"]?.["bar"]: baz

console.log(`JSON_OBJECT?.["foo"]?.["baz"]: ${JSON_OBJECT?.["foo"]?.["baz"]}`);
// JSON_OBJECT?.["foo"]?.["baz"]: undefined

console.log(`JSON_OBJECT?.["fruits"]?.[2]: ${JSON_OBJECT?.["fruits"]?.[2]}`);
// JSON_OBJECT?.["fruits"]?.[2]: banana

console.log(`JSON_OBJECT?.["fruits"]?.[5]: ${JSON_OBJECT?.["fruits"]?.[5]}`);
// JSON_OBJECT?.["fruits"]?.[5]: undefined
