print("\n", "# Ternary Operator in Ruby")

CORRECT_ANSWER = "foo"
print("\n", "correct answer: ", CORRECT_ANSWER)

my_answer = "bar"
print("\n", "my answer: ", my_answer)
print("\n", "is my answer correct: ", ((my_answer === CORRECT_ANSWER) ? "correct!" : "wrong!"))
# is my answer correct: wrong!

my_answer = "foo"
print("\n", "my answer: ", my_answer)
print("\n", "is my answer correct: ", ((my_answer === CORRECT_ANSWER) ? "correct!" : "wrong!"))
# is my answer correct: correct!
