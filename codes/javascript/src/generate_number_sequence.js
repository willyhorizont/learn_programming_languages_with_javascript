const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

const generateNumberSequence = (startNumber, stopNumber) => {
    if (stopNumber > startNumber) {
        const numberSequenceArrayAscending = [];
        for (let aNumber = startNumber; (aNumber <= stopNumber); aNumber += 1) {
            numberSequenceArrayAscending.push(aNumber);
        }
        return numberSequenceArrayAscending;
    }
    if (startNumber > stopNumber) {
        const numberSequenceArrayDescending = [];
        for (let aNumber = startNumber; (aNumber >= stopNumber); aNumber -= 1) {
            numberSequenceArrayDescending.push(aNumber);
        }
        return numberSequenceArrayDescending;
    }
    return [0];
};

console.log(`generateNumberSequence(0, 9): ${jsonStringify(generateNumberSequence(0, 9))}`);
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
console.log(`generateNumberSequence(1, 10): ${jsonStringify(generateNumberSequence(1, 10))}`);
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console.log(`generateNumberSequence(10, 1): ${jsonStringify(generateNumberSequence(10, 1))}`);
// [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
console.log(`generateNumberSequence(9, 0): ${jsonStringify(generateNumberSequence(9, 0))}`);
// [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
