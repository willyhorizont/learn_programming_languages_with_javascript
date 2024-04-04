function json_stringify(anything; pretty::Bool = false, indent::String = "    ")::String
    indent_level = 0
    function json_stringify_inner(anything_inner, indent_inner::String)::String
        if (anything_inner === nothing) return "null" end
        if (isa(anything_inner, AbstractString) === true) return "\"$(anything_inner)\"" end
        if ((isa(anything_inner, Number) === true) || (isa(anything_inner, Bool) === true)) return "$(anything_inner)" end
        if (isa(anything_inner, Array) === true)
            if (length(anything_inner) == 0) return "[]" end
            indent_level += 1
            result = ((pretty === true) ? "[\n$(repeat(indent_inner, indent_level))" : "[")
            for (array_item_index, array_item) in enumerate(anything_inner)
                result *= json_stringify_inner(array_item, indent_inner)
                if (array_item_index !== length(anything_inner)) result *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))]" : "]")
            return result
        end
        if (isa(anything_inner, Dict) === true)
            if (length(anything_inner) == 0) return "{}" end
            indent_level += 1
            result = ((pretty === true) ? "{\n$(repeat(indent_inner, indent_level))" : "{")
            for (object_entry_index, (object_key, object_value)) in enumerate(pairs(anything_inner))
                result *= "\"$(object_key)\": $(json_stringify_inner(object_value, indent_inner))"
                if (object_entry_index !== length(anything_inner)) result *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))}" : "}")
            return result
        end
        return "null"
    end
    return json_stringify_inner(anything, indent)
end

println("\n# JavaScript-like Nullish Coalescing Operator (??) in Julia")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Julia.
# But, we can create our own function to mimic it in Julia.

# JavaScript-like Nullish Coalescing Operator (??) function
nullish_coalescing = (anything, default_value) -> ((anything === nothing) ? default_value : anything)

JSON_OBJECT = Dict(
    "foo" => Dict(
        "bar" => "baz"
    ),
    "fruits" => ["apple", "mango", "banana"]
)
println("JSON_OBJECT: ", json_stringify(JSON_OBJECT, pretty=true))

println("# using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

println("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", nullish_coalescing(try JSON_OBJECT["foo"]["bar"] catch(err) nothing end, "not found"))
# (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): baz

println("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", nullish_coalescing(try JSON_OBJECT["foo"]["baz"] catch(err) nothing end, "not found"))
# (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): not found

println("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", nullish_coalescing(try JSON_OBJECT["fruits"][2] catch(err) nothing end, "not found"))
# (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): mango

println("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", nullish_coalescing(try JSON_OBJECT["fruits"][5] catch(err) nothing end, "not found"))
# (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): not found
