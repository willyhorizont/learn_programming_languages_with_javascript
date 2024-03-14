console.log('\n// Spread Syntax (...)');

const fruits = ["Mango", "Melon", "Banana"];
console.log(`fruits: ${JSON.stringify(fruits).split(',').join(', ')}`);

const vegetables = ["Carrot", "Tomato"];
console.log(`vegetables: ${JSON.stringify(vegetables).split(',').join(', ')}`);

const countryCapitalsInAsia = {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo"
};
console.log(`countryCapitalsInAsia: ${JSON.stringify(countryCapitalsInAsia, null, ' '.repeat(4))}`);

const countryCapitalsInEurope = {
    "France": "Paris",
    "England": "London"
};
console.log(`countryCapitalsInEurope: ${JSON.stringify(countryCapitalsInEurope, null, ' '.repeat(4))}`);

console.log("\n// [...array1, ...array2]:\n");

const combination1 = [...fruits, ...vegetables];
console.log(`combination1: ${JSON.stringify(combination1, null, ' '.repeat(4))}`);
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

const combination2 = [...fruits, ...["Cucumber", "Onion"]];
console.log(`combination2: ${JSON.stringify(combination2, null, ' '.repeat(4))}`);
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Onion"
// ]

console.log("\n// { ...object1, ...object2 }:\n");

const combination3 = { ...countryCapitalsInAsia, ...countryCapitalsInEurope };
console.log(`combination3: ${JSON.stringify(combination3, null, ' '.repeat(4))}`);
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

const combination4 = { ...countryCapitalsInAsia, ...{ "Germany": "Berlin", "Italy": "Rome" } };
console.log(`combination4: ${JSON.stringify(combination4, null, ' '.repeat(4))}`);
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

console.log("\n// [...array1, array2]:\n");

const combination5 = [...fruits, vegetables];
console.log(`combination5: ${JSON.stringify(combination5, null, ' '.repeat(4))}`);
// combination5: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Carrot",
//         "Tomato"
//     ]
// ]

const combination6 = [...fruits, ["Cucumber", "Onion"]];
console.log(`combination6: ${JSON.stringify(combination6, null, ' '.repeat(4))}`);
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Onion"
//     ]
// ]

console.log("\n// [...array1, object1]:\n");

const combination7 = [...fruits, countryCapitalsInAsia];
console.log(`combination7: ${JSON.stringify(combination7, null, ' '.repeat(4))}`);
// combination7: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Thailand": "Bangkok",
//         "China": "Beijing",
//         "Japan": "Tokyo"
//     }
// ]

const combination8 = [...fruits, { "Germany": "Berlin", "Italy": "Rome" }];
console.log(`combination8: ${JSON.stringify(combination8, null, ' '.repeat(4))}`);
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

console.log("\n// { ...object1, object2 }:\n");

const combination9 = { ...countryCapitalsInAsia, countryCapitalsInEurope };
console.log(`combination9: ${JSON.stringify(combination9, null, ' '.repeat(4))}`);
// combination9: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "countryCapitalsInEurope" : {
//       "France" : "Paris",
//       "England" : "London"
//    }
// }

const combination10 = { ...countryCapitalsInAsia, "countryCapitalsInEurope": { "Germany": "Berlin", "Italy": "Rome" } };
console.log(`combination10: ${JSON.stringify(combination10, null, ' '.repeat(4))}`);
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "countryCapitalsInEurope": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

console.log("\n// { ...object1, array2 }:\n");

const combination11 = { ...countryCapitalsInAsia, vegetables };
console.log(`combination11: ${JSON.stringify(combination11, null, ' '.repeat(4))}`);
// combination11: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Carrot",
//         "Tomato"
//     ]
// }

const combination12 = { ...countryCapitalsInAsia, "vegetables": ["Cucumber", "Onion"] };
console.log(`combination12: ${JSON.stringify(combination12, null, ' '.repeat(4))}`);
// combination12: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Cucumber",
//         "Onion"
//     ]
// }

console.log("\n// { ...object1, ...array2 }:\n");

const combination13 = { ...countryCapitalsInAsia, ...vegetables };
console.log(`combination13: ${JSON.stringify(combination13, null, ' '.repeat(4))}`);
// combination13: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Carrot",
//    "1" : "Tomato"
// }

const combination14 = { ...countryCapitalsInAsia, ...["Cucumber", "Onion"] };
console.log(`combination14: ${JSON.stringify(combination14, null, ' '.repeat(4))}`);
// combination14: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Cucumber",
//    "1" : "Onion"
// }

// console.log("\n// [...array1, ...object1]: // this combination throw an error\n");

// this combination throw an error
// const combinationError1 = [...fruits, ...countryCapitalsInAsia];
// console.log(`combinationError1: ${JSON.stringify(combinationError1, null, ' '.repeat(4))}`);

// this combination throw an error
// const combinationError2 = [...fruits, ...{ "Germany": "Berlin", "Italy": "Rome" }];
// console.log(`combinationError2: ${JSON.stringify(combinationError2, null, ' '.repeat(4))}`);
