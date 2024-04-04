function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

function string_repeat(a_string, count)
    local result = ""
    for i = 1, count, 1 do -- start, stop, step
        result = result .. a_string
    end
    return result
end

function type_of(anything)
    if (type(anything) ~= "table") then return type(anything) end
    if (next(anything) == nil) then return "array" end
    for key, value in pairs(anything) do
        if ((type(key) == "number") and ((key >= 1) and (key <= #anything))) then return "array" end
    end
    return "object"
end

function object_keys(an_object)
    local new_array = {}
    for object_key, object_value in pairs(an_object) do
        table.insert(new_array, object_key)
    end
    return new_array
end

function json_stringify(anything, parameter_object)
    parameter_object = parameter_object or {}
    local pretty = parameter_object["pretty"]
    local indent = parameter_object["indent"]
    pretty = ((pretty == nil) and false or pretty)
    indent = ((indent == nil) and "    " or indent)
    local indent_level = 0
    function json_stringify_inner(anything_inner, indent_inner)
        if (anything_inner == nil) then return "null" end
        if (type_of(anything_inner) == "string") then return ("\"" .. anything_inner .. "\"") end
        if (type_of(anything_inner) == "number" or type_of(anything_inner) == "boolean") then return tostring(anything_inner) end
        if (type_of(anything_inner) == "array") then
            if (#anything_inner == 0) then return "[]" end
            indent_level = indent_level + 1
            local result = ((pretty == true) and ("[\n" .. string_repeat(indent_inner, indent_level)) or "[")
            for array_item_index, array_item in ipairs(anything_inner) do
                result = result .. json_stringify_inner(array_item, indent_inner)
                if (array_item_index ~= #anything_inner) then result = result .. ((pretty == true) and (",\n" .. string_repeat(indent_inner, indent_level)) or ", ") end
            end
            indent_level = indent_level - 1
            result = result .. ((pretty == true) and ("\n" .. string_repeat(indent_inner, indent_level) .. "]") or "]")
            return result
        end
        if (type_of(anything_inner) == "object") then
            local object_keys_length = #object_keys(anything_inner)
            if (object_keys_length == 0) then return "{}" end
            indent_level = indent_level + 1
            local result = ((pretty == true) and ("{\n" .. string_repeat(indent_inner, indent_level)) or "{")
            local object_iteration_index = 0
            for object_key, object_value in pairs(anything_inner) do
                result = result .. "\"" .. object_key .. "\": " .. json_stringify_inner(object_value, indent_inner)
                if ((object_iteration_index + 1) ~= object_keys_length) then result = result .. ((pretty == true) and (",\n" .. string_repeat(indent_inner, indent_level)) or ", ") end
                object_iteration_index = object_iteration_index + 1
            end
            indent_level = indent_level - 1
            result = result .. ((pretty == true) and ("\n" .. string_repeat(indent_inner, indent_level) .. "}") or "}")
            return result
        end
        return "null"
    end
    return json_stringify_inner(anything, indent)
end

-- There's no JavaScript-like Spread Syntax (...) in Lua.
-- But, we can create our own function to mimic it in Lua.

spread_object = function(...)
    local parameters = {...}
    local new_object = {}
    for parameter_index, parameter in ipairs(parameters) do
        local parameter_type = type_of(parameter)
        if (parameter_type == "object") then
            local object_iteration_index = 0
            for object_key, object_value in pairs(parameter) do
                new_object[object_key] = object_value
                object_iteration_index = object_iteration_index + 1
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

spread_array = function(...)
    local parameters = {...}
    local new_array = {}
    for parameter_index, parameter in ipairs(parameters) do
        local parameter_type = type_of(parameter)
        if (parameter_type == "object") then
            if (#object_keys(parameter) == 1) then
                local object_iteration_index = 0
                for object_key, object_value in pairs(parameter) do
                    table.insert(new_array, object_value)
                    object_iteration_index = object_iteration_index + 1
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
sprint("fruits: ", json_stringify(fruits))

vegetables = {"Carrot", "Tomato"}
sprint("vegetables: ", json_stringify(vegetables))

country_capitals_in_asia = {
    Thailand = "Bangkok",
    China = "Beijing",
    Japan = "Tokyo"
}
sprint("country_capitals_in_asia: ", json_stringify(country_capitals_in_asia, { pretty = true }))

country_capitals_in_europe = {
    France = "Paris",
    England = "London"
}
sprint("country_capitals_in_europe: ", json_stringify(country_capitals_in_europe, { pretty = true }))

print("\n-- [...array1, ...array2]:\n")

combination1 = spread_array(fruits, vegetables)
sprint("combination1: ", json_stringify(combination1, { pretty = true }))
-- combination1: [
--     "Mango",
--     "Melon",
--     "Banana",
--     "Carrot",
--     "Tomato"
-- ]

combination2 = spread_array(fruits, {"Cucumber", "Cabbage"})
sprint("combination2: ", json_stringify(combination2, { pretty = true }))
-- combination2: [
--     "Mango",
--     "Melon",
--     "Banana",
--     "Cucumber",
--     "Cabbage"
-- ]

print("\n-- { ...object1, ...object2 }:\n")

combination3 = spread_object(country_capitals_in_asia, country_capitals_in_europe)
sprint("combination3: ", json_stringify(combination3, { pretty = true }))
-- combination3: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "France": "Paris",
--     "England": "London"
-- }

combination4 = spread_object(country_capitals_in_asia, { Germany = "Berlin", Italy = "Rome" })
sprint("combination4: ", json_stringify(combination4, { pretty = true }))
-- combination4: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "Germany": "Berlin",
--     "Italy": "Rome"
-- }

print("\n-- [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination5 = spread_array(fruits, { vegetables = vegetables })
sprint("combination5: ", json_stringify(combination5, { pretty = true }))
-- combination5: [
--     "Mango",
--     "Melon",
--     "Banana",
--     [
--         "Carrot",
--         "Tomato"
--     ]
-- ]

combination6 = spread_array(fruits, { vegetables = {"Cucumber", "Cabbage"} })
sprint("combination6: ", json_stringify(combination6, { pretty = true }))
-- combination6: [
--     "Mango",
--     "Melon",
--     "Banana",
--     [
--         "Cucumber",
--         "Cabbage"
--     ]
-- ]

print("\n-- [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination7 = spread_array(fruits, { country_capitals_in_asia = country_capitals_in_asia })
sprint("combination7: ", json_stringify(combination7, { pretty = true }))
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

combination8 = spread_array(fruits, { country_capitals_in_europe = { Germany = "Berlin", Italy = "Rome" } })
sprint("combination8: ", json_stringify(combination8, { pretty = true }))
-- combination8: [
--     "Mango",
--     "Melon",
--     "Banana",
--     {
--         "Germany": "Berlin",
--         "Italy": "Rome"
--     }
-- ]

print("\n-- { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n")

combination9 = spread_object(country_capitals_in_asia, { country_capitals_in_europe = country_capitals_in_europe })
sprint("combination9: ", json_stringify(combination9, { pretty = true }))
-- combination9: {
--     "Thailand" : "Bangkok",
--     "China" : "Beijing",
--     "Japan" : "Tokyo",
--     "country_capitals_in_europe" : {
--        "France" : "Paris",
--        "England" : "London"
--     }
--  }

combination10 = spread_object(country_capitals_in_asia, { country_capitals_in_europe = { Germany = "Berlin", Italy = "Rome" } })
sprint("combination10: ", json_stringify(combination10, { pretty = true }))
-- combination10: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "country_capitals_in_europe": {
--         "Germany": "Berlin",
--         "Italy": "Rome"
--     }
-- }

print("\n-- { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n")

combination11 = spread_object(country_capitals_in_asia, { vegetables = vegetables })
sprint("combination11: ", json_stringify(combination11, { pretty = true }))
-- combination11: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "vegetables": [
--         "Carrot",
--         "Tomato"
--     ]
-- }

combination12 = spread_object(country_capitals_in_asia, { vegetables = {"Cucumber", "Cabbage"} })
sprint("combination12: ", json_stringify(combination12, { pretty = true }))
-- combination12: {
--     "Thailand": "Bangkok",
--     "China": "Beijing",
--     "Japan": "Tokyo",
--     "vegetables": [
--         "Cucumber",
--         "Cabbage"
--     ]
-- }

print("\n-- { ...object1, ...array2 }:\n")

combination13 = spread_object(country_capitals_in_asia, vegetables)
sprint("combination13: ", json_stringify(combination13, { pretty = true }))
-- combination13: {
--     "Thailand" : "Bangkok",
--     "China" : "Beijing",
--     "Japan" : "Tokyo",
--     "1" : "Carrot",
--     "2" : "Tomato"
--  }

combination14 = spread_object(country_capitals_in_asia, {"Cucumber", "Cabbage"})
sprint("combination14: ", json_stringify(combination14, { pretty = true }))
-- combination14: {
--     "Thailand" : "Bangkok",
--     "China" : "Beijing",
--     "Japan" : "Tokyo",
--     "1" : "Cucumber",
--     "2" : "Cabbage"
--  }

-- print("\n-- [...array1, ...object1]: -- this combination throw an error in JavaScript\n")

-- this combination throw an error in JavaScript
-- combination_error_in_javascript1 = spread_array(fruits, country_capitals_in_asia)
-- sprint("combination_error_in_javascript1: ", json_stringify(combination_error_in_javascript1, { pretty = true }))

-- this combination throw an error in JavaScript
-- combination_error_in_javascript2 = spread_array(fruits, { Germany = "Berlin", Italy = "Rome" })
-- sprint("combination_error_in_javascript2: ", json_stringify(combination_error_in_javascript2, { pretty = true }))
