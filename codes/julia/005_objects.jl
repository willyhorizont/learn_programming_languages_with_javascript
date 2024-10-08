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

# in Julia, JavaScript-like Object is called Dict / Dictionary

friend::Any = Dict{String, Any}(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)
println("friend: ", json_stringify(friend, pretty=true))

println("friend, get total object keys: ", length(friend))
# friend, get total object keys: 3

println("friend, get country: ", friend["country"])
# friend, get country: Finland

# iterate over and get each key-value pair
for (object_key, object_value) in friend
    println("friend, for loop, key: ", object_key, ", value: ", object_value)
end
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
for (object_entry_index, (object_key, object_value)) in enumerate(pairs(friend))
    println("friend, for loop, object iteration/entry index: ", object_entry_index, ", key: ", object_key, ", value: ", object_value)
end
# friend, for loop, object iteration/entry index: 1, key: name, value: Alisa
# friend, for loop, object iteration/entry index: 2, key: country, value: Finland
# friend, for loop, object iteration/entry index: 3, key: age, value: 25

friend["age"] = 27
println("friend: ", json_stringify(friend, pretty=true))

friend["gender"] = "Female"
println("friend: ", json_stringify(friend, pretty=true))

delete!(friend, "country")
println("friend: ", json_stringify(friend, pretty=true))

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
delivery_response_key_message::Any = "message"
delivery_response::Any = Dict{String, Any}(
    delivery_response_key_message => "ok"
)
println("delivery_response: ", json_stringify(delivery_response, pretty=true))
delivery_response_key_status::Any = "status"
delivery_response[delivery_response_key_status] = 200
println("delivery_response: ", json_stringify(delivery_response, pretty=true))
