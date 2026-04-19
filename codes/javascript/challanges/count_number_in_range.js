const getNumberCountInRangeAsNumeric = (numberToCount, startNumber, stopNumber, callback = ((numberCount, ...restArguments) => numberCount)) => (Array.from({ length: (Math.abs(stopNumber - startNumber) + 1) }, (_, i) => ((startNumber < stopNumber) ? (startNumber + i) : ((startNumber > stopNumber) ? (startNumber - i) : startNumber))).reduce((total, number) => (total + callback((number.toString().split("").reduce((count, digit) => (count + ((digit === numberToCount.toString()) ? 1 : 0)), 0)), number)), 0));
console.log(getNumberCountInRangeAsNumeric(8, 1, 100)); // 20

const getNumberCountInRangeGroupAsString = (numberToCount, startNumber, stopNumber) => {
    let numberCountInRangeGroupAsString = "{ ";
    getNumberCountInRangeAsNumeric(numberToCount, startNumber, stopNumber, (numberCount, number) => {
        if (numberCount > 0) {
            numberCountInRangeGroupAsString = ((numberCountInRangeGroupAsString !== "{ ") ? `${numberCountInRangeGroupAsString}, "${number.toString()}": ${numberCount}` : `{ "${number.toString()}": ${numberCount}`);
        }
        return numberCount;
    });
    numberCountInRangeGroupAsString = `${numberCountInRangeGroupAsString} }`;
    return numberCountInRangeGroupAsString;
};
console.log(getNumberCountInRangeGroupAsString(8, 1, 100));
// { "8": 1, "18": 1, "28": 1, "38": 1, "48": 1, "58": 1, "68": 1, "78": 1, "80": 1, "81": 1, "82": 1, "83": 1, "84": 1, "85": 1, "86": 1, "87": 1, "88": 2, "89": 1, "98": 1 }
