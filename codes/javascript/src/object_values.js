const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Object.values() in JavaScript");

const friend1 = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

console.log(`friend1 values: ${jsonStringify(Object.values(friend1))}`);
// friend1 values: ["Alisa", "Finland", 25]

const friend2 = new Map([
    ["name", "Alisa"],
    ["country", "Finland"],
    ["age", 25]
]);
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

console.log(`friend2 values: ${jsonStringify(Array.from(friend2.values()))}`);
// friend2 values: ["Alisa", "Finland", 25]
