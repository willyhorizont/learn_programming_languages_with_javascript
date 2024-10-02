console.log("\n// Factorial(n) in JavaScript");

const factorialV1 = (anyNumber) => {
    if (typeof anyNumber !== "number") throw new Error("Argument should be a number");
    if (anyNumber < 0) throw new Error("Argument should be >= 0");
    if (anyNumber === 0) return 1;
    let result = 1;
    let i = anyNumber;
    while (true) {
        result *= i;
        if (i <= 1) break;
        i -= 1;
    }
    return result;
};

const factorialV2 = (anyNumber) => {
    if (typeof anyNumber !== "number") throw new Error("Argument should be a number");
    if (anyNumber < 0) throw new Error("Argument should be >= 0");
    if (anyNumber === 0) return 1;
    let result = 1;
    let i = anyNumber;
    while (i >= 1) {
        result *= i;
        i -= 1;
    }
    return result;
};

const factorialV3 = (anyNumber) => {
    if (typeof anyNumber !== "number") throw new Error("Argument should be a number");
    if (anyNumber < 0) throw new Error("Argument should be >= 0");
    if (anyNumber === 0) return 1;
    let result = 1;
    for (let i = anyNumber; i >= 1; i -= 1) {
        result *= i;
    }
    return result;
};

const factorialV4 = (anyNumber) => {
    if (typeof anyNumber !== "number") throw new Error("Argument should be a number");
    if (anyNumber < 0) throw new Error("Argument should be >= 0");
    if (anyNumber === 0) return 1;
    return (anyNumber * factorialV4(anyNumber - 1));
};

console.log(`// using factorial function "factorialV1"`);
console.log(`Factorial(5): ${factorialV1(5)}`);
// Factorial(5): 120

console.log(`// using factorial function "factorialV2"`);
console.log(`Factorial(5): ${factorialV2(5)}`);
// Factorial(5): 120

console.log(`// using factorial function "factorialV3"`);
console.log(`Factorial(5): ${factorialV3(5)}`);
// Factorial(5): 120

console.log(`// using factorial function "factorialV4"`);
console.log(`Factorial(5): ${factorialV4(5)}`);
// Factorial(5): 120
