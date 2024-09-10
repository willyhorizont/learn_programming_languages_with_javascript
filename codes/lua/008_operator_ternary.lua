print('\n-- Ternary Operator in Lua')

function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

function ternary(true_condition, callback_function_if_condition_true, callback_function_if_condition_false)
    if (true_condition == true) then return callback_function_if_condition_true() end
    return callback_function_if_condition_false()
end

CORRECT_ANSWER = "foo"
sprint("correct answer: ", CORRECT_ANSWER)

print("-- using Ternary Operator function \"ternary\"")

my_answer = "bar"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ternary((my_answer == CORRECT_ANSWER), (function() return ("correct!") end), (function() return ("wrong!") end)))
-- is my answer correct: wrong!

my_answer = "foo"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ternary((my_answer == CORRECT_ANSWER), (function() return ("correct!") end), (function() return ("wrong!") end)))
-- is my answer correct: correct!

print("-- using \"and\" \"or\" operator, the Lua way")

my_answer = "bar"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ((my_answer == CORRECT_ANSWER) and "correct!") or "wrong!")
-- is my answer correct: wrong!

my_answer = "foo"
sprint("my answer: ", my_answer)
sprint("is my answer correct: ", ((my_answer == CORRECT_ANSWER) and "correct!") or "wrong!")
-- is my answer correct: correct!
