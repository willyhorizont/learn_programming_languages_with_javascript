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

function array_to_object(an_array)
    new_object::Any = Dict{String, Any}()
    for (array_item_index, array_item) in enumerate(an_array)
        new_object[string(array_item_index)] = array_item
    end
    return new_object
end

println("\n# JavaScript-like Spread Syntax (...) in Julia")

fruits::Any = Any["Mango", "Melon", "Banana"]
println("fruits: ", json_stringify(fruits))

vegetables::Any = Any["Carrot", "Tomato"]
println("vegetables: ", json_stringify(vegetables))

country_capitals_in_asia::Any = Dict{String, Any}(
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
)
println("country_capitals_in_asia: ", json_stringify(country_capitals_in_asia, pretty=true))

country_capitals_in_europe::Any = Dict{String, Any}(
    "France" => "Paris",
    "England" => "London"
)
println("country_capitals_in_europe: ", json_stringify(country_capitals_in_europe, pretty=true))

println("# [...array1, ...array2]:\n")

combination1::Any = Any[fruits..., vegetables...]
println("combination1: ", json_stringify(combination1, pretty=true))
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2::Any = Any[fruits..., Any["Cucumber", "Cabbage"]...]
println("combination2: ", json_stringify(combination2, pretty=true))
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Cabbage"
# ]

println("# { ...object1, ...object2 }:\n")

combination3::Any = Dict{String, Any}(country_capitals_in_asia..., country_capitals_in_europe...)
println("combination3: ", json_stringify(combination3, pretty=true))
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4::Any = Dict{String, Any}(country_capitals_in_asia..., Dict{String, Any}("Germany" => "Berlin", "Italy" => "Rome")...)
println("combination4: ", json_stringify(combination4, pretty=true))
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

println("# [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination5::Any = Any[fruits..., vegetables]
println("combination5: ", json_stringify(combination5, pretty=true))
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6::Any = Any[fruits..., Any["Cucumber", "Cabbage"]]
println("combination6: ", json_stringify(combination6, pretty=true))
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Cabbage"
#     ]
# ]

println("# [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination7::Any = Any[fruits..., country_capitals_in_asia]
println("combination7: ", json_stringify(combination7, pretty=true))
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

combination8::Any = Any[fruits..., Dict{String, Any}("Germany" => "Berlin", "Italy" => "Rome")]
println("combination8: ", json_stringify(combination8, pretty=true))
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

println("# { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n")

combination9::Any = Dict{String, Any}(country_capitals_in_asia..., "country_capitals_in_europe" => country_capitals_in_europe)
println("combination9: ", json_stringify(combination9, pretty=true))
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
println("combination10: ", json_stringify(combination10, pretty=true))
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

println("# { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n")

combination11::Any = Dict{String, Any}(country_capitals_in_asia..., "vegetables" => vegetables)
println("combination11: ", json_stringify(combination11, pretty=true))
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12::Any = Dict{String, Any}(country_capitals_in_asia..., "vegetables" => Any["Cucumber", "Cabbage"])
println("combination12: ", json_stringify(combination12, pretty=true))
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Cabbage"
#     ]
# }

println("# { ...object1, ...array2 }:\n")

combination13::Any = Dict{String, Any}(country_capitals_in_asia..., array_to_object(vegetables)...)
println("combination13: ", json_stringify(combination13, pretty=true))
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Carrot",
#    "2" : "Tomato"
# }

combination14::Any = Dict{String, Any}(country_capitals_in_asia..., array_to_object(["Cucumber", "Cabbage"])...)
println("combination14: ", json_stringify(combination14, pretty=true))
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Cucumber",
#    "2" : "Cabbage"
# }

# println("# [...array1, ...object1]: // this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combination_error_in_javascript1::Any = Any[fruits..., country_capitals_in_asia...]
# println("combination_error_in_javascript1: ", json_stringify(combination_error_in_javascript1, pretty=true))

# this combination throw an error in JavaScript
# combination_error_in_javascript2::Any = Any[fruits..., Dict{String, Any}("Germany" => "Berlin", "Italy" => "Rome")...]
# println("combination_error_in_javascript2: ", json_stringify(combination_error_in_javascript2, pretty=true))
