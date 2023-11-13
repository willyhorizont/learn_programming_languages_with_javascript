// while loop

let i1 = 1;
while (true) {
    if (i1 === 2) {
        i1 += 1;
        if (i1 > 5) break;
        continue;
    }
    console.log(`while loop v1, i1 is ${i1}`);
    i1 += 1;
    if (i1 > 5) break;
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
    console.log(`for loop, i3 is ${i3}`);
}
