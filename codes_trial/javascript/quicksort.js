/* eslint-disable no-param-reassign */
function partition(anArray, left, right) {
    const pivot = anArray[Math.floor((right - left) / 2) + left];
    let leftIndex = left - 1;
    let rightIndex = right + 1;
    while (true) {
        do {
            leftIndex += 1;
        } while (anArray[leftIndex] < pivot);
        do {
            rightIndex -= 1;
        } while (anArray[rightIndex] > pivot);
        if (leftIndex >= rightIndex) return rightIndex;
        const temp = anArray[leftIndex];
        anArray[leftIndex] = anArray[rightIndex];
        anArray[rightIndex] = temp;
    }
}

function quicksort(anArray, left, right) {
    if ((left >= 0 && right >= 0 && left < right) === false) return;
    const p = partition(anArray, left, right);
    quicksort(anArray, left, p);
    quicksort(anArray, p + 1, right);
}

// Example usage:
const arrayToSort = [10, 7, 8, 9, 1, 5];
// const arrayToSort = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];
quicksort(arrayToSort, 0, arrayToSort.length - 1);
console.log("Sorted Array:", arrayToSort);
