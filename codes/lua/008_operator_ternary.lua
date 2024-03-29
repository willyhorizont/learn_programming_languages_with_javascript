print('\n-- Ternary Operator in Lua')

function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

function ternary_v1(true_condition, value_if_condition_is_true, value_if_condition_is_false)
    if (true_condition == true) then return value_if_condition_is_true end
    return value_if_condition_is_false
end

function ternary_v2(true_condition, value_if_condition_is_true, value_if_condition_is_false)
    return ((true_condition and value_if_condition_is_true) or value_if_condition_is_false)
end

CORRECT_ANSWER = "foo"
sprint("correct answer: ", CORRECT_ANSWER)

print("-- using Ternary Operator function \"ternary_v1\"")

my_answer = "bar"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ternary_v1((my_answer == CORRECT_ANSWER), "correct!", "wrong!"))
-- is my answer correct: wrong!

my_answer = "foo"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ternary_v1((my_answer == CORRECT_ANSWER), "correct!", "wrong!"))
-- is my answer correct: correct!

print("-- using Ternary Operator function \"ternary_v2\"")

my_answer = "bar"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ternary_v2((my_answer == CORRECT_ANSWER), "correct!", "wrong!"))
-- is my answer correct: wrong!

my_answer = "foo"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ternary_v2((my_answer == CORRECT_ANSWER), "correct!", "wrong!"))
-- is my answer correct: correct!

my_answer = "bar"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ((my_answer == CORRECT_ANSWER) and "correct!") or "wrong!")
-- is my answer correct: wrong!

my_answer = "foo"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ((my_answer == CORRECT_ANSWER) and "correct!") or "wrong!")
-- is my answer correct: correct!
