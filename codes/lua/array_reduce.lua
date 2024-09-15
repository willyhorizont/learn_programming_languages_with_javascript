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

spread_object = function(...)
    local rest_arguments = {...}
    local new_object = {}
    for argument_index, argument in ipairs(rest_arguments) do
        local argument_type = type_of(argument)
        if (argument_type == "object") then
            local object_iteration_index = 0
            for object_key, object_value in pairs(argument) do
                new_object[object_key] = object_value
                object_iteration_index = object_iteration_index + 1
            end
            goto next
        end
        if (argument_type == "array") then
            for array_item_index, array_item in ipairs(argument) do
                new_object[tostring(array_item_index)] = array_item
            end
            goto next
        end
        ::next::
    end
    return new_object
end

spread_array = function(...)
    local rest_arguments = {...}
    local new_array = {}
    for argument_index, argument in ipairs(rest_arguments) do
        local argument_type = type_of(argument)
        if (argument_type == "object") then
            if (#object_keys(argument) == 1) then
                local object_iteration_index = 0
                for object_key, object_value in pairs(argument) do
                    table.insert(new_array, object_value)
                    object_iteration_index = object_iteration_index + 1
                end
                goto next
            end
            table.insert(new_array, argument)
            goto next
        end
        if (argument_type == "array") then
            for array_item_index, array_item in ipairs(argument) do
                table.insert(new_array, array_item)
            end
            goto next
        end
        ::next::
    end
    return new_array
end

-- There's no JavaScript-like Array.reduce() in Lua.
-- But, we can create our own function to mimic it in Lua.

function array_reduce(callback_function, an_array, initial_value)
    -- JavaScript-like Array.reduce() function
    local result = initial_value
    for array_item_index, array_item in ipairs(an_array) do
        result = callback_function(result, array_item, array_item_index, an_array)
    end
    return result
end

print('\n-- JavaScript-like Array.reduce() in table')

numbers = {36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3}
sprint("numbers: ", json_stringify(numbers))

print("-- using JavaScript-like Array.reduce() function \"array_reduce\"")

numbers_total = array_reduce(function(current_result, current_number) return (current_result + current_number) end, numbers, 0)
sprint("total number: ", json_stringify(numbers_total, { pretty = true }))
-- total number: 41.2

print('\n-- JavaScript-like Array.reduce() in table of hash-tables')

products = {
    {
        code = "pasta",
        price = 321
    },
    {
        code = "bubble_gum",
        price = 233
    },
    {
        code = "potato_chips",
        price = 5
    },
    {
        code = "towel",
        price = 499
    }
}
sprint("products: ", json_stringify(products, { pretty = true }))

print("-- using JavaScript-like Array.reduce() function \"array_reduce\"")

products_grouped = array_reduce(function(current_result, current_product) return (((current_product.price > 100) and spread_object(current_result, { expensive = spread_array(current_result.expensive, { current_product = current_product }) })) or spread_object(current_result, { cheap = spread_array(current_result.cheap, { current_product = current_product }) })) end, products, { expensive = {}, cheap = {} })
sprint("grouped products: ", json_stringify(products_grouped, { pretty = true }))
-- grouped products: {
--     "expensive": [
--         {
--             "code": "pasta",
--             "price": 321
--         },
--         {
--             "code": "bubble_gum",
--             "price": 233
--         },
--         {
--             "code": "towel",
--             "price": 499
--         }
--     ],
--     "cheap": [
--         {
--             "code": "potato_chips",
--             "price": 5
--         }
--     ]
-- }
