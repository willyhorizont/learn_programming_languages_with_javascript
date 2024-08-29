console.log("\n// Object.fromEntries() in JavaScript");

const friendEntry = [["name", "Alisa"], ["country", "Finland"], ["age", 25]];
console.log(`Object.fromEntries(friendEntry): ${JSON.stringify(Object.fromEntries(friendEntry), null, " ".repeat(4))}`);
