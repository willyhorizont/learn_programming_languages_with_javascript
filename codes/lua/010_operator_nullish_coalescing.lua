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

print('\n-- JavaScript-like Nullish Coalescing Operator (??) in Lua')

-- JavaScript-like Nullish Coalescing Operator (??) function
function nullish_coalescing(anything, default_value) if (anything == nil) then return default_value else return anything end end

JSON_OBJECT = {
    foo = {
        bar = "baz",
    },
    fruits = {"apple", "mango", "banana"}
}
sprint("JSON_OBJECT: ", json_stringify(JSON_OBJECT, { pretty = true }))

print("-- using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

sprint("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", json_stringify(nullish_coalescing(JSON_OBJECT["foo"]["bar"], "not found")))
-- (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"

sprint("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", json_stringify(nullish_coalescing(JSON_OBJECT["foo"]["baz"], "not found")))
-- (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

sprint("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", json_stringify(nullish_coalescing(JSON_OBJECT["fruits"][2], "not found")))
-- (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "mango"

sprint("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", json_stringify(nullish_coalescing(JSON_OBJECT["fruits"][5], "not found")))
-- (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"

print("-- using Lua built-in operator \"or\"")

sprint("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", json_stringify(JSON_OBJECT["foo"]["bar"] or "not found"))
-- (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"

sprint("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", json_stringify(JSON_OBJECT["foo"]["baz"] or "not found"))
-- (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

sprint("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", json_stringify(JSON_OBJECT["fruits"][2] or "not found"))
-- (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "mango"

sprint("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", json_stringify(JSON_OBJECT["fruits"][5] or "not found"))
-- (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"
