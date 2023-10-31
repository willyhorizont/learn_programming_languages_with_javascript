using Printf
using Statistics

pretty_array_of_primitives = (an_array_of_primitives) -> string("[", join(an_array_of_primitives, ", "), "]")

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
println("name: ", "\"", name, "\"")
is_my_friend = array_includes_v1(name, my_friends)
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Alisa": true

name = "Tony"
println("name: ", "\"", name, "\"")
is_my_friend = array_includes_v1(name, my_friends)
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Tony": true

name = "Ezekiel"
println("name: ", "\"", name, "\"")
is_my_friend = array_includes_v1(name, my_friends)
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Ezekiel": true

println("# using JavaScript-like Array.includes() function \"array_includes_v2\"")

name = "Alisa"
println("name: ", "\"", name, "\"")
is_my_friend = array_includes_v2(name, my_friends)
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Alisa": true

name = "Tony"
println("name: ", "\"", name, "\"")
is_my_friend = array_includes_v2(name, my_friends)
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Tony": true

name = "Ezekiel"
println("name: ", "\"", name, "\"")
is_my_friend = array_includes_v2(name, my_friends)
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Ezekiel": true

println("# using Julia \"in\" keyword")

name = "Alisa"
println("name: ", "\"", name, "\"")
is_my_friend = name in my_friends
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Alisa": true

name = "Tony"
println("name: ", "\"", name, "\"")
is_my_friend = name in my_friends
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Tony": true

name = "Ezekiel"
println("name: ", "\"", name, "\"")
is_my_friend = name in my_friends
println("is my friends includes ", "\"", name, "\"", ": ", is_my_friend)
# is my friends includes "Ezekiel": true
