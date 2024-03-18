function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

print('\n-- Custom Error and Error Handling in Lua')

function give_me_respect(parameter)
    -- Custom Error
    if (type(parameter) ~= "string") then error("Argument should be a string") end
    if (parameter ~= "respect") then error("You should give me \"respect\"!") end
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
