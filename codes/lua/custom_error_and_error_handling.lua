function s_print(...)
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
is_not_error, response_or_error = pcall(give_me_respect, "boo!")
if (is_not_error == true) then
    print(response_or_error)
else
    s_print(response_or_error)
end
print("I'm sorry!")

-- Without Error Handling
response = give_me_respect("boo!")
-- this will never executed
s_print(response)
print("I'm sorry!")
