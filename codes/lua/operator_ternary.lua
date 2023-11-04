print('\n-- Ternary Operator in Lua')

CORRECT_ANSWER = "foo"
print("correct answer: " .. CORRECT_ANSWER)

my_answer = "bar"
print("my answer: " .. my_answer)
print("is my answer correct: " .. tostring(((my_answer == CORRECT_ANSWER) and "correct!") or "wrong!"))
-- is my answer correct: wrong!

my_answer = "foo"
print("my answer: " .. my_answer)
print("is my answer correct: " .. tostring(((my_answer == CORRECT_ANSWER) and "correct!") or "wrong!"))
-- is my answer correct: correct!
