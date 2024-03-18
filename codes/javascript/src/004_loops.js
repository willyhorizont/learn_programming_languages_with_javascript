// while loop

let i1 = 1;
while (true) {
    if (i1 === 2) {
        if (i1 >= 5) break;
        i1 += 1;
        continue;
    }
    console.log(`while loop v1, i1 is ${i1}`);
    if (i1 >= 5) break;
    i1 += 1;
}

let i2 = 1;
while (i2 <= 5) {
    if (i2 === 2) {
        i2 += 1;
        continue;
    }
    console.log(`while loop v2, i2 is ${i2}`);
    i2 += 1;
}

// for loop

for (let i3 = 1; i3 <= 5; i3 += 1) {
    if (i3 === 2) continue;
    console.log(`for loop v1, i3 is ${i3}`);
}

// foreach loop

Array.from(Array(5 + 1).keys()).slice(1).forEach((i4) => {
    if (i4 === 2) return;
    console.log(`foreach loop v1 ascending, i4 is ${i4}`);
});

Array.from(Array(5 + 1).keys()).slice(1).reverse().forEach((i5) => {
    if (i5 === 2) return;
    console.log(`foreach loop v1 descending, i5 is ${i5}`);
});

[...Array(5 + 1).keys()].slice(1).forEach((i6) => {
    if (i6 === 2) return;
    console.log(`foreach loop v2 ascending, i6 is ${i6}`);
});

[...Array(5 + 1).keys()].slice(1).reverse().forEach((i7) => {
    if (i7 === 2) return;
    console.log(`foreach loop v2 descending, i7 is ${i7}`);
});
