function sprint(...)
    local rest_arguments = {...}
    local new_array = {}
    for _, argument in ipairs(rest_arguments) do
        table.insert(new_array, tostring(argument))
    end
    print(table.concat(new_array, ""))
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
    for object_key, object_value in pairs(anything) do
        if ((type(object_key) == "number") and ((object_key >= 1) and (object_key <= #anything))) then return "array" end
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

function json_stringify(anything, argument_object)
    argument_object = argument_object or {}
    local pretty = argument_object["pretty"]
    local indent = argument_object["indent"]
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

print('\n-- JavaScript-like Optional Chaining Operator (?.) in Lua')

-- There's no JavaScript-like Optional Chaining Operator (?.) in Lua.
-- But, we don't need that in Lua.

JSON_OBJECT = {
    foo = {
        bar = "baz",
    },
    fruits = {"apple", "mango", "banana"},
    get_rectangle_area = function(rectangle_width, rectangle_length) return (rectangle_width * rectangle_length) end
}
sprint("JSON_OBJECT: ", json_stringify(JSON_OBJECT, { pretty = true }))

sprint("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ", json_stringify(JSON_OBJECT["foo"]["bar"]))
-- JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

sprint("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ", json_stringify(JSON_OBJECT["foo"]["baz"]))
-- JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

sprint("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ", json_stringify(JSON_OBJECT["fruits"][2]))
-- JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "mango"

sprint("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ", json_stringify(JSON_OBJECT["fruits"][5]))
-- JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null

optional_chaining = function (callback_function)
    local is_not_error, result = xpcall(callback_function, function (an_error_message) return nil end)
    return result
end

print("fruits[2]:", optional_chaining(function () return JSON_OBJECT["fruits"][2] end))
print("fruits[5]:", optional_chaining(function () return JSON_OBJECT["fruits"][5] end))
print("get_circle_area:", optional_chaining(function () return JSON_OBJECT["get_circle_area"](7) end))
