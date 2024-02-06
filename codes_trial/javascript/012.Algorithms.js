const linearSearch = (anArray, itemToFind) => {
    if (anArray.length === undefined) return undefined;
    for (let i = 0; i < anArray.length; i += 1) {
        if (anArray[i] === itemToFind) return i;
    }
    return -1;
};
const sortedArray1 = [2, 3, 4, 10, 40];
console.log("sortedArray1:", JSON.stringify(sortedArray1).split(',').join(', '));
console.log("linearSearch(sortedArray1, 3):", linearSearch(sortedArray1, 3));

const binarySearch = (aSortedArray, itemToFind) => {
    let left = 0;
    let right = aSortedArray.length - 1;
    while (left <= right) {
        const mid = left + Math.floor((right - left) / 2);
        if (aSortedArray[mid] === itemToFind) return mid;
        if (aSortedArray[mid] < itemToFind) left = mid + 1;
        if (aSortedArray[mid] > itemToFind) right = mid - 1;
    }
    return -1;
};
const sortedArray2 = [2, 3, 4, 10, 40];
console.log("sortedArray2:", JSON.stringify(sortedArray2).split(',').join(', '));
console.log("binarySearch(sortedArray2, 10):", binarySearch(sortedArray2, 10));

const bubbleSortV1 = (anArray) => {
    for (let i = 0; i < (anArray.length - 1); i += 1) {
        for (let j = 0; j < (anArray.length - 1 - i); j += 1) {
            if (anArray[j] > anArray[j + 1]) {
                const temp = anArray[j];
                // eslint-disable-next-line no-param-reassign
                anArray[j] = anArray[j + 1];
                // eslint-disable-next-line no-param-reassign
                anArray[j + 1] = temp;
            }
        }
    }
};
const unsortedArray1 = [64, 34, 25, 12, 22, 11, 90];
console.log("unsortedArray1:", JSON.stringify(unsortedArray1).split(',').join(', '));
bubbleSortV1(unsortedArray1);
console.log("unsortedArray1 after bubbleSortV1(unsortedArray1):", JSON.stringify(unsortedArray1).split(',').join(', '));

const bubbleSortV2 = (anArray) => {
    let isSwapped;
    for (let i = 0; i < (anArray.length - 1); i += 1) {
        isSwapped = false;
        for (let j = 0; j < (anArray.length - 1 - i); j += 1) {
            if (anArray[j] > anArray[j + 1]) {
                const temp = anArray[j];
                // eslint-disable-next-line no-param-reassign
                anArray[j] = anArray[j + 1];
                // eslint-disable-next-line no-param-reassign
                anArray[j + 1] = temp;
                isSwapped = true;
            }
        }
        if (isSwapped === false) break;
    }
};
const unsortedArray2 = [64, 34, 25, 12, 22, 11, 90];
console.log("unsortedArray2:", JSON.stringify(unsortedArray2).split(',').join(', '));
bubbleSortV2(unsortedArray2);
console.log("unsortedArray2 after bubbleSortV2(unsortedArray2):", JSON.stringify(unsortedArray2).split(',').join(', '));

const quickSort = (anArray, left, right) => {
    if (left >= right || left < 0) return;
    const partition = (pAnArray, pLeft, pRight) => {
        const pivot = pAnArray[pRight];
        let newPivotIndex = pLeft - 1;
        for (let j = pLeft; j < pRight; j += 1) {
            if ((pAnArray[j] <= pivot) === false) continue;
            newPivotIndex += 1;
            const temp = pAnArray[j];
            // eslint-disable-next-line no-param-reassign
            pAnArray[j] = pAnArray[newPivotIndex];
            // eslint-disable-next-line no-param-reassign
            pAnArray[newPivotIndex] = temp;
        }
        newPivotIndex += 1;
        // eslint-disable-next-line no-param-reassign
        pAnArray[pRight] = pAnArray[newPivotIndex];
        // eslint-disable-next-line no-param-reassign
        pAnArray[newPivotIndex] = pivot;
        return newPivotIndex;
    };
    const pivotIndex = partition(anArray, left, right);
    quickSort(anArray, left, pivotIndex - 1);
    quickSort(anArray, pivotIndex + 1, right);
};
const unsortedArray3 = [10, 7, 8, 9, 1, 5];
console.log("unsortedArray3:", JSON.stringify(unsortedArray3).split(',').join(', '));
quickSort(unsortedArray3, 0, (unsortedArray3.length - 1));
console.log("unsortedArray3 after quickSort(unsortedArray3, 0, (unsortedArray3.length - 1)):", JSON.stringify(unsortedArray3).split(',').join(', '));
