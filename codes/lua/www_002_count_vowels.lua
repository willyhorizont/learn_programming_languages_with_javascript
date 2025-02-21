--[[
    Source:
        https://www.codewars.com/kata/54ff3102c1bad923760001f3
    Title:
        Vowel Count
    Description:
        Return the number (count) of vowels in the given string.
        We will consider a, e, i, o, u as vowels for this Kata (but not y).
        The input string will only consist of lower case letters and/or spaces.
]]

function split_string(any_string, separator)
    if (separator == nil) then
        return {any_string}
    end
    if (separator == "") then
       local characters = {}
       for string_index = 1, #any_string do
           table.insert(characters, string.sub(any_string, string_index, string_index))
       end
       return characters
    end
    local splitted_string = {}
    for separated_string in string.gmatch(any_string, "([^" .. separator .. "]+)") do
       table.insert(splitted_string, separated_string)
    end
    return splitted_string
end

function array_reduce(callback_function, any_array, initial_value)
    -- JavaScript-like Array.reduce() function
    local result = initial_value
    for array_item_index, array_item in ipairs(any_array) do
        result = callback_function(result, array_item, array_item_index, any_array)
    end
    return result
end

function array_filter(callback_function, any_array)
    -- JavaScript-like Array.filter() function
    local data_filtered = {}
    for array_item_index, array_item in ipairs(any_array) do
        if (callback_function(array_item, array_item_index, any_array) == true) then
            table.insert(data_filtered, array_item)
        end
    end
    return data_filtered
end

function array_includes(search_element, any_array)
    -- JavaScript-like Array.includes() function
    for _, array_item in ipairs(any_array) do
        if (array_item == search_element) then
            return true
        end
    end
    return false
end

function ternary(true_condition, callback_function_if_condition_true, callback_function_if_condition_false)
    if (true_condition == true) then return callback_function_if_condition_true() end
    return callback_function_if_condition_false()
end

count_vowels_v1 = function (any_string) return array_reduce(function (current_result, any_character) return ternary(array_includes(any_character, {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}), (function () return (current_result + 1) end), (function () return current_result end)) end, split_string(any_string, ""), 0) end
print(count_vowels_v1("Hello World")) -- 3

count_vowels_v2 = function (any_string) return array_reduce(function (current_result, any_character) return ternary(array_includes(string.upper(any_character), {"A", "I", "U", "E", "O"}), (function () return (current_result + 1) end), (function () return current_result end)) end, split_string(any_string, ""), 0) end
print(count_vowels_v2("Hello World")) -- 3

count_vowels_v3 = function (any_string) return array_reduce(function (current_result, any_character) return ternary((string.find("aiueoAIUEO", any_character) ~= nil), (function () return (current_result + 1) end), (function () return current_result end)) end, split_string(any_string, ""), 0) end
print(count_vowels_v3("Hello World")) -- 3

count_vowels_v4 = function (any_string) return array_reduce(function (current_result, any_character) return ternary((string.find("AIUEO", string.upper(any_character)) ~= nil), (function () return (current_result + 1) end), (function () return current_result end)) end, split_string(any_string, ""), 0) end
print(count_vowels_v4("Hello World")) -- 3

count_vowels_v5 = function (any_string) return #array_filter(function (any_character) return array_includes(any_character, {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}) end, split_string(any_string, "")) end
print(count_vowels_v5("Hello World")) -- 3

count_vowels_v6 = function (any_string) return #array_filter(function (any_character) return array_includes(string.upper(any_character), {"A", "I", "U", "E", "O"}) end, split_string(any_string, "")) end
print(count_vowels_v6("Hello World")) -- 3

count_vowels_v7 = function (any_string) return #array_filter(function (any_character) return string.find("aiueoAIUEO", any_character) ~= nil end, split_string(any_string, "")) end
print(count_vowels_v7("Hello World")) -- 3

count_vowels_v8 = function (any_string) return #array_filter(function (any_character) return string.find("AIUEO", string.upper(any_character)) ~= nil end, split_string(any_string, "")) end
print(count_vowels_v8("Hello World")) -- 3
