js_like_type = { ["Null"] = "Null", ["Boolean"] = "Boolean", ["String"] = "String", ["Numeric"] = "Numeric", ["Object"] = "Object", ["Array"] = "Array", ["Function"] = "Function" }

array_reduce = function (callback_function, an_array, initial_value)
    -- JavaScript-like Array.reduce() function
    local result = initial_value
    for array_item_index, array_item in ipairs(an_array) do
        result = callback_function(result, array_item, array_item_index, an_array)
    end
    return result
end

string_repeat = function (a_string, times)
    local result = ""
    for i = 1, times, 1 do -- start, stop, step
        result = result .. a_string
    end
    return result
end

ternary = function (true_condition, callback_function_if_condition_true, callback_function_if_condition_false)
    if (true_condition == true) then return callback_function_if_condition_true() end
    return callback_function_if_condition_false()
end

is_like_js_null = function (anything) return (type(anything) == "nil") end

is_like_js_boolean = function (anything) return (type(anything) == "boolean") end

is_like_js_string = function (anything) return (type(anything) == "string") end

is_like_js_numeric = function (anything) return (type(anything) == "number") end

is_like_js_function = function (anything) return (type(anything) == "function") end

is_like_js_object = function (anything)
    if (type(anything) ~= "table") then return false end
    for object_key, object_value in pairs(anything) do
        if ((type(object_key) == "number") and ((object_key >= 1) and (object_key <= #anything))) then return false end
    end
    if (next(anything) == nil) then return false end
    return true
end

is_like_js_array = function (anything)
    if (type(anything) ~= "table") then return false end
    for object_key, object_value in pairs(anything) do
        if ((type(object_key) == "number") and ((object_key >= 1) and (object_key <= #anything))) then return true end
    end
    if (next(anything) == nil) then return true end
    return false
end

get_type = function (anything) return (
    ternary((is_like_js_null(anything) == true),
        (function () return js_like_type["Null"] end),
        (function () return (
            ternary((is_like_js_boolean(anything) == true),
                (function () return js_like_type["Boolean"] end),
                (function () return (
                    ternary((is_like_js_string(anything) == true),
                        (function () return js_like_type["String"] end),
                        (function () return (
                            ternary((is_like_js_numeric(anything) == true),
                                (function () return js_like_type["Numeric"] end),
                                (function () return (
                                    ternary((is_like_js_object(anything) == true),
                                        (function () return js_like_type["Object"] end),
                                        (function () return (
                                            ternary((is_like_js_array(anything) == true),
                                                (function () return js_like_type["Array"] end),
                                                (function () return (
                                                    ternary((is_like_js_function(anything) == true),
                                                        (function () return js_like_type["Function"] end),
                                                        (function () return type(anything) end)
                                                    )
                                                ) end)
                                            )
                                        ) end)
                                    )
                                ) end)
                            )
                        ) end)
                    )
                ) end)
            )
        ) end)
    )
) end

optional_chaining = function (callback_function)
    local is_not_error, result = xpcall(callback_function, (function (an_error_message) return nil end))
    return result
end

nullish_coalescing = function (anything, default_value) return (ternary((get_type(anything) == js_like_type["Null"]), (function () return default_value end), (function () return anything end))) end

object_keys = function (an_object)
    local new_array = {}
    for object_key, object_value in pairs(an_object) do
        table.insert(new_array, object_key)
    end
    return new_array
end

json_stringify = function (anything, optional_keyword_argument_object)
    optional_keyword_argument_object = nullish_coalescing(optional_keyword_argument_object, {})
    local pretty = optional_chaining(function () return optional_keyword_argument_object["pretty"] end)
    pretty = ternary((get_type(pretty) == js_like_type["Null"]), (function () return false end), (function () return pretty end))
    local indent_default = string_repeat(" ", 4)
    local indent_level = 0
    local json_stringify_inner
    json_stringify_inner = function (anything_inner)
        local anything_inner_type = get_type(anything_inner)
        if (anything_inner_type == js_like_type["Null"]) then return "null" end
        if (anything_inner_type == js_like_type["String"]) then return ('"' .. anything_inner .. '"') end
        if ((anything_inner_type == js_like_type["Numeric"]) or (anything_inner_type == js_like_type["Boolean"])) then return tostring(anything_inner) end
        if (anything_inner_type == js_like_type["Object"]) then
            local object_keys_array_length = #object_keys(anything_inner)
            if (object_keys_array_length == 0) then return "{}" end
            indent_level = indent_level + 1
            local result = ternary((pretty == true), (function () return ("{\n" .. string_repeat(indent_default, indent_level)) end), (function () return "{ " end))
            local object_entry_index = 1
            for object_key, object_value in pairs(anything_inner) do
                result = result .. '"' .. object_key .. '": ' .. json_stringify_inner(object_value)
                if (object_entry_index ~= object_keys_array_length) then
                    result = result .. ternary((pretty == true), (function () return (",\n" .. string_repeat(indent_default, indent_level)) end), (function () return ", " end))
                end
                object_entry_index = object_entry_index + 1
            end
            indent_level = indent_level - 1
            result = result .. ternary((pretty == true), (function () return ("\n" .. string_repeat(indent_default, indent_level) .. "}") end), (function () return " }" end))
            return result
        end
        if (anything_inner_type == js_like_type["Array"]) then
            if (#anything_inner == 0) then return "[]" end
            indent_level = indent_level + 1
            local result = ternary((pretty == true), (function () return ("[\n" .. string_repeat(indent_default, indent_level)) end), (function () return "[" end))
            for array_item_index, array_item in ipairs(anything_inner) do
                result = result .. json_stringify_inner(array_item)
                if (array_item_index ~= #anything_inner) then
                    result = result .. ternary((pretty == true), (function () return (",\n" .. string_repeat(indent_default, indent_level)) end), (function () return ", " end))
                end
            end
            indent_level = indent_level - 1
            result = result .. ternary((pretty == true), (function () return ("\n" .. string_repeat(indent_default, indent_level) .. "]") end), (function () return "]" end))
            return result
        end
        if (anything_inner_type == js_like_type["Function"]) then return "[object Function]" end
        return anything_inner_type
    end
    return json_stringify_inner(anything)
end

string_interpolation = function (...)
    local rest_arguments = {...}
    return (array_reduce(function (current_result, current_argument)
        local current_argument_type = get_type(current_argument)
        return (current_result .. (ternary((current_argument_type == js_like_type["String"]), (function () return current_argument end), (function () return (ternary(((current_argument_type == js_like_type["Array"]) and (#current_argument == 1)), (function () return json_stringify(optional_chaining(function () return current_argument[1] end)) end), (function () return json_stringify(current_argument) end))) end))))
    end, rest_arguments, ""))
end

console_log = function (...)
    print(string_interpolation(...))
end

something = "foo"
console_log(string_interpolation("something: ", json_stringify(something, { ["pretty"] = true })))
something = 123
console_log(string_interpolation("something: ", json_stringify(something, { ["pretty"] = true })))
something = true
console_log(string_interpolation("something: ", json_stringify(something, { ["pretty"] = true })))
something = nil
console_log(string_interpolation("something: ", json_stringify(something, { ["pretty"] = true })))
something = {1, 2, 3}
console_log(string_interpolation("something: ", json_stringify(something, { ["pretty"] = true })))
something = { ["foo"] = "bar" }
console_log(string_interpolation("something: ", json_stringify(something, { ["pretty"] = true })))
