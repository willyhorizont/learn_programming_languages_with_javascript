console.log('\n// Factorial(n) in JavaScript');

const factorialV1 = (number) => {
    if (typeof number !== "number") return "argument should be a number";
    if ((number > 1) === false) return 1;
    let result = 1;
    for (let i = number; i >= 1; i -= 1) {
        result *= i;
    }
    return result;
};

const factorialV2 = (number) => {
    if (typeof number !== "number") return "argument should be a number";
    if ((number > 1) === false) return 1;
    let result = 1;
    let i = number;
    while (true) {
        result *= i;
        i -= 1;
        if (i <= 0) break;
    }
    return result;
};

const factorialV3 = (number) => {
    if (typeof number !== "number") return "argument should be a number";
    if ((number > 1) === false) return 1;
    let result = 1;
    let i = number;
    while (i >= 1) {
        result *= i;
        i -= 1;
    }
    return result;
};

console.log('// using factorial function "factorialV1"');
console.log("Factorial(5):", factorialV1(5));
// Factorial(5): 120

console.log('// using factorial function "factorialV2"');
console.log("Factorial(5):", factorialV2(5));
// Factorial(5): 120

console.log('// using factorial function "factorialV3"');
console.log("Factorial(5):", factorialV3(5));
// Factorial(5): 120
