using Printf
using Statistics
using JSON

println("\n# JavaScript-like Nullish Coalescing Operator (??) in Julia")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Julia.
# But, we can create our own function to mimic it in Julia.

# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v2 = (an_object, object_properties_strin) -> reduce((current_result, current_item) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), split(object_properties_string, "."); init=nothing)

# JavaScript-like Nullish Coalescing Operator (??) function
nullish_coalescing = (anything, default_value) -> ((anything === nothing) ? default_value : anything)

JSON_OBJECT = Dict(
    "foo" => Dict(
        "bar" => "baz"
    )
)
println("JSON_OBJECT: ", JSON.json(JSON_OBJECT, 4))

println("# using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

println("JSON_OBJECT?.foo?.bar ?? \"not found\": ", nullish_coalescing(optional_chaining_v2(JSON_OBJECT, "foo.bar"), "not found"))
# JSON_OBJECT?.foo?.bar ?? "not found": baz

println("JSON_OBJECT?.foo?.baz ?? \"not found\": ", nullish_coalescing(optional_chaining_v2(JSON_OBJECT, "foo.baz"), "not found"))
# JSON_OBJECT?.foo?.baz ?? "not found": not found
