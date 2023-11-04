using Printf
using Statistics
using JSON

println("\n# JavaScript-like Optional Chaining Operator (?.) in Julia")

# There's no JavaScript-like Optional Chaining Operator (?.) in Julia.
# But, we can create our own function to mimic it in Julia.

# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v1 = (an_object, object_properties_array...) -> reduce((current_result, current_item) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), object_properties_array; init=nothing)

# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v2 = (an_object, object_properties_strin) -> reduce((current_result, current_item) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), split(object_properties_string, "."); init=nothing)

JSON_OBJECT = Dict(
    "foo" => Dict(
        "bar" => "baz"
    )
)
println("JSON_OBJECT: ", JSON.json(JSON_OBJECT, 4))

println("# using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v1\"")

println("JSON_OBJECT?.foo?.bar: ", optional_chaining_v1(JSON_OBJECT, "foo", "bar"))
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", optional_chaining_v1(JSON_OBJECT, "foo", "baz"))
# JSON_OBJECT?.foo?.baz: nothing

println("# using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v2\"")

println("JSON_OBJECT?.foo?.bar: ", optional_chaining_v2(JSON_OBJECT, "foo.bar"))
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", optional_chaining_v2(JSON_OBJECT, "foo.baz"))
# JSON_OBJECT?.foo?.baz: nothing
