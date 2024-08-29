function json_stringify(anything; pretty::Bool = false, indent::String = "    ")::String
    indent_level::Any = 0
    function json_stringify_inner(anything_inner, indent_inner::String)::String
        if (anything_inner === nothing) return "null" end
        if (isa(anything_inner, AbstractString) === true) return "\"$(anything_inner)\"" end
        if ((isa(anything_inner, Number) === true) || (isa(anything_inner, Bool) === true)) return "$(anything_inner)" end
        if (isa(anything_inner, Array) === true)
            if (length(anything_inner) == 0) return "[]" end
            indent_level += 1
            result_array::Any = ((pretty === true) ? "[\n$(repeat(indent_inner, indent_level))" : "[")
            for (array_item_index, array_item) in enumerate(anything_inner)
                result_array *= json_stringify_inner(array_item, indent_inner)
                if (array_item_index !== length(anything_inner)) result_array *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result_array *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))]" : "]")
            return result_array
        end
        if (isa(anything_inner, Dict) === true)
            if (length(anything_inner) == 0) return "{}" end
            indent_level += 1
            result_object::Any = ((pretty === true) ? "{\n$(repeat(indent_inner, indent_level))" : "{")
            for (object_entry_index, (object_key, object_value)) in enumerate(pairs(anything_inner))
                result_object *= "\"$(object_key)\": $(json_stringify_inner(object_value, indent_inner))"
                if (object_entry_index !== length(anything_inner)) result_object *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result_object *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))}" : "}")
            return result_object
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
array_includes_v2::Any = (search_element, an_array) -> (search_element in an_array)

println("\n# JavaScript-like Array.includes() in Julia")

my_friends::Any = Any["Alisa", "Trivia"]
println("my friends: ", json_stringify(my_friends))

println("# using JavaScript-like Array.includes() function \"array_includes_v1\"")

a_name::Any = "Alisa"
is_my_friend::Any = array_includes_v1(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Alisa": true

a_name::Any = "Trivia"
is_my_friend::Any = array_includes_v1(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Trivia": true

a_name::Any = "Tony"
is_my_friend::Any = array_includes_v1(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Tony": true

a_name::Any = "Ezekiel"
is_my_friend::Any = array_includes_v1(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Ezekiel": true

println("# using JavaScript-like Array.includes() function \"array_includes_v2\"")

a_name::Any = "Alisa"
is_my_friend::Any = array_includes_v2(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Alisa": true

a_name::Any = "Trivia"
is_my_friend::Any = array_includes_v2(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Trivia": true

a_name::Any = "Tony"
is_my_friend::Any = array_includes_v2(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Tony": true

a_name::Any = "Ezekiel"
is_my_friend::Any = array_includes_v2(a_name, my_friends)
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Ezekiel": true

println("# using Julia \"in\" operator")

a_name::Any = "Alisa"
is_my_friend::Any = a_name in my_friends
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Alisa": true

a_name::Any = "Trivia"
is_my_friend::Any = a_name in my_friends
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Trivia": true

a_name::Any = "Tony"
is_my_friend::Any = a_name in my_friends
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Tony": true

a_name::Any = "Ezekiel"
is_my_friend::Any = a_name in my_friends
println("is my friends includes \"$a_name\": $is_my_friend")
# is my friends includes "Ezekiel": true
