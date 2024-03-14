--[[
Source:
    https://www.codewars.com/kata/57eadb7ecd143f4c9c0000a3
Title:
    Abbreviate a Two Word Name
Description:
    Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
    The output should be two capital letters with a dot separating them.
    It should look like this:
    Sam Harris => S.H
    patrick feeney => P.F
]]

function split_string(a_string, separator)
    if (separator == nil) then
        return {a_string}
    end
    if (separator == "") then
       local characters = {}
       for string_index = 1, #a_string do
           table.insert(characters, string.sub(a_string, string_index, string_index))
       end
       return characters
    end
    local splitted_string = {}
    for separated_string in string.gmatch(a_string, "([^" .. separator .. "]+)") do
       table.insert(splitted_string, separated_string)
    end
    return splitted_string
end

function array_map(callback_function, an_array)
    -- JavaScript-like Array.map() function
    local new_array = {}
    for array_item_index, array_item in ipairs(an_array) do
        table.insert(new_array, callback_function(array_item, array_item_index, an_array))
    end
    return new_array
end

abbreviate_name = function(complete_name) return table.concat(array_map(function(name) return string.upper(string.sub(name, 1, 1)) end, split_string(complete_name, " ")), ".") end
print(abbreviate_name("Sam Harris"))
-- S.H
print(abbreviate_name("patrick feeney"))
-- P.F
