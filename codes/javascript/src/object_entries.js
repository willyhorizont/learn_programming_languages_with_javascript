console.log("\n// Object.entries() in JavaScript");

const friend1 = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend1: ${JSON.stringify(friend1, null, " ".repeat(4))}`);

console.log(`Object.entries(friend1): ${JSON.stringify(Object.entries(friend1)).split(",").join(", ")}`);
// Object.entries(friend1): [["name", "Alisa"], ["country", "Finland"], ["age", 25]]

const friend2 = new Map([
    ["name", "Alisa"],
    ["country", "Finland"],
    ["age", 25]
]);
console.log(`Object.fromEntries([...friend2]): ${JSON.stringify(Object.fromEntries([...friend2]), null, " ".repeat(4))}`);

console.log(`Array.from(friend2.entries()): ${JSON.stringify(Array.from(friend2.entries())).split(",").join(", ")}`);
// Object.entries(friend1): [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
