-- There's no JavaScript-like Array.includes() in Lua.
-- But, we can create our own function to mimic it in Lua.

function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

function pretty_array_of_primitives(an_array_of_primitives)
    local result = "["
    for array_item_index, array_item in ipairs(an_array_of_primitives) do
        if ((type(array_item) ~= "string") and (type(array_item) ~= "number") and (type(array_item) ~= "boolean") and (array_item ~= "nil")) then
            goto next
        end
        if (array_item == "nil") then
            result = result .. "null"
        end
        if ((type(array_item) == "string") and (array_item ~= "nil")) then
            result = result .. "\"" .. array_item .. "\""
        end
        if (type(array_item) == "number") then
            result = result .. array_item
        end
        if (type(array_item) == "boolean") then
            result = result .. tostring(array_item)
        end
        if (array_item_index ~= #an_array_of_primitives) then
            result = result .. ", "
        end
        ::next::
    end
    result = result .. "]"
    return result
end

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
sprint("my friends: ", pretty_array_of_primitives(my_friends))

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
