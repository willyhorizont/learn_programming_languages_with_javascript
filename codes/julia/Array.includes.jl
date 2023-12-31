using Printf
using Statistics

function pretty_array_of_primitives(an_array_of_primitives)
    result = "["
    for (array_item_index, array_item) in enumerate(an_array_of_primitives)
        if ((isa(array_item, AbstractString) === false) && (isa(array_item, Number) === false))
            continue
        end
        if (isa(array_item, AbstractString) === true)
            result = string(result, "\"", array_item, "\"")
        end
        if (isa(array_item, Number) === true)
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

name = "Alisa"
println("name: \"$name\"")
is_my_friend = array_includes_v1(name, my_friends)
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Alisa": true

name = "Trivia"
println("name: \"$name\"")
is_my_friend = array_includes_v1(name, my_friends)
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Trivia": true

name = "Tony"
println("name: \"$name\"")
is_my_friend = array_includes_v1(name, my_friends)
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Tony": true

name = "Ezekiel"
println("name: \"$name\"")
is_my_friend = array_includes_v1(name, my_friends)
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Ezekiel": true

println("# using JavaScript-like Array.includes() function \"array_includes_v2\"")

name = "Alisa"
println("name: \"$name\"")
is_my_friend = array_includes_v2(name, my_friends)
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Alisa": true

name = "Trivia"
println("name: \"$name\"")
is_my_friend = array_includes_v2(name, my_friends)
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Trivia": true

name = "Tony"
println("name: \"$name\"")
is_my_friend = array_includes_v2(name, my_friends)
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Tony": true

name = "Ezekiel"
println("name: \"$name\"")
is_my_friend = array_includes_v2(name, my_friends)
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Ezekiel": true

println("# using Julia \"in\" operator")

name = "Alisa"
println("name: \"$name\"")
is_my_friend = name in my_friends
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Alisa": true

name = "Trivia"
println("name: \"$name\"")
is_my_friend = name in my_friends
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Trivia": true

name = "Tony"
println("name: \"$name\"")
is_my_friend = name in my_friends
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Tony": true

name = "Ezekiel"
println("name: \"$name\"")
is_my_friend = name in my_friends
println("is my friends includes \"$name\": $is_my_friend")
# is my friends includes "Ezekiel": true
