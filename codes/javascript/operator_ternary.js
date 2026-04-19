console.log("\n// Ternary Operator in JavaScript");

const CORRECT_ANSWER = "foo";
console.log(`correct answer: "${CORRECT_ANSWER}"`);

let myAnswer;

myAnswer = "bar";
console.log(`my answer: "${myAnswer}"`);
console.log(`is my answer correct: ${((myAnswer === CORRECT_ANSWER) ? "correct!" : "wrong!")}`);
// is my answer correct: wrong!

myAnswer = "foo";
console.log(`my answer: "${myAnswer}"`);
console.log(`is my answer correct: ${((myAnswer === CORRECT_ANSWER) ? "correct!" : "wrong!")}`);
// is my answer correct: correct!
