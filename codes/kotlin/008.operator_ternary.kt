@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc operator_ternary.kt -include-runtime -d operator_ternary.jar && kotlin operator_ternary.jar

fun main() {
    println("\n// Ternary Operator in Kotlin")

    val CORRECT_ANSWER = "foo"
    println("correct answer: ${CORRECT_ANSWER}")

    var myAnswer: Any?

    myAnswer = "bar"
    println("my answer: ${myAnswer}")
    println("is my answer correct: ${if (myAnswer == CORRECT_ANSWER) "correct!" else "wrong!"}")
    // is my answer correct: wrong!

    myAnswer = "foo"
    println("my answer: ${myAnswer}")
    println("is my answer correct: ${if (myAnswer == CORRECT_ANSWER) "correct!" else "wrong!"}")
    // is my answer correct: correct!
}
