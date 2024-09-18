/* eslint-disable dot-notation */

const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// JavaScript Object");

const friend1 = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

console.log(`friend1, get total object keys: ${Object.keys(friend1).length}`);
// friend1, get total object keys: 3

console.log(`friend1, get country: ${jsonStringify(friend1["country"])}`);
// friend1, get country: "Finland"

console.log(`friend1, get country: ${jsonStringify(friend1?.["country"])}`);
// friend1, get country: "Finland"

console.log(`friend1, get country: ${jsonStringify(friend1.country)}`);
// friend1, get country: "Finland"

console.log(`friend1, get country: ${jsonStringify(friend1?.country)}`);
// friend1, get country: "Finland"

// iterate over and print each key-value pair and object entry index
Object.entries(friend1).forEach(([objectKey, objectValue], objectEntryIndex) => console.log(`friend1, for each loop, object entry index: ${objectEntryIndex}, key: ${jsonStringify(objectKey)}, value: ${jsonStringify(objectValue)}`));
// friend1, for each loop, object entry index: 0, key: "name", value: "Alisa"
// friend1, for each loop, object entry index: 1, key: "country", value: "Finland"
// friend1, for each loop, object entry index: 2, key: "age", value: 25

friend1["age"] = 27;
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

friend1["gender"] = "Female";
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

friend1.job = "Streamer";
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

delete friend1.country;
console.log(`friend1: ${jsonStringify(friend1, { pretty: true })}`);

// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
const deliveryResponseKeyMessage = "message";
const deliveryResponse = {
    [deliveryResponseKeyMessage]: "ok"
};
console.log(`deliveryResponse: ${jsonStringify(deliveryResponse, { pretty: true })}`);
const deliveryResponseKeyStatus = "status";
deliveryResponse[deliveryResponseKeyStatus] = 200;
console.log(`deliveryResponse: ${jsonStringify(deliveryResponse, { pretty: true })}`);

const friend2 = new Map([
    ["name", "Alisa"],
    ["country", "Finland"],
    ["age", 25]
]);
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

console.log(`friend2, get total object keys: ${Array.from(friend2.keys()).length}`);
// friend2, get total object keys: 3

console.log(`friend2, get country: ${jsonStringify(Object.fromEntries(friend2)["country"])}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(Object.fromEntries(friend2)?.["country"])}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(Object.fromEntries(friend2).country)}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(Object.fromEntries(friend2)?.country)}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(friend2.get("country"))}`);
// friend2, get country: "Finland"

console.log(`friend2, get country: ${jsonStringify(friend2?.get?.("country"))}`);
// friend2, get country: "Finland"

// iterate over and print each key-value pair and object entry index
Object.entries(Object.fromEntries([...friend2])).forEach(([objectKey, objectValue], objectEntryIndex) => console.log(`friend2, for each loop, object entry index: ${objectEntryIndex}, key: ${jsonStringify(objectKey)}, value: ${jsonStringify(objectValue)}`));
// friend2, for each loop, object entry index: 0, key: "name", value: "Alisa"
// friend2, for each loop, object entry index: 1, key: "country", value: "Finland"
// friend2, for each loop, object entry index: 2, key: "age", value: 25

friend2.set("age", 27);
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

friend2.set("gender", "Female");
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

friend2.set("job", "Streamer");
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);

friend2.delete("country");
console.log(`friend2: ${jsonStringify(Object.fromEntries([...friend2]), { pretty: true })}`);
