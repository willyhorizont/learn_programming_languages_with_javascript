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

# There's no JavaScript-like Object.entries() in Julia.
# But, we can use Julia Array comprehension and Julia built-in function "pairs" to mimic it in Julia.

function object_entries(an_object)
    # JavaScript-like Object.entries() function
    new_array::Any = Any[]
    for (object_entry_index, (object_key, object_value)) in enumerate(pairs(an_object))
        new_array = Any[new_array..., Any[object_key, object_value]]
    end
    return new_array
end

println("\n# JavaScript-like Object.entries() in Julia Dictionary")

friend::Any = Dict{String, Any}(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)
println("friend: ", json_stringify(friend, pretty=true))

println("# using Julia Array comprehension and Julia built-in function \"pairs\"")

println("friend entries: ", json_stringify(Array{Any}([[object_key, object_value] for (object_key, object_value) in pairs(friend)])))
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]

println("# using Julia Array comprehension")

println("friend entries: ", json_stringify(Array{Any}([[object_key, object_value] for (object_key, object_value) in friend])))
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]

println("# using JavaScript-like Object.entries() function \"object_entries\"")

println("friend entries: ", json_stringify(Array{Any}(object_entries(friend))))
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
