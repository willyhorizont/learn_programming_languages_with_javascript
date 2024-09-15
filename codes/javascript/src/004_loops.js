const generateNumberSequenceArray = (startNumber, stopNumber) => {
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

// while loop

(() => {
    let i = 1;
    while (true) {
        if (i === 2) {
            if (i >= 5) break;
            i += 1;
            continue;
        }
        console.log(`while loop v1, i is ${i}`);
        if (i >= 5) break;
        i += 1;
    }
})();

(() => {
    let i = 1;
    while (i <= 5) {
        if (i === 2) {
            i += 1;
            continue;
        }
        console.log(`while loop v2, i is ${i}`);
        i += 1;
    }
})();

// for loop

for (let i = 1; i <= 10; i += 1) {
    if (i > 5) break;
    if (i === 2) continue;
    console.log(`for loop, i is ${i}`);
}

// forEach loop

generateNumberSequenceArray(1, 10).forEach((i) => {
    if (i > 5) return;
    if (i === 2) return;
    console.log(`forEach loop v1 ascending, i is ${i}`);
});

generateNumberSequenceArray(10, 1).forEach((i) => {
    if (i <= 5) return;
    if (i === 9) return;
    console.log(`forEach loop v1 descending, i is ${i}`);
});

generateNumberSequenceArray(1, 10).forEach((i) => {
    if (i > 5) return;
    if (i === 2) return;
    console.log(`forEach loop v2 ascending, i is ${i}`);
});

generateNumberSequenceArray(10, 1).forEach((i) => {
    if (i <= 5) return;
    if (i === 9) return;
    console.log(`forEach loop v2 descending, i is ${i}`);
});
