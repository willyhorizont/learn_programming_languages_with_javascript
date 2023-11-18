/* eslint-disable dot-notation */
const friend = {
    name: "Alisa",
    country: "Finland",
    age: 25
};

console.log(`friend, get country: ${friend["country"]}`);
// friend, get country: Finland

console.log(`friend, get country: ${friend.country}`);
// friend, get country: Finland

console.log(`friend, get country: ${friend?.country}`);
// friend, get country: Finland

// iterate over and get each key-value pair
Object.entries(friend).forEach(([objectKey, objectValue]) => console.log(`friend, foreach loop, key: ${objectKey}, value: ${objectValue}`));
// friend, foreach loop, key: name, value: Alisa
// friend, foreach loop, key: country, value: Finland
// friend, foreach loop, key: age, value: 25

// iterate over and get each key-value pair and iteration/entry index
Object.entries(friend).forEach(([objectKey, objectValue], iterationIndex) => console.log(`friend, foreach loop, index: ${iterationIndex}, key: ${objectKey}, value: ${objectValue}`));
// friend, foreach loop, index: 0, key: name, value: Alisa
// friend, foreach loop, index: 1, key: country, value: Finland
// friend, foreach loop, index: 2, key: age, value: 25
