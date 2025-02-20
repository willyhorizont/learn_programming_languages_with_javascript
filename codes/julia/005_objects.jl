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

println("\n# JavaScript-like Object in Julia (Dictionary)")

# Create using Dict{String, Any}([("key_1", "value_1"), ("key_2", "value_2"), ("key_3", "value_3"), ...])
# friend::Any = Dict{String, Any}([("name", "Alisa"), ("country", "Finland"), ("age", 25)])

# Create using Dict{String, Any}("key_1" => "value_1", "key_2" => "value_2", "key_3" => "value_3", ...) (the best way)
friend::Any = Dict{String, Any}(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)
println("friend: $(json_stringify(friend, pretty=true))")

println("friend, get total object keys: $(length(friend))")
# friend, get total object keys: 3

println("friend, get country: $(json_stringify(friend["country"]))")
# friend, get country: "Finland"

println("friend, get country: $(json_stringify(try friend["country"] catch (any_error) nothing end))")
# friend, get country: "Finland"

# iterate over and print each key-value pair and object entry index
for (object_entry_index, (object_key, object_value)) in enumerate(pairs(friend))
    println("friend, object entry index: $(object_entry_index), key: $(object_key), value: $(object_value)")
end
# friend, object entry index: 1, key: name, value: Alisa, for loop
# friend, object entry index: 2, key: country, value: Finland, for loop
# friend, object entry index: 3, key: age, value: 25, for loop

friend["age"] = 27
println("friend: $(json_stringify(friend, pretty=true))")

friend["gender"] = "Female"
println("friend: $(json_stringify(friend, pretty=true))")

delete!(friend, "country")
println("friend: $(json_stringify(friend, pretty=true))")

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
delivery_response_key_message::Any = "message"
delivery_response::Any = Dict{String, Any}(
    delivery_response_key_message => "ok"
)
println("delivery_response: $(json_stringify(delivery_response, pretty=true))")
delivery_response_key_status::Any = "status"
delivery_response[delivery_response_key_status] = 200
println("delivery_response: $(json_stringify(delivery_response, pretty=true))")
