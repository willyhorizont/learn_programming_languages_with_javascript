const solidJsLikeCreateSignal = (initialValue) => {
    let currentValue = initialValue;
    return [
        () => currentValue,
        (newValue) => {
            if (Object.prototype.toString.call(newValue) === "[object Function]") {
                currentValue = newValue(currentValue);
                return;
            }
            currentValue = newValue;
        }
    ];
};

const [myAge, setMyAge] = solidJsLikeCreateSignal(0);
console.log(`myAge: ${myAge()}`); // myAge: 0
setMyAge(17);
console.log(`myAge: ${myAge()}`); // myAge: 17
setMyAge(myAge() + 1);
console.log(`myAge: ${myAge()}`); // myAge: 18
setMyAge((previousValue) => previousValue + 1);
console.log(`myAge: ${myAge()}`); // myAge: 18
