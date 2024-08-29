/* eslint-disable dot-notation */
const friend1 = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend1: ${JSON.stringify(friend1, null, " ".repeat(4))}`);

console.log(`friend1, get total object keys: ${Object.keys(friend1).length}`);
// friend1, get total object keys: 3

console.log(`friend1, get country: ${friend1["country"]}`);
// friend1, get country: Finland

console.log(`friend1, get country: ${friend1?.["country"]}`);
// friend1, get country: Finland

console.log(`friend1, get country: ${friend1.country}`);
// friend1, get country: Finland

console.log(`friend1, get country: ${friend1?.country}`);
// friend1, get country: Finland

// iterate over and get each key-value pair
Object.entries(friend1).forEach(([objectKey, objectValue]) => console.log(`friend1, forEach loop, key: ${objectKey}, value: ${objectValue}`));
// friend1, forEach loop, key: name, value: Alisa
// friend1, forEach loop, key: country, value: Finland
// friend1, forEach loop, key: age, value: 25

// iterate over and get each key-value pair and object iteration/entry index
Object.entries(friend1).forEach(([objectKey, objectValue], objectEntryIndex) => console.log(`friend1, forEach loop, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}`));
// friend1, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
// friend1, forEach loop, object iteration/entry index: 1, key: country, value: Finland
// friend1, forEach loop, object iteration/entry index: 2, key: age, value: 25

friend1["age"] = 27;
console.log(`friend1: ${JSON.stringify(friend1, null, " ".repeat(4))}`);

friend1["gender"] = "Female";
console.log(`friend1: ${JSON.stringify(friend1, null, " ".repeat(4))}`);

friend1.job = "Streamer";
console.log(`friend1: ${JSON.stringify(friend1, null, " ".repeat(4))}`);

delete friend1.country;
console.log(`friend1: ${JSON.stringify(friend1, null, " ".repeat(4))}`);

// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
const deliveryResponseKeyMessage = "message";
const deliveryResponse = {
    [deliveryResponseKeyMessage]: "ok"
};
console.log(`deliveryResponse: ${JSON.stringify(deliveryResponse, null, " ".repeat(4))}`);
const deliveryResponseKeyStatus = "status";
deliveryResponse[deliveryResponseKeyStatus] = 200;
console.log(`deliveryResponse: ${JSON.stringify(deliveryResponse, null, " ".repeat(4))}`);

const friend2 = new Map([
    ["name", "Alisa"],
    ["country", "Finland"],
    ["age", 25]
]);
console.log(`Object.fromEntries([...friend2]): ${JSON.stringify(Object.fromEntries([...friend2]), null, " ".repeat(4))}`);

console.log(`friend2, get total object keys: ${Array.from(friend2.keys()).length}`);
// friend2, get total object keys: 3

console.log(`friend2, get country: ${Object.fromEntries(friend2)["country"]}`);
// friend2, get country: Finland

console.log(`friend2, get country: ${Object.fromEntries(friend2)?.["country"]}`);
// friend2, get country: Finland

console.log(`friend2, get country: ${Object.fromEntries(friend2).country}`);
// friend2, get country: Finland

console.log(`friend2, get country: ${Object.fromEntries(friend2)?.country}`);
// friend2, get country: Finland

console.log(`friend2, get country: ${friend2.get("country")}`);
// friend2, get country: Finland

console.log(`friend2, get country: ${friend2?.get?.("country")}`);
// friend2, get country: Finland

// iterate over and get each key-value pair
Object.entries(Object.fromEntries([...friend2])).forEach(([objectKey, objectValue]) => console.log(`friend2, forEach loop, key: ${objectKey}, value: ${objectValue}`));
// friend2, forEach loop, key: name, value: Alisa
// friend2, forEach loop, key: country, value: Finland
// friend2, forEach loop, key: age, value: 25

// iterate over and get each key-value pair and object iteration/entry index
Object.entries(Object.fromEntries([...friend2])).forEach(([objectKey, objectValue], objectEntryIndex) => console.log(`friend2, forEach loop, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}`));
// friend2, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
// friend2, forEach loop, object iteration/entry index: 1, key: country, value: Finland
// friend2, forEach loop, object iteration/entry index: 2, key: age, value: 25

friend2.set("age", 27);
console.log(`Object.fromEntries([...friend2]): ${JSON.stringify(Object.fromEntries([...friend2]), null, " ".repeat(4))}`);

friend2.set("gender", "Female");
console.log(`Object.fromEntries([...friend2]): ${JSON.stringify(Object.fromEntries([...friend2]), null, " ".repeat(4))}`);

friend2.set("job", "Streamer");
console.log(`Object.fromEntries([...friend2]): ${JSON.stringify(Object.fromEntries([...friend2]), null, " ".repeat(4))}`);

friend2.delete("country");
console.log(`Object.fromEntries([...friend2]): ${JSON.stringify(Object.fromEntries([...friend2]), null, " ".repeat(4))}`);
