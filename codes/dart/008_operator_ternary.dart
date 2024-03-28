void main() {
    print("\n// Ternary Operator in Dart");

    final CORRECT_ANSWER = "foo";
    print("correct answer: \"${CORRECT_ANSWER}\"");

    dynamic myAnswer;

    myAnswer = "bar";
    print("my answer: \"${myAnswer}\"");
    print("is my answer correct: ${((myAnswer == CORRECT_ANSWER) ? "correct!" : "wrong!")}");
    // is my answer correct: wrong!

    myAnswer = "foo";
    print("my answer: \"${myAnswer}\"");
    print("is my answer correct: ${((myAnswer == CORRECT_ANSWER) ? "correct!" : "wrong!")}");
    // is my answer correct: correct!
}
