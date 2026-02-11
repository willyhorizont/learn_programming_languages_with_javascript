import {
    jsonStringify,
} from "./utils.js";

console.log("\n// Array.slice() in JavaScript Array");

const animals = ["Elephant", "Lion", "Tiger", "Bear", "Deer", "Horse", "Zebra", "Camel", "Dog", "Cat", "Gorilla", "Giraffe", "Koala", "Kangaroo", "Panda", "Rabbit"];

console.log(`animals: ${jsonStringify(animals)}`);

console.log(`animals.slice(1): ${jsonStringify(animals.slice(1))}`);
// animals.slice(1): ["Lion", "Tiger", "Bear", "Deer", "Horse", "Zebra", "Camel", "Dog", "Cat", "Gorilla", "Giraffe", "Koala", "Kangaroo", "Panda", "Rabbit"]

console.log(`animals.slice(0, -1): ${jsonStringify(animals.slice(0, -1))}`);
// animals.slice(0, -1): ["Elephant", "Lion", "Tiger", "Bear", "Deer", "Horse", "Zebra", "Camel", "Dog", "Cat", "Gorilla", "Giraffe", "Koala", "Kangaroo", "Panda"]

console.log(`animals.slice(-1): ${jsonStringify(animals.slice(-1))}`);
// animals.slice(-1): ["Rabbit"]

console.log(`animals.slice(2): ${jsonStringify(animals.slice(2))}`);
// animals.slice(2): ["Tiger", "Bear", "Deer", "Horse", "Zebra", "Camel", "Dog", "Cat", "Gorilla", "Giraffe", "Koala", "Kangaroo", "Panda", "Rabbit"]

console.log(`animals.slice(2, 4): ${jsonStringify(animals.slice(2, 4))}`);
// animals.slice(2, 4): ["Tiger", "Bear"]

console.log(`animals.slice(1, 5): ${jsonStringify(animals.slice(1, 5))}`);
// animals.slice(1, 5): ["Lion", "Tiger", "Bear", "Deer"]

console.log(`animals.slice(-2): ${jsonStringify(animals.slice(-2))}`);
// animals.slice(-2): ["Panda", "Rabbit"]

console.log(`animals.slice(2, -1): ${jsonStringify(animals.slice(2, -1))}`);
// animals.slice(2, -1): ["Tiger", "Bear", "Deer", "Horse", "Zebra", "Camel", "Dog", "Cat", "Gorilla", "Giraffe", "Koala", "Kangaroo", "Panda"]

console.log(`animals.slice(): ${jsonStringify(animals.slice())}`);
// animals.slice(): ["Elephant", "Lion", "Tiger", "Bear", "Deer", "Horse", "Zebra", "Camel", "Dog", "Cat", "Gorilla", "Giraffe", "Koala", "Kangaroo", "Panda", "Rabbit"]
