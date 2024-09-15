function sprint(...)
    local rest_arguments = {...}
    local new_array = {}
    for _, argument in ipairs(rest_arguments) do
        table.insert(new_array, tostring(argument))
    end
    print(table.concat(new_array, ""))
end

print('\n-- Factorial(n) in Lua')

function factorial_v1(number)
    if (type(number) ~= "number") then error("Argument should be a number") end
    if (number < 0) then error("Argument should bbe >= 0") end
    if (number == 0) then return 1 end
    local result = 1
    local i = number
    while (true) do
        result = result * i
        if  (i <= 1) then break end
        i = (i - 1)
    end
    return result
end

function factorial_v2(number)
    if (type(number) ~= "number") then error("Argument should be a number") end
    if (number < 0) then error("Argument should bbe >= 0") end
    if (number == 0) then return 1 end
    local result = 1
    local i = number
    while (i >= 1) do
        result = result * i
        i = (i - 1)
    end
    return result
end

function factorial_v3(number)
    if (type(number) ~= "number") then error("Argument should be a number") end
    if (number < 0) then error("Argument should bbe >= 0") end
    if (number == 0) then return 1 end
    local result = 1
    for i = number, 1, -1 do -- start, stop, step
        result = result * i
    end
    return result
end

function factorial_v4(number)
    if (type(number) ~= "number") then error("Argument should be a number") end
    if (number < 0) then error("Argument should bbe >= 0") end
    if (number == 0) then return 1 end
    return (number * factorial_v4(number - 1))
end

print("-- using factorial function \"factorial_v1\"")
sprint("Factorial(5): ", factorial_v1(5))
-- Factorial(5): 120

print("-- using factorial function \"factorial_v2\"")
sprint("Factorial(5): ", factorial_v2(5))
-- Factorial(5): 120

print("-- using factorial function \"factorial_v3\"")
sprint("Factorial(5): ", factorial_v3(5))
-- Factorial(5): 120

print("-- using factorial function \"factorial_v4\"")
sprint("Factorial(5): ", factorial_v4(5))
-- Factorial(5): 120