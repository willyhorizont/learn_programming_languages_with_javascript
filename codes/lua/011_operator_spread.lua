JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

function s_print(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

-- There's no JavaScript-like Spread Syntax (...) in Lua.
-- But, we can create our own function to mimic it in Lua.

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

function pretty_array_of_primitives(an_array_of_primitives)
    local result = "["
    for array_item_index, array_item in ipairs(an_array_of_primitives) do
        if ((type(array_item) ~= "string") and (type(array_item) ~= "number") and (type(array_item) ~= "boolean") and (array_item ~= "nil")) then
            goto next
        end
        if (array_item == "nil") then
            result = result .. "null"
        end
        if ((type(array_item) == "string") and (array_item ~= "nil")) then
            result = result .. "\"" .. array_item .. "\""
        end
        if (type(array_item) == "number") then
            result = result .. array_item
        end
        if (type(array_item) == "boolean") then
            result = result .. tostring(array_item)
        end
        if (array_item_index ~= #an_array_of_primitives) then
            result = result .. ", "
        end
        ::next::
    end
    result = result .. "]"
    return result
end

function get_type(anything)
    if (type(anything) ~= "table") then
       return type(anything) 
    end
    if (next(anything) == nil) then
        return "empty_table"
    end
    for k, v in pairs(anything) do
        if ((type(k) == "number") and ((k >= 1) and (k <= #anything))) then
            return "array"
        end
    end
    return "object"
end

function get_object_length(an_object)
    local object_length = 0
    for object_key, object_value in pairs(an_object) do
        object_length = object_length + 1
    end
    return object_length
end

spread_syntax_object = function(...)
    local parameters = {...}
    local new_object = {}
    for parameter_index, parameter in ipairs(parameters) do
        local parameter_type = get_type(parameter)
        if (parameter_type == "object") then
            for object_key, object_value in pairs(parameter) do
                new_object[object_key] = object_value
            end
            goto next
        end
        if (parameter_type == "array") then
            for array_item_index, array_item in ipairs(parameter) do
                new_object[tostring(array_item_index)] = array_item
            end
            goto next
        end
        ::next::
    end
    return new_object
end

spread_syntax_array = function(...)
    local parameters = {...}
    local new_array = {}
    for parameter_index, parameter in ipairs(parameters) do
        local parameter_type = get_type(parameter)
        if (parameter_type == "object") then
            local object_length = get_object_length(parameter)
            if (object_length == 1) then
                for object_key, object_value in pairs(parameter) do
                    table.insert(new_array, object_value)
                end
                goto next
            end
            table.insert(new_array, parameter)
            goto next
        end
        if (parameter_type == "array") then
            for array_item_index, array_item in ipairs(parameter) do
                table.insert(new_array, array_item)
            end
            goto next
        end
        ::next::
    end
    return new_array
end

print('\n-- JavaScript-like Spread Syntax (...) in Lua')

fruits = {"Mango", "Melon", "Banana"}
s_print("fruits: ", pretty_array_of_primitives(fruits))

vegetables = {"Carrot", "Tomato"}
s_print("vegetables: ", pretty_array_of_primitives(vegetables))

country_capitals_in_asia = {
    Thailand = "Bangkok",
    China = "Beijing",
    Japan = "Tokyo"
}
s_print("country_capitals_in_asia: ", pretty_json_stringify(country_capitals_in_asia))

country_capitals_in_europe = {
    France = "Paris",
    England = "London"
}
s_print("country_capitals_in_europe: ", pretty_json_stringify(country_capitals_in_europe))

print("\n-- [...array1, ...array2]:\n")

combination1 = spread_syntax_array(fruits, vegetables)
s_print("combination1: ", pretty_json_stringify(combination1))
-- combination1: [
--     "Mango",
--     "Melon",
--     "Banana",
--     "Carrot",
--     "Tomato"
-- ]

combination2 = spread_syntax_array(fruits, {"Cucumber", "Onions"})
s_print("combination2: ", pretty_json_stringify(combination2))
-- combination2: [
--     "Mango",
--     "Melon",
--     "Banana",
--     "Cucumber",
--     "Onions"
-- ]

print("\n-- { ...object1, ...object2 }:\n")

combination3 = spread_syntax_object(country_capitals_in_asia, country_capitals_in_europe)
s_print("combination3: ", pretty_json_stringify(combination3))
-- combination3: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "France": "Paris",
--     "England": "London"
-- }

combination4 = spread_syntax_object(country_capitals_in_asia, { Germany = "Berlin", Italy = "Rome" })
s_print("combination4: ", pretty_json_stringify(combination4))
-- combination4: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "Germany": "Berlin",
--     "Italy": "Rome"
-- }

print("\n-- [...array1, array2]:\n")

combination5 = spread_syntax_array(fruits, { vegetables = vegetables })
s_print("combination5: ", pretty_json_stringify(combination5))
-- combination5: [
--     "Mango",
--     "Melon",
--     "Banana",
--     [
--         "Carrot",
--         "Tomato"
--     ]
-- ]

combination6 = spread_syntax_array(fruits, { vegetables = {"Cucumber", "Onions"} })
s_print("combination6: ", pretty_json_stringify(combination6))
-- combination6: [
--     "Mango",
--     "Melon",
--     "Banana",
--     [
--         "Cucumber",
--         "Onions"
--     ]
-- ]

print("\n-- [...array1, object1]:\n")

combination7 = spread_syntax_array(fruits, { country_capitals_in_asia = country_capitals_in_asia })
s_print("combination7: ", pretty_json_stringify(combination7))
-- combination7: [
--     "Mango",
--     "Melon",
--     "Banana",
--     {
--         "Thailand": "Bangkok",
--         "China": "Beijing",
--         "Japan": "Tokyo"
--     }
-- ]

combination8 = spread_syntax_array(fruits, { country_capitals_in_europe = { Germany = "Berlin", Italy = "Rome" } })
s_print("combination8: ", pretty_json_stringify(combination8))
-- combination8: [
--     "Mango",
--     "Melon",
--     "Banana",
--     {
--         "Germany": "Berlin",
--         "Italy": "Rome"
--     }
-- ]

print("\n-- { ...object1, object2 }:\n")

combination9 = spread_syntax_object(country_capitals_in_asia, { country_capitals_in_europe = country_capitals_in_europe })
s_print("combination9: ", pretty_json_stringify(combination9))
-- combination9: {
--     "Thailand" : "Bangkok",
--     "China" : "Beijing",
--     "Japan" : "Tokyo",
--     "country_capitals_in_europe" : {
--        "France" : "Paris",
--        "England" : "London"
--     }
--  }

combination10 = spread_syntax_object(country_capitals_in_asia, { country_capitals_in_europe = { Germany = "Berlin", Italy = "Rome" } })
s_print("combination10: ", pretty_json_stringify(combination10))
-- combination10: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "country_capitals_in_europe": {
--         "Germany": "Berlin",
--         "Italy": "Rome"
--     }
-- }

print("\n-- { ...object1, array2 }:\n")

combination11 = spread_syntax_object(country_capitals_in_asia, { vegetables = vegetables })
s_print("combination11: ", pretty_json_stringify(combination11))
-- combination11: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "vegetables": [
--         "Carrot",
--         "Tomato"
--     ]
-- }

combination12 = spread_syntax_object(country_capitals_in_asia, { vegetables = {"Cucumber", "Onions"} })
s_print("combination12: ", pretty_json_stringify(combination12))
-- combination12: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "vegetables": [
--         "Cucumber",
--         "Onions"
--     ]
-- }

print("\n-- { ...object1, ...array2 }:\n")

combination13 = spread_syntax_object(country_capitals_in_asia, vegetables)
s_print("combination13: ", pretty_json_stringify(combination13))
-- combination13: {
--     "Thailand" : "Bangkok",
--     "China" : "Beijing",
--     "Japan" : "Tokyo",
--     "1" : "Carrot",
--     "2" : "Tomato"
--  }

combination14 = spread_syntax_object(country_capitals_in_asia, {"Cucumber", "Onions"})
s_print("combination14: ", pretty_json_stringify(combination14))
-- combination14: {
--     "Thailand" : "Bangkok",
--     "China" : "Beijing",
--     "Japan" : "Tokyo",
--     "1" : "Cucumber",
--     "2" : "Onions"
--  }

-- print("\n-- [...array1, ...object1]: -- this combination throw an error in JavaScript\n")

-- this combination throw an error in JavaScript
-- combination_error_in_javascript1 = spread_syntax_array(fruits, country_capitals_in_asia)
-- s_print("combination_error_in_javascript1: ", pretty_json_stringify(combination_error_in_javascript1))

-- this combination throw an error in JavaScript
-- combination_error_in_javascript2 = spread_syntax_array(fruits, { Germany = "Berlin", Italy = "Rome" })
-- s_print("combination_error_in_javascript2: ", pretty_json_stringify(combination_error_in_javascript2))
