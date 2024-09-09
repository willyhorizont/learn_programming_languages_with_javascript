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

println("\n# JavaScript-like Object.keys() in Julia Dictionary")

friend::Any = Dict{String, Any}(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)
println("friend: ", json_stringify(friend, pretty=true))

println("# using Julia Array comprehension and Julia Object.keys() built-in function \"keys(an_object)\"")

println("friend keys: ", json_stringify(Array{Any}([object_key for object_key in keys(friend)])))
# friend keys: ["name", "country", "age"]

println("# using Julia Array spread syntax (...) and Julia Object.keys() built-in function \"keys(an_object)\"")

println("friend keys: ", json_stringify(Array{Any}([keys(friend)...])))
# friend keys: ["name", "country", "age"]

println("# using composition of Julia built-in functions \"collect(keys(an_object))\"")

println("friend keys: ", json_stringify(Array{Any}(collect(keys(friend)))))
# friend keys: ["name", "country", "age"]
