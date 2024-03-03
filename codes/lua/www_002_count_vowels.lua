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

function split_string(a_string, separator)
    if (separator == nil) then
        return {a_string}
    end
    if separator == "" then
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

function array_reduce(callback_function, an_array, initial_value)
    -- JavaScript-like Array.reduce() function
    local result = initial_value
    for array_item_index, array_item in ipairs(an_array) do
        result = callback_function(result, array_item, array_item_index, an_array)
    end
    return result
end

function array_filter(callback_function, an_array)
    -- JavaScript-like Array.filter() function
    local data_filtered = {}
    for array_item_index, array_item in ipairs(an_array) do
        if callback_function(array_item, array_item_index, an_array) == true then
            table.insert(data_filtered, array_item)
        end
    end
    return data_filtered
end

function array_includes(search_element, an_array)
    -- JavaScript-like Array.includes() function
    for _, array_item in ipairs(an_array) do
        if (array_item == search_element) then
            return true
        end
    end
    return false
end

function ternary_operator(true_condition, value_if_condition_is_true, value_if_condition_is_false)
    if true_condition then
        return value_if_condition_is_true
    end
    return value_if_condition_is_false
end

count_vowels_v1 = function(a_string) return array_reduce(function(result, a_letter) return ternary_operator(array_includes(a_letter, {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}), (result + 1), result) end, split_string(a_string, ""), 0) end
print(count_vowels_v1("Hello World")) -- 3

count_vowels_v2 = function(a_string) return array_reduce(function(result, a_letter) return ternary_operator(array_includes(string.upper(a_letter), {"A", "I", "U", "E", "O"}), (result + 1), result) end, split_string(a_string, ""), 0) end
print(count_vowels_v2("Hello World")) -- 3

count_vowels_v3 = function(a_string) return array_reduce(function(result, a_letter) return ternary_operator(string.find("aiueoAIUEO", a_letter) ~= nil, (result + 1), result) end, split_string(a_string, ""), 0) end
print(count_vowels_v3("Hello World")) -- 3

count_vowels_v4 = function(a_string) return array_reduce(function(result, a_letter) return ternary_operator(string.find("AIUEO", string.upper(a_letter)) ~= nil, (result + 1), result) end, split_string(a_string, ""), 0) end
print(count_vowels_v4("Hello World")) -- 3

count_vowels_v5 = function(a_string) return #array_filter(function(a_letter) return array_includes(a_letter, {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}) end, split_string(a_string, "")) end
print(count_vowels_v5("Hello World")) -- 3

count_vowels_v6 = function(a_string) return #array_filter(function(a_letter) return array_includes(string.upper(a_letter), {"A", "I", "U", "E", "O"}) end, split_string(a_string, "")) end
print(count_vowels_v6("Hello World")) -- 3

count_vowels_v7 = function(a_string) return #array_filter(function(a_letter) return string.find("aiueoAIUEO", a_letter) ~= nil end, split_string(a_string, "")) end
print(count_vowels_v7("Hello World")) -- 3

count_vowels_v8 = function(a_string) return #array_filter(function(a_letter) return string.find("AIUEO", string.upper(a_letter)) ~= nil end, split_string(a_string, "")) end
print(count_vowels_v8("Hello World")) -- 3
