/*
    2. function can explicitly return
*/
const doubleIt = (aNumber) => {
    if (aNumber === 0) {
        return 0;
    }
    return (aNumber * 2);
};
console.log(doubleIt(0));
console.log(doubleIt(2));

/*
    3. can do variadic function
*/
const getSum = (...numbers) => {
    let sum = 0;
    for (let aNumberIndex = 0; aNumberIndex < numbers.length; aNumberIndex += 1) {
        sum += numbers[aNumberIndex];
    }
    return sum;
};
console.log(getSum(1, 2, 3, 4));