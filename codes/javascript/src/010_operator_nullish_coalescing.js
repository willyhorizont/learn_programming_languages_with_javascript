/* eslint-disable dot-notation */

const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Nullish Coalescing Operator (??) in JavaScript");

const JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    },
    "fruits": ["apple", "mango", "banana"]
};
console.log(`JSON_OBJECT: ${jsonStringify(JSON_OBJECT, { pretty: true })}`);

console.log(`(JSON_OBJECT?.foo?.bar ?? "not found"):" ${(JSON_OBJECT?.foo?.bar ?? "not found")}`);
// (JSON_OBJECT?.foo?.bar ?? "not found"): baz

console.log(`(JSON_OBJECT?.foo?.baz ?? "not found"):" ${(JSON_OBJECT?.foo?.baz ?? "not found")}`);
// (JSON_OBJECT?.foo?.baz ?? "not found"): undefined

console.log(`(JSON_OBJECT?.fruits?.[2] ?? "not found"):" ${(JSON_OBJECT?.fruits?.[2] ?? "not found")}`);
// (JSON_OBJECT?.fruits?.[2] ?? "not found"): banana

console.log(`(JSON_OBJECT?.fruits?.[5] ?? "not found"):" ${(JSON_OBJECT?.fruits?.[5] ?? "not found")}`);
// (JSON_OBJECT?.fruits?.[5] ?? "not found"): undefined

console.log(`(JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"):" ${(JSON_OBJECT?.["foo"]?.["bar"] ?? "not found")}`);
// (JSON_OBJECT?.["foo"]?.["bar"] ?? "not found"): baz

console.log(`(JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"):" ${(JSON_OBJECT?.["foo"]?.["baz"] ?? "not found")}`);
// (JSON_OBJECT?.["foo"]?.["baz"] ?? "not found"): undefined

console.log(`(JSON_OBJECT?.["fruits"]?.[2] ?? "not found"):" ${(JSON_OBJECT?.["fruits"]?.[2] ?? "not found")}`);
// (JSON_OBJECT?.["fruits"]?.[2] ?? "not found"): banana

console.log(`(JSON_OBJECT?.["fruits"]?.[5] ?? "not found"):" ${(JSON_OBJECT?.["fruits"]?.[5] ?? "not found")}`);
// (JSON_OBJECT?.["fruits"]?.[5] ?? "not found"): undefined
