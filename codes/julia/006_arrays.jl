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

# in Julia, JavaScript-like Array is called Array

fruits::Any = Any["apple", "mango", "orange"]
println("fruits: ", json_stringify(fruits))

println("fruits, length: ", length(fruits))
# fruits, length: 3

println("fruits, get mango: ", fruits[2])
# fruits, get mango: mango

println("fruits, first element: ", fruits[1])
# fruits, first element: apple

println("fruits, last element: ", fruits[end])
# fruits, last element: orange

for (array_item_index, array_item) in enumerate(fruits)
    println("fruits, for loop, index: ", array_item_index, ", value: ", array_item)
end
# fruits, for loop, index: 1, value: apple
# fruits, for loop, index: 2, value: mango
# fruits, for loop, index: 3, value: orange

# in Julia, JavaScript-like Array of Objects is called Array of Dictionaries

products::Any = Any[
    Dict{String, Any}(
        "id" => "P1",
        "name" => "bubble gum"
    ),
    Dict{String, Any}(
        "id" => "P2",
        "name" => "potato chips"
    )
]
println("products: ", json_stringify(products, pretty=true))

for (array_item_index, array_item) in enumerate(products)
    for (object_entry_index, (object_key, object_value)) in enumerate(pairs(array_item))
        println("products, for loop, array item index: ", array_item_index, ", object iteration/entry index: ", object_entry_index, ", key: ", object_key, ", value: ", object_value)
    end
end
# products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: bubble gum
# products, for loop, array item index: 1, object iteration/entry index: 2, key: id, value: P1
# products, for loop, array item index: 2, object iteration/entry index: 1, key: name, value: potato chips
# products, for loop, array item index: 2, object iteration/entry index: 2, key: id, value: P2
