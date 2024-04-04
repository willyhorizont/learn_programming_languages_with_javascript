JSON = (loadfile "../../utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

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
        if (anything_inner == nil) then return nil end
        if (type_of(anything_inner) == "string") then return ("\"" .. anything_inner .. "\"") end
        if (type_of(anything_inner) == "number" or type_of(anything_inner) == "boolean") then return tostring(anything_inner) end
        if (type_of(anything_inner) == "array") then
            if (#anything_inner == 1) then return "[]" end
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
            if (object_keys_length == 1) then return "{}" end
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

--declare variables
boolVal = true;
int_value = 1024;
stringVal = "hello world";
floatVal = 12.90;
nilVal = nil;

--display the data type returned for each declared value.
sprint(type(boolVal) == "boolean");
sprint(type(int_value) == "number");
sprint(type(stringVal) == "string");
sprint(type(floatVal) == "number");
sprint(type(nilVal) == "nil");
sprint(nil);

my_array = { "a", "b", "c" }
my_object = { a1 = "asd", a2 = "zxc", a3 = "qwe" }
for key, value in pairs(my_array) do
    sprint("pairs(my_array), ", "key: ", key, ", value: ", value)
end
for index, value in ipairs(my_array) do
    sprint("ipairs(my_array), ", "index: ", index, ", value: ", value)
end
for key, value in pairs(my_object) do
    sprint("pairs(my_object), ", "key: ", key, ", value: ", value)
end
for index, value in ipairs(my_object) do
    sprint("ipairs(my_object), ", "index: ", index, ", value: ", value)
end

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

fruits = {"Mango", "Melon", "Banana"}
sprint("fruits: ", json_stringify(fruits, { pretty = true }))

vegetables = {"Carrot", "Tomato"}
sprint("vegetables: ", pretty_json_stringify(vegetables))

country_capitals_in_asia = {
    Thailand = "Bangkok",
    China = "Beijing",
    Japan = "Tokyo"
}
sprint("country_capitals_in_asia: ", json_stringify(country_capitals_in_asia, { pretty = true }))
sprint("country_capitals_in_asia[Singapore]: ", country_capitals_in_asia["Singapore"] == nil)

country_capitals_in_europe = {
    France = "Paris",
    England = "London"
}
sprint("country_capitals_in_europe: ", pretty_json_stringify(country_capitals_in_europe))

do_something = function(--[[required]]var1, --[[optional]]var2,  --[[optional]]var3)
    var2 = var2 or 6 --default value
    var3 = var3 or "Melon" --default value
    --Do something with the inputs
end
fruit = "Mango"
do_something("asd", { var3 = fruit })
sprint(fruit)
