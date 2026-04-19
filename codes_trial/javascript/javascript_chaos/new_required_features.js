// x. function can explicitly return
const doubleNumber = (aNumber) => {
    if (aNumber === 0) {
        return 0;
    }
    return (aNumber * 2);
};
console.log(doubleNumber(0));
console.log(doubleNumber(2));

// x. can do variadic function
const getSum = (...restArguments) => {
    let resultSum = 0;
    for (let i = 0; (i < restArguments.length); i += 1) {
        resultSum += restArguments[i];
    }
    return resultSum;
};
console.log(getSum(1, 2, 3, 4));