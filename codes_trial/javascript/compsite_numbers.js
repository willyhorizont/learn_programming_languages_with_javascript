function isComposite(number) {
    // A composite number is any integer greater than 1 that has more than two positive divisors
    if (number <= 1) {
        return false; // Numbers less than or equal to 1 are not composite numbers
    }
    
    for (let i = 2; i <= Math.sqrt(number); i++) {
        if (number % i === 0) {
            return true; // If number is divisible by i, then it has more than two positive divisors, hence it's a composite number
        }
    }
    
    return false; // If number is not divisible by any integer from 2 to square root of number, then it's not a composite number
}

// Example usage:
console.log(isComposite(4)); // Output: true
console.log(isComposite(7)); // Output: false

function generateCompositeNumbers(limit) {
    const compositeNumbers = [];

    for (let i = 4; i <= limit; i++) { // Start from 4 since 1, 2, and 3 are not composite numbers
        let isComposite = false;
        for (let j = 2; j <= Math.sqrt(i); j++) {
            if (i % j === 0) {
                isComposite = true;
                break;
            }
        }
        if (isComposite) {
            compositeNumbers.push(i);
        }
    }

    return compositeNumbers;
}

// Example usage:
const limit = 20;
console.log(`Composite numbers up to ${limit}:`, generateCompositeNumbers(limit));

