function json_stringify(anything; pretty::Bool = false, indent::String = "    ")::String
    indent_level = 0
    function json_stringify_inner(anything_inner, indent_inner::String)::String
        if (anything_inner === nothing) return "null" end
        if (isa(anything_inner, AbstractString) === true) return "\"$(anything_inner)\"" end
        if ((isa(anything_inner, Number) === true) || (isa(anything_inner, Bool) === true)) return "$(anything_inner)" end
        if (isa(anything_inner, Array) === true)
            if (length(anything_inner) == 0) return "[]" end
            indent_level += 1
            result = ((pretty === true) ? "[\n$(repeat(indent_inner, indent_level))" : "[")
            for (array_item_index, array_item) in enumerate(anything_inner)
                result *= json_stringify_inner(array_item, indent_inner)
                if (array_item_index !== length(anything_inner)) result *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))]" : "]")
            return result
        end
        if (isa(anything_inner, Dict) === true)
            if (length(anything_inner) == 0) return "{}" end
            indent_level += 1
            result = ((pretty === true) ? "{\n$(repeat(indent_inner, indent_level))" : "{")
            for (object_entry_index, (object_key, object_value)) in enumerate(pairs(anything_inner))
                result *= "\"$(object_key)\": $(json_stringify_inner(object_value, indent_inner))"
                if (object_entry_index !== length(anything_inner)) result *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))}" : "}")
            return result
        end
        return "null"
    end
    return json_stringify_inner(anything, indent)
end

function array_includes_v1(search_element, an_array)
    # JavaScript-like Array.includes() function
    return search_element in an_array
end

# JavaScript-like Array.includes() function
array_includes_v2 = (search_element, an_array) -> (search_element in an_array)

println("\n# JavaScript-like Array.includes() in Julia")

my_friends = ["Alisa", "Trivia"]
println("my friends: ", json_stringify(my_friends))

println("# using JavaScript-like Array.includes() function \"array_includes_v1\"")

a_name = "Alisa"
is_my_friend = array_includes_v1(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Alisa": true

a_name = "Trivia"
is_my_friend = array_includes_v1(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Trivia": true

a_name = "Tony"
is_my_friend = array_includes_v1(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Tony": true

a_name = "Ezekiel"
is_my_friend = array_includes_v1(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Ezekiel": true

println("# using JavaScript-like Array.includes() function \"array_includes_v2\"")

a_name = "Alisa"
is_my_friend = array_includes_v2(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Alisa": true

a_name = "Trivia"
is_my_friend = array_includes_v2(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Trivia": true

a_name = "Tony"
is_my_friend = array_includes_v2(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Tony": true

a_name = "Ezekiel"
is_my_friend = array_includes_v2(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Ezekiel": true

println("# using Julia \"in\" operator")

a_name = "Alisa"
is_my_friend = a_name in my_friends
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Alisa": true

a_name = "Trivia"
is_my_friend = a_name in my_friends
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Trivia": true

a_name = "Tony"
is_my_friend = a_name in my_friends
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Tony": true

a_name = "Ezekiel"
is_my_friend = a_name in my_friends
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Ezekiel": true
