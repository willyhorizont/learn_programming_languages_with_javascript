import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Object.fromEntries() in JavaScript");

const friendEntries = [["name", "Alisa"], ["country", "Finland"], ["age", 25]];
console.log(`friend entries: ${jsonStringify(friendEntries, { pretty: true })}`);

console.log(`friend object from friend entries: ${jsonStringify(Object.fromEntries(friendEntries), { pretty: true })}`);
// friend object from friend entries: {
//     "name": "Alisa",
//     "country": "Finland",
//     "age": 25
// }
