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

-- There's no JavaScript-like Array.every() in Lua.
-- But, we can create our own function to mimic it in Lua.

function array_every_v1(callback_function, an_array)
    -- JavaScript-like Array.every() function
    local is_condition_match = true
    for array_item_index, array_item in ipairs(an_array) do
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == false) then
            break
        end
    end
    return is_condition_match
end

function array_every_v2(callback_function, an_array)
    -- JavaScript-like Array.every() function
    local is_condition_match = true
    for array_item_index, array_item in ipairs(an_array) do
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == false) then
            return is_condition_match
        end
    end
    return is_condition_match
end

function array_every_v3(callback_function, an_array)
    -- JavaScript-like Array.every() function
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == false) then
            return false
        end
    end
    return true
end

function array_every_v4(callback_function, an_array)
    -- JavaScript-like Array.every() function
    for array_item_index, array_item in ipairs(an_array) do
        if (callback_function(array_item, array_item_index, an_array) == false) then
            return false
        end
    end
    return true
end

print("\n-- JavaScript-like Array.every() in table")

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
sprint("numbers: ", json_stringify(numbers))

print("-- using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_number_less_than_500 = array_every_v1(function (number) return (number < 500) end, numbers)
sprint("is all number < 500: ", is_all_number_less_than_500)
-- is all number < 500: true

is_all_number_more_than_500 = array_every_v1(function (number) return (number > 500) end, numbers)
sprint("is all number > 500: ", is_all_number_more_than_500)
-- is all number > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_number_less_than_500 = array_every_v2(function (number) return (number < 500) end, numbers)
sprint("is all number < 500: ", is_all_number_less_than_500)
-- is all number < 500: true

is_all_number_more_than_500 = array_every_v2(function (number) return (number > 500) end, numbers)
sprint("is all number > 500: ", is_all_number_more_than_500)
-- is all number > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_number_less_than_500 = array_every_v3(function (number) return (number < 500) end, numbers)
sprint("is all number < 500: ", is_all_number_less_than_500)
-- is all number < 500: true

is_all_number_more_than_500 = array_every_v3(function (number) return (number > 500) end, numbers)
sprint("is all number > 500: ", is_all_number_more_than_500)
-- is all number > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_number_less_than_500 = array_every_v4(function (number) return (number < 500) end, numbers)
sprint("is all number < 500: ", is_all_number_less_than_500)
-- is all number < 500: true

is_all_number_more_than_500 = array_every_v4(function (number) return (number > 500) end, numbers)
sprint("is all number > 500: ", is_all_number_more_than_500)
-- is all number > 500: false

print("\n-- JavaScript-like Array.every() in table of hash-tables")

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

print("-- using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_product_price_less_than_500 = array_every_v1(function (product) return (product.price < 500) end, products)
sprint("is all product price < 500: ", is_all_product_price_less_than_500)
-- is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v1(function (product) return (product.price > 500) end, products)
sprint("is all product price > 500: ", is_all_product_price_more_than_500)
-- is all product price > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_product_price_less_than_500 = array_every_v2(function (product) return (product.price < 500) end, products)
sprint("is all product price < 500: ", is_all_product_price_less_than_500)
-- is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v2(function (product) return (product.price > 500) end, products)
sprint("is all product price > 500: ", is_all_product_price_more_than_500)
-- is all product price > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_product_price_less_than_500 = array_every_v3(function (product) return (product.price < 500) end, products)
sprint("is all product price < 500: ", is_all_product_price_less_than_500)
-- is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v3(function (product) return (product.price > 500) end, products)
sprint("is all product price > 500: ", is_all_product_price_more_than_500)
-- is all product price > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_product_price_less_than_500 = array_every_v4(function (product) return (product.price < 500) end, products)
sprint("is all product price < 500: ", is_all_product_price_less_than_500)
-- is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v4(function (product) return (product.price > 500) end, products)
sprint("is all product price > 500: ", is_all_product_price_more_than_500)
-- is all product price > 500: false
