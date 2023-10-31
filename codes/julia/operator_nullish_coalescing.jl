using Printf
using Statistics
using JSON

println("\n# JavaScript-like Nullish Coalescing Operator (??) in Julia")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Julia.
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
qmd = (an_object=Dict(), object_properties_string="") -> array_reduce((current_result, current_item, _, _) -> ((current_result === nothing) ? get(an_object, current_item, nothing) : get(current_result, current_item, nothing)), split(object_properties_string, "."), nothing)

function nullish_coalescing(an_object=Dict(), object_properties_string="", default_value=nothing)
    # JavaScript-like Nullish Coalescing Operator (??) function
    value = qmd(an_object, object_properties_string)
    return ((value === nothing) ? default_value : value)
end

JSON_OBJECT = Dict(
    "foo" => Dict(
        "bar" => "baz"
    )
)
println("JSON_OBJECT: ", JSON.json(JSON_OBJECT, 4))

println("# using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

println("JSON_OBJECT?.foo?.bar: ", nullish_coalescing(JSON_OBJECT, "foo.bar", "not found"))
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", nullish_coalescing(JSON_OBJECT, "foo.baz", "not found"))
# JSON_OBJECT?.foo?.baz: not found

println("change JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\" to \"dqm\" to make it shorter")

# dqm stands for double question mark / Nullish Coalescing Operator (??)
dqm = nullish_coalescing

println("JSON_OBJECT?.foo?.bar: ", dqm(JSON_OBJECT, "foo.bar", "not found"))
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", dqm(JSON_OBJECT, "foo.baz", "not found"))
# JSON_OBJECT?.foo?.baz: not found
