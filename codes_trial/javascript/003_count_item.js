const countItem = (anArray) => anArray.reduce((currentResult, currentItem) => (currentResult?.[currentItem] ? { ...currentResult, [currentItem]: (currentResult?.[currentItem] + 1) } : { ...currentResult, [currentItem]: 1 }), {});
console.log(countItem(["apple", "banana", "apple", "orange", "apple"])); // { apple: 3, banana: 1, orange: 1 }
