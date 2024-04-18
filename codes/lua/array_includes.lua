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

-- There's no JavaScript-like Array.includes() in Lua.
-- But, we can create our own function to mimic it in Lua.

function array_includes_v1(search_element, an_array)
    -- JavaScript-like Array.includes() function
    local is_element_found = false
    for _, array_item in ipairs(an_array) do
        if (array_item == search_element) then
            is_element_found = true
            break
        end
    end
    return is_element_found
end

function array_includes_v2(search_element, an_array)
    -- JavaScript-like Array.includes() function
    for _, array_item in ipairs(an_array) do
        if (array_item == search_element) then
            return true
        end
    end
    return false
end

print('\n-- JavaScript-like Array.includes() in Lua')

my_friends = {"Alisa", "Trivia"}
sprint("my friends: ", json_stringify(my_friends))

print("-- using JavaScript-like Array.includes() function \"array_includes_v1\"")

a_name = "Alisa"
is_my_friend = array_includes_v1(a_name, my_friends)
sprint("is my friends includes ", "\"", a_name, "\"", ": ", is_my_friend)
-- is my friends includes "Alisa": true

a_name = "Trivia"
is_my_friend = array_includes_v1(a_name, my_friends)
sprint("is my friends includes ", "\"", a_name, "\"", ": ", is_my_friend)
-- is my friends includes "Trivia": true

a_name = "Tony"
is_my_friend = array_includes_v1(a_name, my_friends)
sprint("is my friends includes ", "\"", a_name, "\"", ": ", is_my_friend)
-- is my friends includes "Tony": false

a_name = "Ezekiel"
is_my_friend = array_includes_v1(a_name, my_friends)
sprint("is my friends includes ", "\"", a_name, "\"", ": ", is_my_friend)
-- is my friends includes "Ezekiel": false

print("-- using JavaScript-like Array.includes() function \"array_includes_v2\"")

a_name = "Alisa"
is_my_friend = array_includes_v2(a_name, my_friends)
sprint("is my friends includes ", "\"", a_name, "\"", ": ", is_my_friend)
-- is my friends includes "Alisa": true

a_name = "Trivia"
is_my_friend = array_includes_v2(a_name, my_friends)
sprint("is my friends includes ", "\"", a_name, "\"", ": ", is_my_friend)
-- is my friends includes "Trivia": true

a_name = "Tony"
is_my_friend = array_includes_v2(a_name, my_friends)
sprint("is my friends includes ", "\"", a_name, "\"", ": ", is_my_friend)
-- is my friends includes "Tony": false

a_name = "Ezekiel"
is_my_friend = array_includes_v2(a_name, my_friends)
sprint("is my friends includes ", "\"", a_name, "\"", ": ", is_my_friend)
-- is my friends includes "Ezekiel": false
