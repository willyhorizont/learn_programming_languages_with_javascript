using Printf
using Statistics

println("\n# Ternary Operator in Julia")

CORRECT_ANSWER = "foo"
println("correct answer: ", CORRECT_ANSWER)

my_answer = "bar"
println("my answer: ", my_answer)
println("is my answer correct: ", ((my_answer === CORRECT_ANSWER) ? "correct!" : "wrong!"))
# is my answer correct: wrong!

my_answer = "foo"
println("my answer: ", my_answer)
println("is my answer correct: ", ((my_answer === CORRECT_ANSWER) ? "correct!" : "wrong!"))
# is my answer correct: correct!
