struct js_like_type_julia_struct
    Null::Any
    Boolean::Any
    String::Any
    Numeric::Any
    Object::Any
    Array::Any
    Function::Any
end

js_like_type = js_like_type_julia_struct("Null", "Boolean", "String", "Numeric", "Object", "Array", "Function")

function is_like_js_null(anything::Any)::Any
    return ((anything === nothing) && (isnothing(anything) === true))::Any
end

function is_like_js_boolean(anything::Any)::Any
    return ((isa(anything, Bool) === true) && ((anything === true) || (anything === false)))::Any
end

function is_like_js_string(anything::Any)::Any
    return (isa(anything, AbstractString) === true)::Any
end

function is_like_js_numeric(anything::Any)::Any
    return (isa(anything, Number) === true)::Any
end

function is_like_js_object(anything::Any)::Any
    return (isa(anything, Dict{String, Any}) === true)::Any
end

function is_like_js_array(anything::Any)::Any
    return ((isa(anything, Array{Any, 1}) === true) && (isa(anything, Vector{Any}) === true))::Any
end

function is_like_js_function(anything::Any)::Any
    return (isa(anything, Function) === true)::Any
end

function get_type(anything::Any)::Any
    return (((is_like_js_null(anything) === true) ? ((js_like_type.Null)::Any) : ((is_like_js_boolean(anything) === true) ? ((js_like_type.Boolean)::Any) : ((is_like_js_string(anything) === true) ? ((js_like_type.String)::Any) : ((is_like_js_numeric(anything) === true) ? ((js_like_type.Numeric)::Any) : ((is_like_js_object(anything) === true) ? ((js_like_type.Object)::Any) : ((is_like_js_array(anything) === true) ? ((js_like_type.Array)::Any) : ((is_like_js_function(anything) === true) ? ((js_like_type.Function)::Any) : (("$(supertype(typeof(anything)))")::Any)))))))))::Any
end

function json_stringify(anything::Any; pretty::Any=false)::Any
    # custom JSON.stringify() function
    local indent::Any = repeat(" ", 4)
    local indent_level::Any = 0
    function json_stringify_inner(anything_inner::Any)::Any
        local anything_inner_type::Any = get_type(anything_inner)
        if (anything_inner_type === js_like_type.Null) return ("null")::Any end
        if (anything_inner_type === js_like_type.String) return ("\"$(anything_inner)\"")::Any end
        if ((anything_inner_type === js_like_type.Numeric) || (anything_inner_type === js_like_type.Boolean)) return ("$(anything_inner)")::Any end
        if (anything_inner_type === js_like_type.Array)
            return ((() -> begin
                if (length(anything_inner) === 0) return ("[]")::Any end
                indent_level += 1
                local result::Any = ((pretty === true) ? "[\n$(repeat(indent, indent_level))" : "[")
                for (array_item_index, array_item) in enumerate(anything_inner)
                    result *= json_stringify_inner(array_item)
                    if (array_item_index !== length(anything_inner))
                        result *= ((pretty === true) ? ",\n$(repeat(indent, indent_level))" : ", ")
                    end
                end
                indent_level -= 1
                result *= ((pretty === true) ? "\n$(repeat(indent, indent_level))]" : "]")
                return (result)::Any
            end)())::Any
        end
        if (anything_inner_type === js_like_type.Object)
            return ((() -> begin
                if (length(anything_inner) === 0) return ("{}")::Any end
                indent_level += 1
                local result::Any = ((pretty === true) ? "{\n$(repeat(indent, indent_level))" : "{ ")
                for (object_entry_index, (object_key, object_value)) in enumerate(pairs(anything_inner))
                    result *= "\"$(object_key)\": $(json_stringify_inner(object_value))"
                    if (object_entry_index !== length(anything_inner))
                        result *= ((pretty === true) ? ",\n$(repeat(indent, indent_level))" : ", ")
                    end
                end
                indent_level -= 1
                result *= ((pretty === true) ? "\n$(repeat(indent, indent_level))}" : " }")
                return (result)::Any
            end)())::Any
        end
        if (anything_inner_type === js_like_type.Function) return ("[object Function]")::Any end
        return (anything_inner_type)::Any
    end
    return (json_stringify_inner(anything))::Any
end

function array_entries(any_array::Any)::Any
    return (Dict{String, Any}("$(array_item_index)" => array_item for (array_item_index, array_item) in enumerate(any_array)))::Any
end

function array_find(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.find() function array_find_v4
    for (array_item_index, array_item) in enumerate(any_array)
        if (callback_function(array_item, array_item_index, any_array) === true) return (array_item)::Any end
    end
    return (nothing)::Any
end

println("\n# JavaScript-like Spread Syntax (...) in Julia (Splat Operator)")

fruits::Any = Vector{Any}(["Mango", "Melon", "Banana"])
println("fruits: $(json_stringify(fruits))")

vegetables::Any = Vector{Any}(["Carrot", "Tomato"])
println("vegetables: $(json_stringify(vegetables))")

country_capitals_in_asia::Any = Dict{String, Any}(
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
)
println("country_capitals_in_asia: $(json_stringify(country_capitals_in_asia, pretty=true))")

country_capitals_in_europe::Any = Dict{String, Any}(
    "France" => "Paris",
    "England" => "London"
)
println("country_capitals_in_europe: $(json_stringify(country_capitals_in_europe, pretty=true))")

println("\n# [...array1, ...array2]:\n")

combination1::Any = Vector{Any}([fruits..., vegetables...])
println("combination1: $(json_stringify(combination1, pretty=true))")
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2::Any = Vector{Any}([fruits..., Vector{Any}(["Cucumber", "Cabbage"])...])
println("combination2: $(json_stringify(combination2, pretty=true))")
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Cabbage"
# ]

println("\n# { ...object1, ...object2 }:\n")

combination3::Any = Dict{String, Any}(country_capitals_in_asia..., country_capitals_in_europe...)
println("combination3: $(json_stringify(combination3, pretty=true))")
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4::Any = Dict{String, Any}(country_capitals_in_asia..., Dict{String, Any}("Germany" => "Berlin", "Italy" => "Rome")...)
println("combination4: $(json_stringify(combination4, pretty=true))")
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

println("\n# [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination5::Any = Vector{Any}([fruits..., vegetables])
println("combination5: $(json_stringify(combination5, pretty=true))")
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6::Any = Vector{Any}([fruits..., Vector{Any}(["Cucumber", "Cabbage"])])
println("combination6: $(json_stringify(combination6, pretty=true))")
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Cabbage"
#     ]
# ]

println("\n# [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination7::Any = Vector{Any}([fruits..., country_capitals_in_asia])
println("combination7: $(json_stringify(combination7, pretty=true))")
# combination7: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Thailand": "Bangkok",
#         "China": "Beijing",
#         "Japan": "Tokyo"
#     }
# ]

combination8::Any = Vector{Any}([fruits..., Dict{String, Any}("Germany" => "Berlin", "Italy" => "Rome")])
println("combination8: $(json_stringify(combination8, pretty=true))")
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

println("\n# { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n")

combination9::Any = Dict{String, Any}(country_capitals_in_asia..., "country_capitals_in_europe" => country_capitals_in_europe)
println("combination9: $(json_stringify(combination9, pretty=true))")
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

combination10::Any = Dict{String, Any}(country_capitals_in_asia..., "country_capitals_in_europe" => Dict{String, Any}("Germany" => "Berlin", "Italy" => "Rome"))
println("combination10: $(json_stringify(combination10, pretty=true))")
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

println("\n# { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n")

combination11::Any = Dict{String, Any}(country_capitals_in_asia..., "vegetables" => vegetables)
println("combination11: $(json_stringify(combination11, pretty=true))")
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12::Any = Dict{String, Any}(country_capitals_in_asia..., "vegetables" => Vector{Any}(["Cucumber", "Cabbage"]))
println("combination12: $(json_stringify(combination12, pretty=true))")
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Cabbage"
#     ]
# }

println("\n# { ...object1, ...array2 }:\n")

combination13::Any = Dict{String, Any}(country_capitals_in_asia..., array_entries(vegetables)...)
println("combination13: $(json_stringify(combination13, pretty=true))")
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Carrot",
#    "2" : "Tomato"
# }

combination14::Any = Dict{String, Any}(country_capitals_in_asia..., array_entries(["Cucumber", "Cabbage"])...)
println("combination14: $(json_stringify(combination14, pretty=true))")
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Cucumber",
#    "2" : "Cabbage"
# }

# println("\n# [...array1, ...object1]: // this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combination_error_in_javascript1::Any = Vector{Any}([fruits..., country_capitals_in_asia...])
# println("combination_error_in_javascript1: $(json_stringify(combination_error_in_javascript1, pretty=true))")

# this combination throw an error in JavaScript
# combination_error_in_javascript2::Any = Vector{Any}([fruits..., Dict{String, Any}("Germany" => "Berlin", "Italy" => "Rome")...])
# println("combination_error_in_javascript2: $(json_stringify(combination_error_in_javascript2, pretty=true))")
