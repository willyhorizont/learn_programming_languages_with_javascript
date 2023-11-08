print("\n# Ternary Operator in Ruby")

CORRECT_ANSWER = "foo"
print("\ncorrect answer: ", CORRECT_ANSWER)

my_answer = "bar"
print("\nmy answer: ", my_answer)
print("\nis my answer correct: ", ((my_answer === CORRECT_ANSWER) ? "correct!" : "wrong!"))
# is my answer correct: wrong!

my_answer = "foo"
print("\nmy answer: ", my_answer)
print("\nis my answer correct: ", ((my_answer === CORRECT_ANSWER) ? "correct!" : "wrong!"))
# is my answer correct: correct!
