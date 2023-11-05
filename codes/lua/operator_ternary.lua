print('\n-- Ternary Operator in Lua')

function ternary_operator_v1(condition_is_true, result_if_condition_is_true, result_if_condition_is_false)
    if condition_is_true then
        return result_if_condition_is_true
    end
    return result_if_condition_is_false
end

function ternary_operator_v2(condition_is_true, result_if_condition_is_true, result_if_condition_is_false)
    return condition_is_true and result_if_condition_is_true or result_if_condition_is_false
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
