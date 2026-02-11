import {
    rangeInclusive,
    iterateList,
} from "./utils.js";

// while loop

{
    let i = 1;
    while (true) {
        if (i === 2) {
            if (i > 5) break;
            i += 1;
            continue;
        }
        if (i > 5) break;
        console.log(`while loop v1, i is ${i}`);
        i += 1;
    }
}

{
    let i = 1;
    while (i <= 5) {
        if (i === 2) {
            i += 1;
            continue;
        }
        console.log(`while loop v2, i is ${i}`);
        i += 1;
    }
}

// for loop

for (let i = 1; i <= 10; i += 1) {
    if (i > 5) break;
    if (i === 2) continue;
    console.log(`for loop, i is ${i}`);
}

// forEach loop

Array.from(rangeInclusive(1, 10)).forEach((i) => {
    if (i > 5) return;
    if (i === 2) return;
    console.log(`forEach loop v1 ascending, i is ${i}`);
});

Array.from(rangeInclusive(10, 1)).forEach((i) => {
    if (i <= 5) return;
    if (i === 9) return;
    console.log(`forEach loop v1 descending, i is ${i}`);
});

iterateList(rangeInclusive(1, 10), (i) => {
    if (i > 5) return;
    if (i === 2) return;
    console.log(`iterateList ascending, i is ${i}`);
});

iterateList(rangeInclusive(10, 1), (i) => {
    if (i <= 5) return;
    if (i === 9) return;
    console.log(`iterateList descending, i is ${i}`);
});

loop(1, 10)((i) => {
    if (i > 5) return;
    if (i === 2) return;
    console.log(`loop ascending, i is ${i}`);
});

loop(10, 1)((i) => {
    if (i <= 5) return;
    if (i === 9) return;
    console.log(`loop descending, i is ${i}`);
});

// recursive loop | recursion | loop’s cool sibling

(() => {
    const recursiveLoop = (i = 1) => {
        if (i > 10) return;
        if (i > 5) return;
        if (i === 2) return recursiveLoop(i + 1);
        console.log(`recursive loop ascending, i is ${i}`);
        return recursiveLoop(i + 1);
    };
    recursiveLoop();
})();

(() => {
    const recursiveLoop = (i = 10) => {
        if (i < 1) return;
        if (i <= 5) return;
        if (i === 9) return recursiveLoop(i - 1);
        console.log(`recursive loop descending, i is ${i}`);
        return recursiveLoop(i - 1);
    };
    recursiveLoop();
})();
