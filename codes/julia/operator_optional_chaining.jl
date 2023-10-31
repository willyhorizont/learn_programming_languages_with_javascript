using Printf
using Statistics
using JSON

println("\n# JavaScript-like Optional Chaining Operator (?.) in Julia")

# There's no JavaScript-like Optional Chaining Operator (?.) in Julia.
# But, we can create our own function to mimic it in Julia.

function array_reduce(callback_function, an_array, initial_value)
    # JavaScript-like Array.reduce() function
    result = nothing
    for (array_item_index, array_item) in enumerate(an_array)
        result = ((result === nothing) ? initial_value : result)
        if isa(initial_value, AbstractArray)
            result = ((result === nothing) ? [] : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if isa(initial_value, AbstractDict)
            result = ((result === nothing) ? Dict() : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if isa(initial_value, Number)
            result = ((result === nothing) ? 0 : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if isa(initial_value, AbstractString)
            result = ((result === nothing) ? "" : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if isa(initial_value, Bool)
            result = ((result === nothing) ? false : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if initial_value === nothing
            result = ((result === nothing) ? nothing : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
    end
    return result
end

# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v1 = (an_object=Dict(), object_properties_array...) -> array_reduce((current_result, current_item, _, _) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), object_properties_array, nothing)

# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v2 = (an_object=Dict(), object_properties_array...) -> reduce((current_result, current_item) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), object_properties_array; init=nothing)

# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v3 = (an_object=Dict(), object_properties_string="") -> array_reduce((current_result, current_item, _, _) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), split(object_properties_string, "."), nothing)

# JavaScript-like Optional Chaining Operator (?.) function
optional_chaining_v4 = (an_object=Dict(), object_properties_string="") -> reduce((current_result, current_item) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), split(object_properties_string, "."); init=nothing)

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
# JSON_OBJECT?.foo?.baz: baz

println("# using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v2\"")

println("JSON_OBJECT?.foo?.bar: ", optional_chaining_v2(JSON_OBJECT, "foo", "bar"))
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", optional_chaining_v2(JSON_OBJECT, "foo", "baz"))
# JSON_OBJECT?.foo?.baz: baz

println("# using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v3\"")

println("JSON_OBJECT?.foo?.bar: ", optional_chaining_v3(JSON_OBJECT, "foo.bar"))
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", optional_chaining_v3(JSON_OBJECT, "foo.baz"))
# JSON_OBJECT?.foo?.baz: baz

println("# using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v4\"")

println("JSON_OBJECT?.foo?.bar: ", optional_chaining_v4(JSON_OBJECT, "foo.bar"))
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", optional_chaining_v4(JSON_OBJECT, "foo.baz"))
# JSON_OBJECT?.foo?.baz: baz

println("change JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v9\" to \"qmd\" to make it shorter")

# qmd stands for question mark dot / Optional Chaining Operator (?.)
qmd = optional_chaining_v3

println("JSON_OBJECT?.foo?.bar: ", qmd(JSON_OBJECT, "foo.bar"))
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", qmd(JSON_OBJECT, "foo.baz"))
# JSON_OBJECT?.foo?.baz: baz
