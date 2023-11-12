print('\n-- Factorial(n) in Lua')

function factorial_v1(number)
    if type(number) ~= "number" then
        return "argument should be a number"
    end
    if ((number > 1) == false) then
        return 1
    end
    local result = 1
    local i = number
    while true do
        result = result * i
        i = i - 1
        if  (i <= 0) then
            break
        end
    end
    return result
end

function factorial_v2(number)
    if type(number) ~= "number" then
        return "argument should be a number"
    end
    if ((number > 1) == false) then
        return 1
    end
    local result = 1
    local i = number
    while (i >= 1) do
        result = result * i
        i = i - 1
    end
    return result
end

function factorial_v3(number)
    if type(number) ~= "number" then
        return "argument should be a number"
    end
    if ((number > 1) == false) then
        return 1
    end
    local result = 1
    for i = number, 1, -1 do
        result = result * i
    end
    return result
end

print("-- using factorial function \"factorial_v1\"")
print("Factorial(5): " .. tostring(factorial_v1(5)))
-- Factorial(5): 120

print("-- using factorial function \"factorial_v2\"")
print("Factorial(5): " .. tostring(factorial_v2(5)))
-- Factorial(5): 120

print("-- using factorial function \"factorial_v3\"")
print("Factorial(5): " .. tostring(factorial_v3(5)))
-- Factorial(5): 120