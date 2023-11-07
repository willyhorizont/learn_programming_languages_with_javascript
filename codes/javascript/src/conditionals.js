/* eslint-disable eqeqeq */
/*
Relational Operators / Comparison Operators:
equal to (==) *checks for equality after performing type coercion. It converts operands to the same type before making the comparison.
not equal to (!=) *checks for inequality after performing type coercion. It converts operands to the same type before making the comparison.
strict equal to (===) *checks for strict equality without type coercion. It requires both the value and the type to be the same.
strict not equal to (!==) *checks for strict inequality without type coercion. It requires both the value and the type to be the same.
greater than (>)
less than (<)
greater then or equal to (>=)
less then or equal to (<=)

Logical Operators:
Logical AND (&&)
Logical OR (||)
Logical NOT (!)
*/

const CORRECT_ANSWER = 100;

let myAge;
let myAnswer;
let hasDrivingLicense;
let canDrive;

console.log("\n// equal to (==)\n");

myAnswer = "100";
console.log("myAnswer:", myAnswer);
console.log("CORRECT_ANSWER:", CORRECT_ANSWER);
console.log("(myAnswer == CORRECT_ANSWER):");
if (myAnswer == CORRECT_ANSWER) {
    console.log("Your answer is correct");
} else {
    console.log("Your answer is wrong");
}

console.log("\n// not equal to (!=)\n");

myAnswer = "25";
console.log("myAnswer:", myAnswer);
console.log("CORRECT_ANSWER:", CORRECT_ANSWER);
console.log("(myAnswer != CORRECT_ANSWER):");
if (myAnswer != CORRECT_ANSWER) {
    console.log("Your answer is correct");
} else {
    console.log("Your answer is wrong");
}

console.log("\n// strict equal to (===)\n");

myAnswer = "100";
console.log("myAnswer:", myAnswer);
console.log("CORRECT_ANSWER:", CORRECT_ANSWER);
console.log("(myAnswer === CORRECT_ANSWER):");
if (myAnswer === CORRECT_ANSWER) {
    console.log("Your answer is correct");
} else {
    console.log("Your answer is wrong");
}

console.log("\n// strict not equal to (!==)\n");

myAnswer = "25";
console.log("myAnswer:", myAnswer);
console.log("CORRECT_ANSWER:", CORRECT_ANSWER);
console.log("(myAnswer !== CORRECT_ANSWER):");
if (myAnswer !== CORRECT_ANSWER) {
    console.log("Your answer is correct");
} else {
    console.log("Your answer is wrong");
}

console.log("\n// greater than (>)\n");

myAge = 70;
console.log("myAge:", myAge);
console.log("(myAge > 50):");
if (myAge > 50) console.log("You are old");

console.log("\n// less than (<)\n");

myAge = 16;
console.log("myAge:", myAge);
console.log("(myAge < 20):");
if (myAge < 20) console.log("You are young");

console.log("\n// greater then or equal to (>=)\n");

myAge = 73;
console.log("myAge:", myAge);
console.log("(myAge >= 65):");
if (myAge >= 65) console.log("You are allowed to retire");

console.log("\n// less then or equal to (<=)\n");

myAge = 14;
console.log("myAge:", myAge);
console.log("(myAge <= 16):");
if (myAge <= 16) console.log("You are not allowed to drive");

console.log("\n// Logical AND (&&)\n");

myAge = 17;
console.log("myAge:", myAge);
hasDrivingLicense = false;
console.log("has driving license:", hasDrivingLicense);
console.log("((myAge >= 17) && (hasDrivingLicense === true)):");
console.log((((myAge >= 17) && (hasDrivingLicense === true)) ? "You are allowed to drive" : "You are not allowed to drive"));

myAge = 17;
console.log("myAge:", myAge);
hasDrivingLicense = true;
console.log("has driving license:", hasDrivingLicense);
console.log("((myAge >= 17) && (hasDrivingLicense === true)):");
console.log((((myAge >= 17) && (hasDrivingLicense === true)) ? "You are allowed to drive" : "You are not allowed to drive"));

console.log("\n// Logical OR (||)\n");

myAge = 2;
console.log("myAge:", myAge);
console.log("((myAge <= 3) || (myAge >= 65)):");
if ((myAge <= 3) || (myAge >= 65)) console.log("You should stay home");

myAge = 89;
console.log("myAge:", myAge);
console.log("((myAge <= 3) || (myAge >= 65)):");
if ((myAge <= 3) || (myAge >= 65)) console.log("You should stay home");

console.log("\n// Logical NOT (!)\n");

canDrive = false;
console.log("canDrive:", canDrive);
console.log("!canDrive:", !canDrive);

canDrive = true;
console.log("canDrive:", canDrive);
console.log("!canDrive:", !canDrive);
