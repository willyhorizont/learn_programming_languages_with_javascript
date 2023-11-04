console.log('\n// Spread Syntax');

const fruits = ["Mango", "Melon", "Banana"];
console.log(`fruits: ${JSON.stringify(fruits).split(',').join(', ')}`);

const vegetables = ["Carrot", "Tomato"];
console.log(`vegetables: ${JSON.stringify(vegetables).split(',').join(', ')}`);

const countryCapitalsInEurope = {
    "France": "Paris",
    "England": "London"
};
console.log(`country capitals in europe: ${JSON.stringify(countryCapitalsInEurope, null, ' '.repeat(4))}`);

const countryCapitalsInAsia = {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo",
};
console.log(`country capitals in asia: ${JSON.stringify(countryCapitalsInAsia, null, ' '.repeat(4))}`);

const combination1 = [...fruits, ...vegetables];
console.log(`combination1: ${JSON.stringify(combination1, null, ' '.repeat(4))}`);
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

const combination2 = { ...countryCapitalsInAsia, ...countryCapitalsInEurope };
console.log(`combination2: ${JSON.stringify(combination2, null, ' '.repeat(4))}`);
// combination2: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

const combination3 = [...fruits, vegetables];
console.log(`combination3: ${JSON.stringify(combination3, null, ' '.repeat(4))}`);
// combination3: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Carrot",
//         "Tomato"
//     ]
// ]

const combination4 = [...fruits, countryCapitalsInAsia];
console.log(`combination4: ${JSON.stringify(combination4, null, ' '.repeat(4))}`);
// combination4: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Thailand": "Bangkok",
//         "China": "Beijing",
//         "Japan": "Tokyo"
//     }
// ]

const combination5 = { ...countryCapitalsInAsia, ...vegetables };
console.log(`combination5: ${JSON.stringify(combination5, null, ' '.repeat(4))}`);
// combination5: {
//     "0": "Carrot",
//     "1": "Tomato",
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo"
// }

const combination6 = { ...countryCapitalsInAsia, countryCapitalsInEurope };
console.log(`combination6: ${JSON.stringify(combination6, null, ' '.repeat(4))}`);
// combination6: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "countryCapitalsInEurope": {
//         "France": "Paris",
//         "England": "London"
//     }
// }

const combination7 = { ...countryCapitalsInAsia, vegetables };
console.log(`combination7: ${JSON.stringify(combination7, null, ' '.repeat(4))}`);
// combination7: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Carrot",
//         "Tomato"
//     ]
// }
