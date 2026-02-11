function checkIsNumberComposite(anyWholeNumber) {
    // A composite number is any integer greater than 1 that has more than two positive divisors
    if (anyWholeNumber <= 1) return false; // Numbers less than or equal to 1 are not composite numbers
    
    for (let i = 2; (i <= Math.sqrt(anyWholeNumber)); i += 1) {
        if ((anyWholeNumber % i) === 0) return true; // If number is divisible by i, then it has more than two positive divisors, hence it's a composite number
    }
    
    return false; // If number is not divisible by any integer from 2 to square root of number, then it's not a composite number
}

// Example usage:
console.log(checkIsNumberComposite(4)); // Output: true
console.log(checkIsNumberComposite(7)); // Output: false

function generateCompositeNumbers(upperBound) {
    const compositeNumbers = [];

    for (let i = 4; (i <= upperBound); i += 1) { // Start from 4 since 1, 2, and 3 are not composite numbers
        let isNumberComposite = false;
        for (let j = 2; (j <= Math.sqrt(i)); j += 1) {
            if ((i % j) === 0) {
                isNumberComposite = true;
                break;
            }
        }
        if (isNumberComposite) {
            compositeNumbers.push(i);
        }
    }

    return compositeNumbers;
}

// Example usage:
console.log(`generateCompositeNumbers(20):`, generateCompositeNumbers(20));
