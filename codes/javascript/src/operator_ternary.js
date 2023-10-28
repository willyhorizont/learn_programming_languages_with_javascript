console.log('\n// Ternary Operator in JavaScript');

const CORRECT_ANSWER = 'foo';
console.log(`correct answer: "${CORRECT_ANSWER}"`);

let myAnswer;
let isMyAnswerCorrect;

myAnswer = 'hello';
console.log(`my answer: "${myAnswer}"`);
isMyAnswerCorrect = myAnswer === CORRECT_ANSWER ? 'congrats!' : 'wrong answer!';
console.log(`result: ${isMyAnswerCorrect}`);
// result: wrong answer!

myAnswer = 'foo';
console.log(`my answer: "${myAnswer}"`);
isMyAnswerCorrect = myAnswer === CORRECT_ANSWER ? 'congrats!' : 'wrong answer!';
console.log(`result: ${isMyAnswerCorrect}`);
// result: congrats!
