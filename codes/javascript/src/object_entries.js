const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Object.entries() in JavaScript");

const friend1 = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

console.log(`friend1 entries: ${jsonStringify(Object.entries(friend1))}`);
// friend1 entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]

const friend2 = new Map([
    ["name", "Alisa"],
    ["country", "Finland"],
    ["age", 25]
]);
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

console.log(`friend2 entries: ${jsonStringify(Array.from(friend2.entries()))}`);
// friend2 entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
