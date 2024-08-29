/* eslint-disable no-restricted-syntax */
console.log("\n// Object.values() in JavaScript");

const friend1 = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend1: ${JSON.stringify(friend1, null, " ".repeat(4))}`);

console.log(`Object.values(friend1): ${JSON.stringify(Object.values(friend1)).split(",").join(", ")}`);
// Object.values(friend1): ["Alisa", "Finland", 25]

const friend2 = new Map([
    ["name", "Alisa"],
    ["country", "Finland"],
    ["age", 25]
]);
console.log(`Object.fromEntries([...friend2]): ${JSON.stringify(Object.fromEntries([...friend2]), null, " ".repeat(4))}`);

console.log(`Array.from(friend2.values()): ${JSON.stringify(Array.from(friend2.values())).split(",").join(", ")}`);
// Array.from(friend2.values()): ["Alisa", "Finland", 25]
