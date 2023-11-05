-- There's no JavaScript-like Array.includes() in Lua.
-- But, we can create our own function to mimic it in Lua.

function pretty_array_of_primitives(an_array_of_primitives)
    local result = "["
    for array_item_index, array_item in ipairs(an_array_of_primitives) do
        if type(array_item) ~= "string" and type(array_item) ~= "number" then
            goto next
        end
        if type(array_item) == "string" then
            result = result .. "\"" .. array_item .. "\""
        end
        if type(array_item) == "number" then
            result = result .. array_item
        end
        if array_item_index ~= #an_array_of_primitives then
            result = result .. ", "
        end
        ::next::
    end
    result = result .. "]"
    return result
end

function array_includes_v1(search_element, an_array)
    -- JavaScript-like Array.includes() function
    local element_found = false
    for _, array_item in ipairs(an_array) do
        local is_condition_match = array_item == search_element
        if is_condition_match == true then
            element_found = true
            break
        end
    end
    return element_found
end

function array_includes_v2(search_element, an_array)
    -- JavaScript-like Array.includes() function
    local element_found = false
    for _, array_item in ipairs(an_array) do
        if array_item == search_element then
            element_found = true
            break
        end
    end
    return element_found
end

function array_includes_v3(search_element, an_array)
    -- JavaScript-like Array.includes() function
    local element_found = false
    for _, array_item in ipairs(an_array) do
        local is_condition_match = array_item == search_element
        if is_condition_match == true then
            element_found = true
            return element_found
        end
    end
    return element_found
end

function array_includes_v4(search_element, an_array)
    -- JavaScript-like Array.includes() function
    local element_found = false
    for _, array_item in ipairs(an_array) do
        if array_item == search_element then
            element_found = true
            return element_found
        end
    end
    return element_found
end

function array_includes_v5(search_element, an_array)
    -- JavaScript-like Array.includes() function
    for _, array_item in ipairs(an_array) do
        local is_condition_match = array_item == search_element
        if is_condition_match == true then
            return true
        end
    end
    return false
end

function array_includes_v6(search_element, an_array)
    -- JavaScript-like Array.includes() function
    for _, array_item in ipairs(an_array) do
        if array_item == search_element then
            return true
        end
    end
    return false
end

print('\n-- JavaScript-like Array.includes() in Lua')

my_friends = {"Alisa", "Trivia"}
print("my friends: " .. pretty_array_of_primitives(my_friends))

print("-- using JavaScript-like Array.includes() function \"array_includes_v1\"")

name = "Alisa"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v1(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Alisa": true

name = "Trivia"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v1(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Trivia": true

name = "Tony"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v1(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Tony": false

name = "Ezekiel"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v1(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Ezekiel": false

print("-- using JavaScript-like Array.includes() function \"array_includes_v2\"")

name = "Alisa"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v2(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Alisa": true

name = "Trivia"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v2(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Trivia": true

name = "Tony"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v2(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Tony": false

name = "Ezekiel"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v2(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Ezekiel": false

print("-- using JavaScript-like Array.includes() function \"array_includes_v3\"")

name = "Alisa"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v3(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Alisa": true

name = "Trivia"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v3(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Trivia": true

name = "Tony"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v3(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Tony": false

name = "Ezekiel"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v3(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Ezekiel": false

print("-- using JavaScript-like Array.includes() function \"array_includes_v4\"")

name = "Alisa"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v4(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Alisa": true

name = "Trivia"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v4(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Trivia": true

name = "Tony"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v4(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Tony": false

name = "Ezekiel"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v4(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Ezekiel": false

print("-- using JavaScript-like Array.includes() function \"array_includes_v5\"")

name = "Alisa"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v5(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Alisa": true

name = "Trivia"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v5(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Trivia": true

name = "Tony"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v5(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Tony": false

name = "Ezekiel"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v5(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Ezekiel": false

print("-- using JavaScript-like Array.includes() function \"array_includes_v6\"")

name = "Alisa"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v6(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Alisa": true

name = "Trivia"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v6(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Trivia": true

name = "Tony"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v6(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Tony": false

name = "Ezekiel"
print("name: " .. "\"" .. name .. "\"")
is_my_friend = array_includes_v6(name, my_friends)
print("is my friends includes " .. "\"" .. name .. "\"" .. ":" .. tostring(is_my_friend))
-- is my friends includes "Ezekiel": false
