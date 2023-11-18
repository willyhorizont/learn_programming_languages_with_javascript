print('\n-- Ternary Operator in Lua')

function ternary_operator_v1(true_condition, value_if_condition_is_true, value_if_condition_is_false)
    if true_condition then
        return value_if_condition_is_true
    end
    return value_if_condition_is_false
end

function ternary_operator_v2(true_condition, value_if_condition_is_true, value_if_condition_is_false)
    return ((true_condition and value_if_condition_is_true) or value_if_condition_is_false)
end

CORRECT_ANSWER = "foo"
print("correct answer: " .. CORRECT_ANSWER)

print("-- using Ternary Operator function \"ternary_operator_v1\"")

my_answer = "bar"
print("my answer: " .. my_answer)
print("is my answer correct: " .. tostring(ternary_operator_v1((my_answer == CORRECT_ANSWER), "correct!", "wrong!")))
-- is my answer correct: wrong!

my_answer = "foo"
print("my answer: " .. my_answer)
print("is my answer correct: " .. tostring(ternary_operator_v1((my_answer == CORRECT_ANSWER), "correct!", "wrong!")))
-- is my answer correct: correct!

print("-- using Ternary Operator function \"ternary_operator_v2\"")

my_answer = "bar"
print("my answer: " .. my_answer)
print("is my answer correct: " .. tostring(ternary_operator_v2((my_answer == CORRECT_ANSWER), "correct!", "wrong!")))
-- is my answer correct: wrong!

my_answer = "foo"
print("my answer: " .. my_answer)
print("is my answer correct: " .. tostring(ternary_operator_v2((my_answer == CORRECT_ANSWER), "correct!", "wrong!")))
-- is my answer correct: correct!

my_answer = "bar"
print("my answer: " .. my_answer)
print("is my answer correct: " .. tostring(((my_answer == CORRECT_ANSWER) and "correct!") or "wrong!"))
-- is my answer correct: wrong!

my_answer = "foo"
print("my answer: " .. my_answer)
print("is my answer correct: " .. tostring(((my_answer == CORRECT_ANSWER) and "correct!") or "wrong!"))
-- is my answer correct: correct!
