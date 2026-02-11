import {
    AnyType,
    getType,
} from "./utils.js";

console.log("// Pipe Function in JavaScript");

const curry = (anyFunction, ...restArguments) => (currentResult) => anyFunction(currentResult, ...restArguments);

const pipe = (...restArguments) => {
    let pipeLastResult = undefined;
    const pipeResult = restArguments.reduce((currentResult, currentArgument) => {
        pipeLastResult = currentResult;
        const currentResultType = getType(currentResult);
        if ((currentResultType === AnyType["Undefined"]) || (currentResultType === AnyType["Null"])) return currentArgument;
        if (getType(currentArgument) === AnyType["Function"]) return currentArgument(currentResult);
        return undefined;
    }, undefined);
    if (getType(pipeResult) === AnyType["Function"]) return pipeResult(pipeLastResult);
    return pipeResult;
};

const plus25 = (anyNumber) => (anyNumber + 25);

const multiplyBy10 = (anyNumber) => (anyNumber * 10);

const plus = (a, b) => (a + b);

const multiply = (a, b) => (a * b);

console.log(multiplyBy10(plus25(17))); // read from inside to outside

pipe(17, plus25, multiplyBy10, console.log); // read from left to right

console.log(pipe(17, plus25, multiplyBy10)); // read from left to right

console.log(plus(multiply(plus25(5), 10), 100)); // read from inside to outside

pipe(5, plus25, (x) => multiply(x, 10), (x) => plus(x, 100), console.log); // read from left to right

console.log(pipe(5, plus25, (x) => multiply(x, 10), (x) => plus(x, 100))); // read from left to right

pipe(5, plus25, curry(multiply, 10), curry(plus, 100), console.log); // read from left to right

console.log(pipe(5, plus25, curry(multiply, 10), curry(plus, 100))); // read from left to right
