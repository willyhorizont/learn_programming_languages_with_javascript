const friend = {
    name: "Alisa",
    country: "Finland",
    age: 25
};

// iterate over and get each key-value pair
Object.entries(friend).forEach(([objectKey, objectValue]) => console.log(`friend, foreach loop, key: ${objectKey}, value: ${objectValue}`));
// friend, foreach loop, key: name, value: Alisa
// friend, foreach loop, key: country, value: Finland
// friend, foreach loop, key: age, value: 25
