/* eslint-disable dot-notation */
const friend = {
    "name": "Alisa",
    "country": "Finland",
    "age": 25
};
console.log(`friend: ${JSON.stringify(friend, null, ' '.repeat(4))}`);

console.log(`friend, get country: ${friend["country"]}`);
// friend, get country: Finland

console.log(`friend, get country: ${friend?.["country"]}`);
// friend, get country: Finland

console.log(`friend, get country: ${friend.country}`);
// friend, get country: Finland

console.log(`friend, get country: ${friend?.country}`);
// friend, get country: Finland

console.log(`friend, get total object keys: ${Object.keys(friend).length}`);
// friend, get total object keys: 3

// iterate over and get each key-value pair
Object.entries(friend).forEach(([objectKey, objectValue]) => console.log(`friend, forEach loop, key: ${objectKey}, value: ${objectValue}`));
// friend, forEach loop, key: name, value: Alisa
// friend, forEach loop, key: country, value: Finland
// friend, forEach loop, key: age, value: 25

// iterate over and get each key-value pair and object iteration/entry index
Object.entries(friend).forEach(([objectKey, objectValue], objectEntryIndex) => console.log(`friend, forEach loop, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}`));
// friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
// friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
// friend, forEach loop, object iteration/entry index: 2, key: age, value: 25
