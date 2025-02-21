print("\n-- Custom Error and Error Handling in Lua")

function give_me_respect(argument)
    -- Custom Error
    if (type(argument) ~= "string") then error("Argument should be a string") end
    if (argument ~= "respect") then error('You should give me "respect"!') end
    return 'Thank you for giving me "respect"!'
end

-- Error Handling
is_success, any_result = pcall(give_me_respect, "boo!")
if (is_success == true) then
    print(any_result)
else
    print(any_result)
end
print("I'm sorry!")

-- Without Error Handling
response = give_me_respect("boo!")
-- this will never executed
print(response)
print("I'm sorry!")
