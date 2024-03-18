console.log('\n// Custom Error and Error Handling in JavaScript');

const giveMeRespect = (parameter) => {
    // Custom Error
    if (parameter !== "respect") throw new Error('Error: You should give me "respect"!');
    return 'Thank you for giving me "respect"!';
};

let response;

// Error Handling
try {
    response = giveMeRespect("boo!");
    console.log(response);
} catch (anError) {
    console.log(anError.message);
}
console.log("I'm sorry!");

// Without Error Handling
response = giveMeRespect("boo!");
// this will never executed
console.log(response);
console.log("I'm sorry!");
