const getDictionaryItemCount = (anArray) => Object.fromEntries(anArray.reduce((currentResult, currentItem) => {
    const existingItem = currentResult.get(currentItem);
    if (existingItem) {
        currentResult.set(currentItem, (existingItem + 1));
        return currentResult;
    }
    currentResult.set(currentItem, 1);
    return currentResult;
}, new Map()));
console.log(getDictionaryItemCount(["Apple", "Banana", "Apple", "Orange", "Apple"])); // { Apple: 3, Banana: 1, Orange: 1 }
