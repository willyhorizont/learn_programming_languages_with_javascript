using Printf
using Statistics
using JSON

println("\n# JavaScript-like Nullish Coalescing Operator (??) in Julia")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Julia.
# But, we can create our own function to mimic it in Julia.

# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v2 = (an_object, object_properties_strin) -> reduce((current_result, current_item) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), split(object_properties_string, "."); init=nothing)

function nullish_coalescing(an_object, object_properties_string, default_value)
    # JavaScript-like Nullish Coalescing Operator (??) function
    value = optional_chaining_v2(an_object, object_properties_string)
    return ((value === nothing) ? default_value : value)
end

JSON_OBJECT = Dict(
    "foo" => Dict(
        "bar" => "baz"
    )
)
println("JSON_OBJECT: ", JSON.json(JSON_OBJECT, 4))

println("# using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

println("JSON_OBJECT?.foo?.bar ?? \"not found\": ", nullish_coalescing(JSON_OBJECT, "foo.bar", "not found"))
# JSON_OBJECT?.foo?.bar ?? "not found": baz

println("JSON_OBJECT?.foo?.baz ?? \"not found\": ", nullish_coalescing(JSON_OBJECT, "foo.baz", "not found"))
# JSON_OBJECT?.foo?.baz ?? "not found": not found
