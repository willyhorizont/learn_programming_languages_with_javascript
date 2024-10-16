using JSON

get_type::Any = (anything::Any) -> begin
    if (is_like_js_null(anything) === true) return js_like_type.Null end
    if (is_like_js_boolean(anything) === true) return js_like_type.Boolean end
    if (is_like_js_string(anything) === true) return js_like_type.String end
    if (is_like_js_numeric(anything) === true) return js_like_type.Numeric end
    if (is_like_js_object(anything) === true) return js_like_type.Object end
    if (is_like_js_array(anything) === true) return js_like_type.Array end
    if (is_like_js_function(anything) === true) return js_like_type.Function end
    return '"' * typeof(anything) * '"'
end

function json_stringify(anything::Any; pretty::Bool = false, indent::String = "    ")::String
    indent_level::Any = 0
    function json_stringify_inner(anything_inner, indent_inner::String)::String
        if (anything_inner === nothing) return "null" end
        if (isa(anything_inner, AbstractString) === true) return "\"$(anything_inner)\"" end
        if ((isa(anything_inner, Number) === true) || (isa(anything_inner, Bool) === true)) return "$(anything_inner)" end
        if (isa(anything_inner, Array) === true)
            if (length(anything_inner) === 0) return "[]" end
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
            if (length(anything_inner) === 0) return "{}" end
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

fruits::Any = Any["Mango", "Melon", "Banana"]
println("fruits: ", json_stringify(fruits))

vegetables::Any = Any["Carrot", "Tomato"]
println("vegetables: ", replace(JSON.json(vegetables), "," => ", "))

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
println("country_capitals_in_europe: ", chomp(JSON.json(country_capitals_in_europe, 4)))

#= 
 == 
Array
change Any[] to Vector{Any}([])
", json_stringify
", [a-z_]+
catch([^e]
println.*,
[ ]+[a-z]+ = 
((() -> begin
end)())::Any
-> begin
\$[a-z_]+
=#
