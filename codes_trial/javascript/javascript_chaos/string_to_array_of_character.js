const anyString = "foo";
console.log(anyString.split("")); // ["f", "o", "o"]
console.log(Array.from(anyString)); // ["f", "o", "o"]
console.log([...anyString]); // ["f", "o", "o"]

console.log(anyString.length);
