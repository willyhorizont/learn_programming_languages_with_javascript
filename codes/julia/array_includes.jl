function pretty_array_of_primitives(an_array_of_primitives)
    result = "["
    for (array_item_index, array_item) in enumerate(an_array_of_primitives)
        if ((isa(array_item, AbstractString) === false) && (isa(array_item, Number) === false) && (isa(array_item, Bool) === false) && array_item !== nothing)
            continue
        end
        if (isa(array_item, AbstractString) === true)
            result = string(result, "\"", array_item, "\"")
        end
        if (array_item === nothing)
            result = string(result, "null")
        end
        if ((isa(array_item, Number) === true) || (isa(array_item, Bool) === true))
            result = string(result, array_item)
        end
        if (array_item_index !== length(an_array_of_primitives))
            result = string(result, ", ")
        end
    end
    result = string(result, "]")
    return result
end

function array_includes_v1(search_element, an_array)
    # JavaScript-like Array.includes() function
    return search_element in an_array
end

# JavaScript-like Array.includes() function
array_includes_v2 = (search_element, an_array) -> (search_element in an_array)

println("\n# JavaScript-like Array.includes() in Julia")

my_friends = ["Alisa", "Trivia"]
println("my friends: ", pretty_array_of_primitives(my_friends))

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
