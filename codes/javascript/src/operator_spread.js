console.log('\n// Spread Syntax in JavaScript Array');

const myFruitsInFridge = ["apple", "mango", "orange"];
console.log(`my fruits in fridge: ${JSON.stringify(myFruitsInFridge).split(',').join(', ')}`);

const myFruitsFromGroceryStore = ["melon", "banana"];
console.log(`my fruits from grocery store: ${JSON.stringify(myFruitsFromGroceryStore).split(',').join(', ')}`);

const myFruits = [...myFruitsInFridge, ...myFruitsFromGroceryStore];
console.log(`my fruits: ${JSON.stringify(myFruits).split(',').join(', ')}`);
// my fruits: ["apple", "mango", "orange", "melon", "banana"]

console.log('\n// Spread Syntax in JavaScript Array of Objects');

const generalCar = {
    "wheels": 4,
    "tires": 4
};
console.log(`general car: ${JSON.stringify(generalCar, null, ' '.repeat(4))}`);

const minivanCar = { ...generalCar, "doors": 4 };
console.log(`minivan car: ${JSON.stringify(minivanCar, null, ' '.repeat(4))}`);
// minivan car: {
//     "wheels": 4,
//     "tires": 4,
//     "doors": 4
// }

const superCar = { ...generalCar, "doors": 2 };
console.log(`super car: ${JSON.stringify(superCar, null, ' '.repeat(4))}`);
// super car: {
//     "wheels": 4,
//     "tires": 4,
//     "doors": 2
// }
