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

-- in Lua, JavaScript-like Array is called table

fruits = {"apple", "mango", "orange"}
sprint("fruits: ", json_stringify(fruits))

sprint("fruits, length: ", #fruits)
-- fruits, length: 3

sprint("fruits, get mango: ", fruits[2])
-- fruits, get mango: mango

sprint("fruits, first element: ", fruits[1])
-- fruits, first element: apple

sprint("fruits, last element: ", fruits[#fruits])
-- fruits, last element: orange

for array_item_index, array_item in ipairs(fruits) do
    sprint("fruits, for for loop, index: ", array_item_index, ", value: ", array_item)
end
-- fruits, for for loop, index: 1, value: apple
-- fruits, for for loop, index: 2, value: mango
-- fruits, for for loop, index: 3, value: orange

-- in Lua, JavaScript-like Array of Objects is called table of hash-tables

products = {
    {
        id = "P1",
        name = "bubble gum"
    },
    {
        id = "P1",
        name = "bubble gum"
    }
}
sprint("products: ", json_stringify(products, { pretty = true }))

for array_item_index, array_item in ipairs(products) do
    object_iteration_index = 0
    for object_key, object_value in pairs(array_item) do
        sprint("products, for loop, array item index: ", array_item_index, ", object iteration/entry index: ", object_iteration_index, ", key: ", object_key, ", value: ", object_value)
        object_iteration_index = object_iteration_index + 1
    end
end
-- products, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P1
-- products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: bubble gum
-- products, for loop, array item index: 2, object iteration/entry index: 0, key: id, value: P1
-- products, for loop, array item index: 2, object iteration/entry index: 1, key: name, value: bubble gum
