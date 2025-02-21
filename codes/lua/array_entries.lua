js_like_type = { ["Null"] = "Null", ["Boolean"] = "Boolean", ["String"] = "String", ["Numeric"] = "Numeric", ["Object"] = "Object", ["Array"] = "Array", ["Function"] = "Function" }

function array_reduce(callback_function, any_array, initial_value)
    -- JavaScript-like Array.reduce() function
    local result = initial_value
    for array_item_index, array_item in ipairs(any_array) do
        result = callback_function(result, array_item, array_item_index, any_array)
    end
    return result
end

function string_repeat(any_string, repeat_times)
    local result = ""
    for i = 1, repeat_times, 1 do -- start, stop, step
        result = (result .. any_string)
    end
    return result
end

function ternary(is_condition_true, callback_function_if_condition_true, callback_function_if_condition_false)
    if (is_condition_true == true) then return callback_function_if_condition_true() end
    return callback_function_if_condition_false()
end

function is_like_js_null(anything) return (type(anything) == "nil") end

function is_like_js_boolean(anything) return (type(anything) == "boolean") end

function is_like_js_string(anything) return (type(anything) == "string") end

function is_like_js_numeric(anything) return (type(anything) == "number") end

function is_like_js_function(anything) return (type(anything) == "function") end

function is_like_js_object(anything)
    if (type(anything) ~= "table") then return false end
    for object_key, object_value in pairs(anything) do
        if ((type(object_key) == "number") and ((object_key >= 1) and (object_key <= #anything))) then return false end
    end
    if (next(anything) == nil) then return false end
    return true
end

function is_like_js_array(anything)
    if (type(anything) ~= "table") then return false end
    for object_key, object_value in pairs(anything) do
        if ((type(object_key) == "number") and ((object_key >= 1) and (object_key <= #anything))) then return true end
    end
    if (next(anything) == nil) then return true end
    return false
end

function get_type(anything) return (ternary((is_like_js_null(anything) == true), (function () return js_like_type["Null"] end), (function () return (ternary((is_like_js_boolean(anything) == true), (function () return js_like_type["Boolean"] end), (function () return (ternary((is_like_js_string(anything) == true), (function () return js_like_type["String"] end), (function () return (ternary((is_like_js_numeric(anything) == true), (function () return js_like_type["Numeric"] end), (function () return (ternary((is_like_js_object(anything) == true), (function () return js_like_type["Object"] end), (function () return (ternary((is_like_js_array(anything) == true), (function () return js_like_type["Array"] end), (function () return (ternary((is_like_js_function(anything) == true), (function () return js_like_type["Function"] end), (function () return type(anything) end))) end))) end))) end))) end))) end))) end))) end

function optional_chaining(callback_function)
    local is_success, result = xpcall(callback_function, (function (any_error_message) return nil end))
    return result
end

function nullish_coalescing(anything, default_value) return (ternary((get_type(anything) == js_like_type["Null"]), (function () return default_value end), (function () return anything end))) end

function object_keys(any_object)
    local new_array = {}
    for object_key, object_value in pairs(any_object) do
        table.insert(new_array, object_key)
    end
    return new_array
end

function json_stringify(anything, optional_keyword_argument_object)
    optional_keyword_argument_object_new = nullish_coalescing(optional_keyword_argument_object, {})
    local pretty = optional_chaining(function () return (optional_keyword_argument_object_new["pretty"]) end)
    pretty = ternary((get_type(pretty) == js_like_type["Null"]), (function () return false end), (function () return pretty end))
    local indent_default = string_repeat(" ", 4)
    local indent_level = 0
    function json_stringify_inner(anything_inner)
        if ((anything_inner == "nil") and (anything_inner == tostring(nil))) then return "null" end
        local anything_inner_type = get_type(anything_inner)
        if (anything_inner_type == js_like_type["Null"]) then return "null" end
        if (anything_inner_type == js_like_type["String"]) then return ('"' .. anything_inner .. '"') end
        if ((anything_inner_type == js_like_type["Numeric"]) or (anything_inner_type == js_like_type["Boolean"])) then return tostring(anything_inner) end
        if (anything_inner_type == js_like_type["Object"]) then
            local object_keys_array_length = #object_keys(anything_inner)
            if (object_keys_array_length == 0) then return "{}" end
            indent_level = (indent_level + 1)
            local result = ternary((pretty == true), (function () return ("{\n" .. string_repeat(indent_default, indent_level)) end), (function () return "{ " end))
            local object_entry_index = 1
            for object_key, object_value in pairs(anything_inner) do
                result = (result .. '"' .. object_key .. '": ' .. json_stringify_inner(object_value))
                if (object_entry_index ~= object_keys_array_length) then
                    result = (result .. ternary((pretty == true), (function () return (",\n" .. string_repeat(indent_default, indent_level)) end), (function () return ", " end)))
                end
                object_entry_index = (object_entry_index + 1)
            end
            indent_level = (indent_level - 1)
            result = (result .. ternary((pretty == true), (function () return ("\n" .. string_repeat(indent_default, indent_level) .. "}") end), (function () return " }" end)))
            return result
        end
        if (anything_inner_type == js_like_type["Array"]) then
            if (#anything_inner == 0) then return "[]" end
            indent_level = (indent_level + 1)
            local result = ternary((pretty == true), (function () return ("[\n" .. string_repeat(indent_default, indent_level)) end), (function () return "[" end))
            for array_item_index = 1, #anything_inner, 1 do -- start, stop, step
                local array_item = anything_inner[array_item_index]
                if (get_type(anything) == js_like_type["Null"]) then
                    result = (result .. "null")
                else
                    result = (result .. json_stringify_inner(array_item))
                end
                if (array_item_index ~= #anything_inner) then
                    result = (result .. ternary((pretty == true), (function () return (",\n" .. string_repeat(indent_default, indent_level)) end), (function () return ", " end)))
                end
            end
            indent_level = (indent_level - 1)
            result = (result .. ternary((pretty == true), (function () return ("\n" .. string_repeat(indent_default, indent_level) .. "]") end), (function () return "]" end)))
            return result
        end
        if (anything_inner_type == js_like_type["Function"]) then return "[object Function]" end
        return anything_inner_type
    end
    return json_stringify_inner(anything)
end

function string_interpolation(...)
    local rest_arguments = {...}
    return (array_reduce(function (current_result, current_argument)
        local current_argument_type = get_type(current_argument)
        return (current_result .. (ternary((current_argument_type == js_like_type["String"]), (function () return current_argument end), (function () return (ternary(((current_argument_type == js_like_type["Array"]) and (#current_argument == 0)), (function () return json_stringify(nil) end), (function () return (ternary(((current_argument_type == js_like_type["Array"]) and (#current_argument == 1)), (function () return json_stringify(optional_chaining(function () return (current_argument[1]) end)) end), (function () return json_stringify(current_argument) end))) end))) end))))
    end, rest_arguments, ""))
end

function console_log(...)
    print(string_interpolation(...))
end

function spread_object(...)
    local rest_arguments = {...}
    local new_object = {}
    for argument_index, argument in ipairs(rest_arguments) do
        local argument_type = get_type(argument)
        if (argument_type == js_like_type["Object"]) then
            local object_iteration_index = 1
            for object_key, object_value in pairs(argument) do
                new_object[object_key] = object_value
                object_iteration_index = (object_iteration_index + 1)
            end
            goto next_iteration
        end
        if (argument_type == js_like_type["Array"]) then
            for array_item_index, array_item in ipairs(argument) do
                new_object[tostring(array_item_index)] = array_item
            end
            goto next_iteration
        end
        ::next_iteration::
    end
    return new_object
end

function spread_array(...)
    local rest_arguments = {...}
    local new_array = {}
    for argument_index, argument in ipairs(rest_arguments) do
        local argument_type = get_type(argument)
        if (argument_type == js_like_type["Object"]) then
            if (#object_keys(argument) == 1) then
                local object_iteration_index = 1
                for object_key, object_value in pairs(argument) do
                    table.insert(new_array, object_value)
                    object_iteration_index = (object_iteration_index + 1)
                end
                goto next_iteration
            end
            table.insert(new_array, argument)
            goto next_iteration
        end
        if (argument_type == js_like_type["Array"]) then
            for array_item_index, array_item in ipairs(argument) do
                table.insert(new_array, array_item)
            end
            goto next_iteration
        end
        ::next_iteration::
    end
    return new_array
end

function array_every(callback_function, any_array)
    -- JavaScript-like Array.every() function array_every_v4
    for array_item_index, array_item in ipairs(any_array) do
        if (callback_function(array_item, array_item_index, any_array) == false) then return false end
    end
    return true
end

function array_filter(callback_function, any_array)
    -- JavaScript-like Array.filter() function array_filter_v2
    local data_filtered = {}
    for array_item_index, array_item in ipairs(any_array) do
        if (callback_function(array_item, array_item_index, any_array) == true) then
            table.insert(data_filtered, array_item)
        end
    end
    return data_filtered
end

function array_find_index(callback_function, any_array)
    -- JavaScript-like Array.findIndex() function array_find_index_v4
    for array_item_index, array_item in ipairs(any_array) do
        if (callback_function(array_item, array_item_index, any_array) == true) then return array_item_index end
    end
    return -1
end

function array_find(callback_function, any_array)
    -- JavaScript-like Array.find() function array_find_v4
    for array_item_index, array_item in ipairs(any_array) do
        if (callback_function(array_item, array_item_index, any_array) == true) then return array_item end
    end
    return nil
end

function array_includes(search_element, any_array)
    -- JavaScript-like Array.includes() function array_includes_v2
    for array_item_index, array_item in ipairs(any_array) do
        if (array_item == search_element) then return true end
    end
    return false
end

function array_entries(any_array)
    -- JavaScript-like Array.find() function
    local new_object_entries = {}
    for array_item_index, array_item in ipairs(any_array) do
        new_object_entries[tostring(array_item_index)] = array_item
    end
    return new_object_entries
end

function array_map(callback_function, any_array)
    -- JavaScript-like Array.map() function array_map_v2
    local new_array = {}
    for array_item_index, array_item in ipairs(any_array) do
        table.insert(new_array, callback_function(array_item, array_item_index, any_array))
    end
    return new_array
end

function array_some(callback_function, any_array)
    -- JavaScript-like Array.some() function array_some_v4
    for array_item_index, array_item in ipairs(any_array) do
        if (callback_function(array_item, array_item_index, any_array) == true) then return true end
    end
    return false
end

function object_from_entries(any_array)
    -- JavaScript-like Array.find() function
    local new_object = {}
    for array_item_index, array_item in ipairs(any_array) do
        local object_key = optional_chaining(function () return array_item[1] end)
        local object_value = optional_chaining(function () return array_item[2] end)
        new_object[tostring(object_key)] = object_value
    end
    return new_object
end

function object_entries(any_object)
    -- JavaScript-like Object.entries() function
    local new_array = {}
    for object_key, object_value in pairs(any_object) do
        table.insert(new_array, {object_key, object_value})
    end
    return new_array
end

function object_values(any_object)
    local new_array = {}
    for object_key, object_value in pairs(any_object) do
        table.insert(new_array, object_value)
    end
    return new_array
end

-- There's no JavaScript-like Array.entries() in Lua.
-- But, we can create our own function to mimic it in Lua.

console_log("\n-- JavaScript-like Array.entries() in Lua list")

fruits = {"apple", "banana", "cherry"}
console_log(string_interpolation("fruits: ", json_stringify(fruits, { ["pretty"] = true })))

console_log("-- using JavaScript-like Array.find() function \"array_entries\"")

console_log(string_interpolation("fruits entries: ", json_stringify(array_entries(fruits), { ["pretty"] = true })))
-- fruits entries: {
--     "1": "apple",
--     "2": "banana",
--     "3": "cherry"
-- }
