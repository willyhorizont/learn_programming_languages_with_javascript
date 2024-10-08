function sprint(...)
    local rest_arguments = {...}
    local new_array = {}
    for _, argument in ipairs(rest_arguments) do
        table.insert(new_array, tostring(argument))
    end
    print(table.concat(new_array, ""))
end

print('\n-- FizzBuzz(n) in Lua')

function fizzbuzz_v1(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    local number = 1
    while (true) do
        if (result == "") then
            result = tostring(number)
            if (number >= stop_number) then break end
            number = (number + 1)
            goto next
        end
        if (((number % 3) == 0) and ((number % 5) == 0)) then
            result = result .. ", FizzBuzz"
            if (number >= stop_number) then break end
            number = (number + 1)
            goto next
        end
        if ((number % 3) == 0) then
            result = result .. ", Fizz"
            if (number >= stop_number) then break end
            number = (number + 1)
            goto next
        end
        if ((number % 5) == 0) then
            result = result .. ", Buzz"
            if (number >= stop_number) then break end
            number = (number + 1)
            goto next
        end
        result = result .. ", " .. number
        if (number >= stop_number) then break end
        number = (number + 1)
        ::next::
    end
    return result
end

function fizzbuzz_v2(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    local number = 1
    while (number <= stop_number) do
        if (result == "") then
            result = tostring(number)
            number = (number + 1)
            goto next
        end
        if (((number % 3) == 0) and ((number % 5) == 0)) then
            result = result .. ", FizzBuzz"
            number = (number + 1)
            goto next
        end
        if ((number % 3) == 0) then
            result = result .. ", Fizz"
            number = (number + 1)
            goto next
        end
        if ((number % 5) == 0) then
            result = result .. ", Buzz"
            number = (number + 1)
            goto next
        end
        result = result .. ", " .. number
        number = (number + 1)
        ::next::
    end
    return result
end

function fizzbuzz_v3(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    local number = 1
    while (true) do
        if (result == "") then
            result = tostring(number)
        elseif (((number % 3) == 0) and ((number % 5) == 0)) then
            result = result .. ", FizzBuzz"
        elseif ((number % 3) == 0) then
            result = result .. ", Fizz"
        elseif ((number % 5) == 0) then
            result = result .. ", Buzz"
        else
            result = result .. ", " .. number
        end
        if (number >= stop_number) then break end
        number = (number + 1)
    end
    return result
end

function fizzbuzz_v4(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    local number = 1
    while (number <= stop_number) do
        if (result == "") then
            result = tostring(number)
        elseif (((number % 3) == 0) and ((number % 5) == 0)) then
            result = result .. ", FizzBuzz"
        elseif ((number % 3) == 0) then
            result = result .. ", Fizz"
        elseif ((number % 5) == 0) then
            result = result .. ", Buzz"
        else
            result = result .. ", " .. number
        end
        number = (number + 1)
    end
    return result
end

function fizzbuzz_v5(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    local number = 1
    while (true) do
        result = ((((result == ""))
            and tostring(number))
            or (((((number % 3) == 0) and ((number % 5) == 0))
                and result .. ", FizzBuzz")
                or ((((number % 3) == 0)
                    and result .. ", Fizz")
                    or ((((number % 5) == 0)
                        and result .. ", Buzz")
                        or result .. ", " .. number
                    )
                )
            )
        )
        if (number >= stop_number) then break end
        number = (number + 1)
    end
    return result
end

function fizzbuzz_v6(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    local number = 1
    while (number <= stop_number) do
        result = ((((result == ""))
            and tostring(number))
            or (((((number % 3) == 0) and ((number % 5) == 0))
                and result .. ", FizzBuzz")
                or ((((number % 3) == 0)
                    and result .. ", Fizz")
                    or ((((number % 5) == 0)
                        and result .. ", Buzz")
                        or result .. ", " .. number
                    )
                )
            )
        )
        number = (number + 1)
    end
    return result
end

function fizzbuzz_v7(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    local number = 1
    while (true) do
        result = ((((result == "")) and tostring(number)) or (((((number % 3) == 0) and ((number % 5) == 0)) and result .. ", FizzBuzz") or ((((number % 3) == 0) and result .. ", Fizz") or ((((number % 5) == 0) and result .. ", Buzz") or result .. ", " .. number))))
        if (number >= stop_number) then break end
        number = (number + 1)
    end
    return result
end

function fizzbuzz_v8(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    local number = 1
    while (number <= stop_number) do
        result = ((((result == "")) and tostring(number)) or (((((number % 3) == 0) and ((number % 5) == 0)) and result .. ", FizzBuzz") or ((((number % 3) == 0) and result .. ", Fizz") or ((((number % 5) == 0) and result .. ", Buzz") or result .. ", " .. number))))
        number = (number + 1)
    end
    return result
end

function fizzbuzz_v9(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    for number = 1, stop_number, 1 do -- start, stop, step
        if (result == "") then
            result = tostring(number)
            goto next
        end
        if (((number % 3) == 0) and ((number % 5) == 0)) then
            result = result .. ", FizzBuzz"
            goto next
        end
        if ((number % 3) == 0) then
            result = result .. ", Fizz"
            goto next
        end
        if ((number % 5) == 0) then
            result = result .. ", Buzz"
            goto next
        end
        result = result .. ", " .. number
        ::next::
    end
    return result
end

function fizzbuzz_v10(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    for number = 1, stop_number, 1 do -- start, stop, step
        if (result == "") then
            result = tostring(number)
        elseif (((number % 3) == 0) and ((number % 5) == 0)) then
            result = result .. ", FizzBuzz"
        elseif ((number % 3) == 0) then
            result = result .. ", Fizz"
        elseif ((number % 5) == 0) then
            result = result .. ", Buzz"
        else
            result = result .. ", " .. number
        end
    end
    return result
end

function fizzbuzz_v11(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    for number = 1, stop_number, 1 do -- start, stop, step
        result = ((((result == ""))
            and tostring(number))
            or (((((number % 3) == 0) and ((number % 5) == 0))
                and result .. ", FizzBuzz")
                or ((((number % 3) == 0)
                    and result .. ", Fizz")
                    or ((((number % 5) == 0)
                        and result .. ", Buzz")
                        or result .. ", " .. number
                    )
                )
            )
        )
    end
    return result
end

function fizzbuzz_v12(stop_number)
    if (type(stop_number) ~= "number") then error("Argument should be a number") end
    if (stop_number < 1) then error("Argument should be > 0") end
    local result = ""
    for number = 1, stop_number, 1 do -- start, stop, step
        result = ((((result == "")) and tostring(number)) or (((((number % 3) == 0) and ((number % 5) == 0)) and result .. ", FizzBuzz") or ((((number % 3) == 0) and result .. ", Fizz") or ((((number % 5) == 0) and result .. ", Buzz") or result .. ", " .. number))))
    end
    return result
end

print("-- using fizzbuzz function \"fizzbuzz_v1\"")
sprint("FizzBuzz(36): ", fizzbuzz_v1(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v2\"")
sprint("FizzBuzz(36): ", fizzbuzz_v2(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v3\"")
sprint("FizzBuzz(36): ", fizzbuzz_v3(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v4\"")
sprint("FizzBuzz(36): ", fizzbuzz_v4(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v5\"")
sprint("FizzBuzz(36): ", fizzbuzz_v5(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v6\"")
sprint("FizzBuzz(36): ", fizzbuzz_v6(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v7\"")
sprint("FizzBuzz(36): ", fizzbuzz_v7(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v8\"")
sprint("FizzBuzz(36): ", fizzbuzz_v8(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v9\"")
sprint("FizzBuzz(36): ", fizzbuzz_v9(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v10\"")
sprint("FizzBuzz(36): ", fizzbuzz_v10(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v11\"")
sprint("FizzBuzz(36): ", fizzbuzz_v11(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("-- using fizzbuzz function \"fizzbuzz_v12\"")
sprint("FizzBuzz(36): ", fizzbuzz_v12(36))
-- FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
