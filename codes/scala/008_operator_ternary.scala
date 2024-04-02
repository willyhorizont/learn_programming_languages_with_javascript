println("\n// Ternary Operator in Scala")

val CORRECT_ANSWER: String = "foo"
println(s"correct answer: ${CORRECT_ANSWER}")

var myAnswer: Any = null

myAnswer = "bar"
println(s"my answer: ${myAnswer}")
println(s"is my answer correct: ${if (myAnswer.asInstanceOf[String] == CORRECT_ANSWER) "correct!" else "wrong!"}")
// is my answer correct: wrong!

myAnswer = "foo"
println(s"my answer: ${myAnswer}")
println(s"is my answer correct: ${if (myAnswer.asInstanceOf[String] == CORRECT_ANSWER) "correct!" else "wrong!"}")
// is my answer correct: correct!
