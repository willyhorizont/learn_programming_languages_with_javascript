console.log('\n// Factorial(n) in JavaScript');

const factorialV1 = (number) => {
    if (typeof number !== "number") throw new Error("Argument should be a number");
    if (number < 0) throw new Error("Argument should be >= 0");
    if (number === 0) return 1;
    let result = 1;
    let i = number;
    while (true) {
        result *= i;
        if (i <= 1) break;
        i -= 1;
    }
    return result;
};

const factorialV2 = (number) => {
    if (typeof number !== "number") throw new Error("Argument should be a number");
    if (number < 0) throw new Error("Argument should be >= 0");
    if (number === 0) return 1;
    let result = 1;
    let i = number;
    while (i >= 1) {
        result *= i;
        i -= 1;
    }
    return result;
};

const factorialV3 = (number) => {
    if (typeof number !== "number") throw new Error("Argument should be a number");
    if (number < 0) throw new Error("Argument should be >= 0");
    if (number === 0) return 1;
    let result = 1;
    for (let i = number; i >= 1; i -= 1) {
        result *= i;
    }
    return result;
};

const factorialV4 = (number) => {
    if (typeof number !== "number") throw new Error("Argument should be a number");
    if (number < 0) throw new Error("Argument should be >= 0");
    if (number === 0) return 1;
    return (number * factorialV4(number - 1));
};

console.log('// using factorial function "factorialV1"');
console.log(`Factorial(5): ${factorialV1(5)}`);
// Factorial(5): 120

console.log('// using factorial function "factorialV2"');
console.log(`Factorial(5): ${factorialV2(5)}`);
// Factorial(5): 120

console.log('// using factorial function "factorialV3"');
console.log(`Factorial(5): ${factorialV3(5)}`);
// Factorial(5): 120

console.log('// using factorial function "factorialV4"');
console.log(`Factorial(5): ${factorialV4(5)}`);
// Factorial(5): 120
