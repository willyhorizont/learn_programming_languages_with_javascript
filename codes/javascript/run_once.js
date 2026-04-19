import {
    runOnce,
    printAndReturn,
    jsonStringify,
} from "./utils.js";

const runOnceV1 = (() => {
    const keySet = new Set();
    return (anyStringKey = "something", callbackFunction = (() => undefined)) => {
        if (keySet.has(anyStringKey) === true) return;
        keySet.add(anyStringKey);
        return callbackFunction();
    };
})();

const runOnceV2 = runOnce;

const animals = ["Elephant", "Lion", "Tiger", "Bear", "Deer", "Horse", "Zebra", "Camel", "Dog", "Cat", "Gorilla", "Giraffe", "Koala", "Kangaroo", "Panda", "Rabbit"];

animals.forEach((animal) => {
    runOnceV1("animal", () => console.log(`only print first animal: ${animal}`));
});

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

const numbersLabeledAa1 = numbers.map((anyNumber) => ({ [anyNumber]: (((runOnceV1("numberAa", () => [console.log(`@numberAa@runOnceV1: only print first number: ${anyNumber}`), anyNumber].at(-1)) % 2) === 0) ? "even" : "odd") }));
console.log(`labeled numbers: ${jsonStringify(numbersLabeledAa1, { pretty: true })}`);

const numbersLabeledBb1 = numbers.map((anyNumber) => ({ [anyNumber]: (((runOnceV1("numberBb", () => printAndReturn(anyNumber, { key: "number", title: "@numberBb@runOnceV1: only print first number" })) % 2) === 0) ? "even" : "odd") }));
console.log(`labeled numbers: ${jsonStringify(numbersLabeledBb1, { pretty: true })}`);

const numbersLabeledAa2 = numbers.map((anyNumber) => ({ [anyNumber]: (((runOnceV2("numberAa", () => [console.log(`@numberAa@runOnceV2: only print first number: ${anyNumber}`), anyNumber].at(-1)) % 2) === 0) ? "even" : "odd") }));
console.log(`labeled numbers: ${jsonStringify(numbersLabeledAa2, { pretty: true })}`);

const numbersLabeledBb2 = numbers.map((anyNumber) => ({ [anyNumber]: (((runOnceV2("numberBb", () => printAndReturn(anyNumber, { key: "number", title: "@numberBb@runOnceV2: only print first number" })) % 2) === 0) ? "even" : "odd") }));
console.log(`labeled numbers: ${jsonStringify(numbersLabeledBb2, { pretty: true })}`);
