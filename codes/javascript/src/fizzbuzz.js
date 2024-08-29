console.log("\n// FizzBuzz(n) in JavaScript");

const fizzbuzzV1 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    let number = 1;
    while (true) {
        if (result === "") {
            result = `${number}`;
            if (number >= stopNumber) break;
            number += 1;
            continue;
        }
        if (((number % 3) === 0) && ((number % 5) === 0)) {
            result = `${result}, FizzBuzz`;
            if (number >= stopNumber) break;
            number += 1;
            continue;
        }
        if ((number % 3) === 0) {
            result = `${result}, Fizz`;
            if (number >= stopNumber) break;
            number += 1;
            continue;
        }
        if ((number % 5) === 0) {
            result = `${result}, Buzz`;
            if (number >= stopNumber) break;
            number += 1;
            continue;
        }
        result = `${result}, ${number}`;
        if (number >= stopNumber) break;
        number += 1;
    }
    return result;
};

const fizzbuzzV2 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    let number = 1;
    while (number <= stopNumber) {
        if (result === "") {
            result = `${number}`;
            number += 1;
            continue;
        }
        if (((number % 3) === 0) && ((number % 5) === 0)) {
            result = `${result}, FizzBuzz`;
            number += 1;
            continue;
        }
        if ((number % 3) === 0) {
            result = `${result}, Fizz`;
            number += 1;
            continue;
        }
        if ((number % 5) === 0) {
            result = `${result}, Buzz`;
            number += 1;
            continue;
        }
        result = `${result}, ${number}`;
        number += 1;
    }
    return result;
};

const fizzbuzzV3 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    let number = 1;
    while (true) {
        if (result === "") {
            result = `${number}`;
        } else if (((number % 3) === 0) && ((number % 5) === 0)) {
            result = `${result}, FizzBuzz`;
        } else if ((number % 3) === 0) {
            result = `${result}, Fizz`;
        } else if ((number % 5) === 0) {
            result = `${result}, Buzz`;
        } else {
            result = `${result}, ${number}`;
        }
        if (number >= stopNumber) break;
        number += 1;
    }
    return result;
};

const fizzbuzzV4 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    let number = 1;
    while (number <= stopNumber) {
        if (result === "") {
            result = `${number}`;
        } else if (((number % 3) === 0) && ((number % 5) === 0)) {
            result = `${result}, FizzBuzz`;
        } else if ((number % 3) === 0) {
            result = `${result}, Fizz`;
        } else if ((number % 5) === 0) {
            result = `${result}, Buzz`;
        } else {
            result = `${result}, ${number}`;
        }
        number += 1;
    }
    return result;
};

const fizzbuzzV5 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    let number = 1;
    while (true) {
        result = ((result === "")
            ? `${number}`
            : ((((number % 3) === 0) && ((number % 5) === 0))
                ? `${result}, FizzBuzz`
                : (((number % 3) === 0)
                    ? `${result}, Fizz`
                    : (((number % 5) === 0)
                        ? `${result}, Buzz`
                        : `${result}, ${number}`
                    )
                )
            )
        );
        if (number >= stopNumber) break;
        number += 1;
    }
    return result;
};

const fizzbuzzV6 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    let number = 1;
    while (number <= stopNumber) {
        result = ((result === "")
            ? `${number}`
            : ((((number % 3) === 0) && ((number % 5) === 0))
                ? `${result}, FizzBuzz`
                : (((number % 3) === 0)
                    ? `${result}, Fizz`
                    : (((number % 5) === 0)
                        ? `${result}, Buzz`
                        : `${result}, ${number}`
                    )
                )
            )
        );
        number += 1;
    }
    return result;
};

const fizzbuzzV7 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    let number = 1;
    while (true) {
        result = ((result === "") ? `${number}` : ((((number % 3) === 0) && ((number % 5) === 0)) ? `${result}, FizzBuzz` : (((number % 3) === 0) ? `${result}, Fizz` : (((number % 5) === 0) ? `${result}, Buzz` : `${result}, ${number}`))));
        if (number >= stopNumber) break;
        number += 1;
    }
    return result;
};

const fizzbuzzV8 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    let number = 1;
    while (number <= stopNumber) {
        result = ((result === "") ? `${number}` : ((((number % 3) === 0) && ((number % 5) === 0)) ? `${result}, FizzBuzz` : (((number % 3) === 0) ? `${result}, Fizz` : (((number % 5) === 0) ? `${result}, Buzz` : `${result}, ${number}`))));
        number += 1;
    }
    return result;
};

const fizzbuzzV9 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    for (let number = 1; number <= stopNumber; number += 1) {
        if (result === "") {
            result = `${number}`;
            continue;
        }
        if (((number % 3) === 0) && ((number % 5) === 0)) {
            result = `${result}, FizzBuzz`;
            continue;
        }
        if ((number % 3) === 0) {
            result = `${result}, Fizz`;
            continue;
        }
        if ((number % 5) === 0) {
            result = `${result}, Buzz`;
            continue;
        }
        result = `${result}, ${number}`;
    }
    return result;
};

const fizzbuzzV10 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    for (let number = 1; number <= stopNumber; number += 1) {
        if (result === "") {
            result = `${number}`;
        } else if (((number % 3) === 0) && ((number % 5) === 0)) {
            result = `${result}, FizzBuzz`;
        } else if ((number % 3) === 0) {
            result = `${result}, Fizz`;
        } else if ((number % 5) === 0) {
            result = `${result}, Buzz`;
        } else {
            result = `${result}, ${number}`;
        }
    }
    return result;
};

const fizzbuzzV11 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    for (let number = 1; number <= stopNumber; number += 1) {
        result = ((result === "")
            ? `${number}`
            : ((((number % 3) === 0) && ((number % 5) === 0))
                ? `${result}, FizzBuzz`
                : (((number % 3) === 0)
                    ? `${result}, Fizz`
                    : (((number % 5) === 0)
                        ? `${result}, Buzz`
                        : `${result}, ${number}`
                    )
                )
            )
        );
    }
    return result;
};

const fizzbuzzV12 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    let result = "";
    for (let number = 1; number <= stopNumber; number += 1) {
        result = ((result === "") ? `${number}` : ((((number % 3) === 0) && ((number % 5) === 0)) ? `${result}, FizzBuzz` : (((number % 3) === 0) ? `${result}, Fizz` : (((number % 5) === 0) ? `${result}, Buzz` : `${result}, ${number}`))));
    }
    return result;
};

const fizzbuzzV13 = (stopNumber) => {
    if (typeof stopNumber !== "number") throw new Error("Argument should be a number");
    if (stopNumber < 1) throw new Error("Argument should be > 0");
    return Array.from(Array(stopNumber + 1).keys()).slice(1).reduce((currentResult, currentNumber) => ((currentResult === "") ? `${currentNumber}` : ((((currentNumber % 3) === 0) && ((currentNumber % 5) === 0)) ? `${currentResult}, FizzBuzz` : (((currentNumber % 3) === 0) ? `${currentResult}, Fizz` : (((currentNumber % 5) === 0) ? `${currentResult}, Buzz` : `${currentResult}, ${currentNumber}`)))), "");
};

console.log("// using fizzbuzz function \"fizzbuzzV1\"");
console.log(`FizzBuzz(36): ${fizzbuzzV1(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV2\"");
console.log(`FizzBuzz(36): ${fizzbuzzV2(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV3\"");
console.log(`FizzBuzz(36): ${fizzbuzzV3(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV4\"");
console.log(`FizzBuzz(36): ${fizzbuzzV4(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV5\"");
console.log(`FizzBuzz(36): ${fizzbuzzV5(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV6\"");
console.log(`FizzBuzz(36): ${fizzbuzzV6(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV7\"");
console.log(`FizzBuzz(36): ${fizzbuzzV7(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV8\"");
console.log(`FizzBuzz(36): ${fizzbuzzV8(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV9\"");
console.log(`FizzBuzz(36): ${fizzbuzzV9(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV10\"");
console.log(`FizzBuzz(36): ${fizzbuzzV10(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV11\"");
console.log(`FizzBuzz(36): ${fizzbuzzV11(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV12\"");
console.log(`FizzBuzz(36): ${fizzbuzzV12(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

console.log("// using fizzbuzz function \"fizzbuzzV13\"");
console.log(`FizzBuzz(36): ${fizzbuzzV13(36)}`);
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
