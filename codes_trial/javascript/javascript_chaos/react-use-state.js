const reactJsLikeUseState = (initialValue) => ({
    state: initialValue,
    setState(newValue) {
        if (Object.prototype.toString.call(newValue) === "[object Function]") {
            this.state = newValue(this.state);
            return;
        }
        this.state = newValue;
    }
});

const myAge = reactJsLikeUseState(0);
console.log(`myAge: ${myAge.state}`); // myAge: 0
myAge.setState(17);
console.log(`myAge: ${myAge.state}`); // myAge: 17
myAge.setState(myAge.state + 1);
console.log(`myAge: ${myAge.state}`); // myAge: 18
myAge.setState((previousValue) => previousValue + 1);
console.log(`myAge: ${myAge.state}`); // myAge: 18
