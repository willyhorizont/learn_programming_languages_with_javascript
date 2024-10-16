println("\n# Ternary Operator in Julia")

CORRECT_ANSWER::Any = "foo"
println("correct answer: $(CORRECT_ANSWER)")

my_answer::Any = "bar"
println("my answer: $(my_answer)")
println("is my answer correct: $(((my_answer === CORRECT_ANSWER) ? "correct!" : "wrong!"))")
# is my answer correct: wrong!

my_answer::Any = "foo"
println("my answer: $(my_answer)")
println("is my answer correct: $(((my_answer === CORRECT_ANSWER) ? "correct!" : "wrong!"))")
# is my answer correct: correct!

my_answer::Any = "bar"
println("my answer: $(my_answer)")
println("is my answer correct: $(ifelse((my_answer === CORRECT_ANSWER), "correct!", "wrong!"))")
# is my answer correct: wrong!

my_answer::Any = "foo"
println("my answer: $(my_answer)")
println("is my answer correct: $(ifelse((my_answer === CORRECT_ANSWER), "correct!", "wrong!"))")
# is my answer correct: correct!
