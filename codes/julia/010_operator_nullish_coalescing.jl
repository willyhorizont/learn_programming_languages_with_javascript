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

println("\n# JavaScript-like Nullish Coalescing Operator (??) in Julia")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Julia.
# But, we can create our own function to mimic it in Julia.

# JavaScript-like Nullish Coalescing Operator (??) function
nullish_coalescing::Any = (anything::Any, default_value::Any) -> ((anything === nothing) ? default_value : anything)::Any

JSON_OBJECT::Any = Dict{String, Any}(
    "foo" => Dict{String, Any}(
        "bar" => "baz"
    ),
    "fruits" => Vector{Any}(["apple", "mango", "banana"]),
    "get_rectangle_area" => (rectangle_width::Any, rectangle_length::Any) -> (begin
        return (rectangle_width * rectangle_length)::Any
    end)::Any
)
println("JSON_OBJECT: $(json_stringify(JSON_OBJECT, pretty=true))")

println("# using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

println("(JSON_OBJECT?.foo?.bar ?? \"not found\") or (JSON_OBJECT?.[\"foo\"]?.[\"bar\"] ?? \"not found\"): $(json_stringify(nullish_coalescing(try JSON_OBJECT["foo"]["bar"] catch(err) nothing end, "not found")))")
# (JSON_OBJECT?.foo?.bar ?? \"not found\") or (JSON_OBJECT?.[\"foo\"]?.[\"bar\"] ?? \"not found\"): "baz"

println("(JSON_OBJECT?.foo?.baz ?? \"not found\") or (JSON_OBJECT?.[\"foo\"]?.[\"baz\"] ?? \"not found\"): $(json_stringify(nullish_coalescing(try JSON_OBJECT["foo"]["baz"] catch(err) nothing end, "not found")))")
# (JSON_OBJECT?.foo?.baz ?? \"not found\") or (JSON_OBJECT?.[\"foo\"]?.[\"baz\"] ?? \"not found\"): "not found"

println("(JSON_OBJECT?.fruits?.[2] ?? \"not found\") or (JSON_OBJECT?.[\"fruits\"]?.[2] ?? \"not found\"): $(json_stringify(nullish_coalescing(try JSON_OBJECT["fruits"][2] catch(err) nothing end, "not found")))")
# (JSON_OBJECT?.fruits?.[2] ?? \"not found\") or (JSON_OBJECT?.[\"fruits\"]?.[2] ?? \"not found\"): "mango"

println("(JSON_OBJECT?.fruits?.[5] ?? \"not found\") or (JSON_OBJECT?.[\"fruits\"]?.[5] ?? \"not found\"): $(json_stringify(nullish_coalescing(try JSON_OBJECT["fruits"][5] catch(err) nothing end, "not found")))")
# (JSON_OBJECT?.fruits?.[5] ?? \"not found\") or (JSON_OBJECT?.[\"fruits\"]?.[5] ?? \"not found\"): "not found"

println("(JSON_OBJECT?.get_rectangle_area?.(7, 5) ?? \"not found\") or (JSON_OBJECT?.[\"get_rectangle_area\"]?.(7, 5) ?? \"not found\"): $(json_stringify(nullish_coalescing(try JSON_OBJECT["get_rectangle_area"](7, 5) catch(err) nothing end, "not found")))")
# (JSON_OBJECT?.get_rectangle_area?.(7, 5) ?? \"not found\") or (JSON_OBJECT?.[\"get_rectangle_area\"]?.(7, 5) ?? \"not found\"): 35

println("(JSON_OBJECT?.get_circle_area?.(7) ?? \"not found\") or (JSON_OBJECT?.[\"get_circle_area\"]?.(7) ?? \"not found\"): $(json_stringify(nullish_coalescing(try JSON_OBJECT["get_circle_area"](7) catch(err) nothing end, "not found")))")
# (JSON_OBJECT?.get_circle_area?.(7) ?? \"not found\") or (JSON_OBJECT?.[\"get_circle_area\"]?.(7) ?? \"not found\"): "not found"
