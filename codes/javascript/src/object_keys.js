console.log("\n// Object.keys() in JavaScript");

const friend1 = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend1: ${JSON.stringify(friend1, null, " ".repeat(4))}`);

console.log(`friend1 keys: ${JSON.stringify(Object.keys(friend1)).split(",").join(", ")}`);
// friend1 keys: ["name", "country", "age"]

const friend2 = new Map([
    ["name", "Alisa"],
    ["country", "Finland"],
    ["age", 25]
]);
console.log(`Object.fromEntries([...friend2]): ${JSON.stringify(Object.fromEntries([...friend2]), null, " ".repeat(4))}`);

console.log(`friend2 keys: ${JSON.stringify(Array.from(friend2.keys())).split(",").join(", ")}`);
// friend2 keys: ["name", "country", "age"]
