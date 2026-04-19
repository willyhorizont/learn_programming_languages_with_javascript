import {
    jsonStringify,
    rangeInclusive,
} from "./utils.js";

console.log(`Array.from(rangeInclusive(0, 9)):
${jsonStringify(Array.from(rangeInclusive(0, 9)))}`);
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
console.log(`Array.from(rangeInclusive(1, 10)):
${jsonStringify(Array.from(rangeInclusive(1, 10)))}`);
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console.log(`Array.from(rangeInclusive(10, 1)):
${jsonStringify(Array.from(rangeInclusive(10, 1)))}`);
// [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
console.log(`Array.from(rangeInclusive(9, 0)):
${jsonStringify(Array.from(rangeInclusive(9, 0)))}`);
// [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
