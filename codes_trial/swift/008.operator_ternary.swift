print("\n// Ternary Operator in Swift")

let CORRECT_ANSWER = "foo"
print("correct answer: \"\(CORRECT_ANSWER)\"")

var myAnswer: String

myAnswer = "bar"
print("my answer: \"\(myAnswer)\"")
print("is my answer correct: \(((myAnswer == CORRECT_ANSWER) ? "correct!" : "wrong!"))")
// is my answer correct: wrong!

myAnswer = "foo"
print("my answer: \"\(myAnswer)\"")
print("is my answer correct: \(((myAnswer == CORRECT_ANSWER) ? "correct!" : "wrong!"))")
// is my answer correct: correct!
