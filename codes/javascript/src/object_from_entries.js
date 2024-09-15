const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("\n// Object.fromEntries() in JavaScript");

const friendEntries = [["name", "Alisa"], ["country", "Finland"], ["age", 25]];
console.log(`friend entries: ${jsonStringify(friendEntries, { pretty: true })}`);

console.log(`friend object from friend entries: ${jsonStringify(Object.fromEntries(friendEntries), { pretty: true })}`);
// friend object from friend entries: {
//     "name": "Alisa",
//     "country": "Finland",
//     "age": 25
// }
