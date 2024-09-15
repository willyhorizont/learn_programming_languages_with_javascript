function sprint(...)
    local rest_arguments = {...}
    local new_array = {}
    for _, argument in ipairs(rest_arguments) do
        table.insert(new_array, tostring(argument))
    end
    print(table.concat(new_array, ""))
end

print('\n-- Custom Error and Error Handling in Lua')

function give_me_respect(argument)
    -- Custom Error
    if (type(argument) ~= "string") then error("Argument should be a string") end
    if (argument ~= "respect") then error("You should give me \"respect\"!") end
    return "Thank you for giving me \"respect\"!"
end

-- Error Handling
is_not_error, response_or_error_message = pcall(give_me_respect, "boo!")
if (is_not_error == true) then
    print(response_or_error_message)
else
    sprint(response_or_error_message)
end
print("I'm sorry!")

-- Without Error Handling
response = give_me_respect("boo!")
-- this will never executed
sprint(response)
print("I'm sorry!")
