struct js_like_type_struct
    Null::Any
    Boolean::Any
    String::Any
    Numeric::Any
    Object::Any
    Array::Any
    Function::Any
end

js_like_type::Any = js_like_type_struct("Null", "Boolean", "String", "Numeric", "Object", "Array", "Function")

is_like_js_null::Any = (anything::Any) -> ((anything === nothing) && (isnothing(anything) === true))::Any

is_like_js_boolean::Any = (anything::Any) -> ((isa(anything, Bool) === true) && ((anything === true) || (anything === false)))::Any

is_like_js_string::Any = (anything::Any) -> (isa(anything, AbstractString) === true)::Any

is_like_js_numeric::Any = (anything::Any) -> (isa(anything, Number) === true)::Any

is_like_js_object::Any = (anything::Any) -> (isa(anything, Dict{String, Any}) === true)::Any

is_like_js_array::Any = (anything::Any) -> ((isa(anything, Array{Any, 1}) === true) && (isa(anything, Vector{Any}) === true))::Any

is_like_js_function::Any = (anything::Any) -> (isa(anything, Function) === true)::Any

get_type::Any = (anything::Any) -> (((is_like_js_null(anything) === true) ? ((js_like_type.Null)::Any) : ((is_like_js_boolean(anything) === true) ? ((js_like_type.Boolean)::Any) : ((is_like_js_string(anything) === true) ? ((js_like_type.String)::Any) : ((is_like_js_numeric(anything) === true) ? ((js_like_type.Numeric)::Any) : ((is_like_js_object(anything) === true) ? ((js_like_type.Object)::Any) : ((is_like_js_array(anything) === true) ? ((js_like_type.Array)::Any) : ((is_like_js_function(anything) === true) ? ((js_like_type.Function)::Any) : (("$(supertype(typeof(anything)))")::Any)))))))))::Any

json_stringify::Any = (anything::Any; pretty::Any=false) -> (begin
    # custom JSON.stringify() function
    local indent::Any = repeat(" ", 4)
    local indent_level::Any = 0
    local json_stringify_inner::Any = (anything_inner::Any) -> (begin
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
    end)::Any
    return (json_stringify_inner(anything))::Any
end)::Any

println("\n# JavaScript-like Object.keys() in Julia Dictionary")

friend::Any = Dict{String, Any}(
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
)
println("friend: $(json_stringify(friend, pretty=true))")

println("# using Julia Vector comprehension and Julia Object.keys() built-in function \"keys\"")

println("friend keys: $(json_stringify(Vector{Any}([object_key for object_key in keys(friend)])))")
# friend keys: ["name", "country", "age"]

println("# using composition of Julia built-in functions \"collect(keys)\"")

println("friend keys: $(json_stringify(Vector{Any}(collect(keys(friend)))))")
# friend keys: ["name", "country", "age"]

println("# using Julia Array spread syntax (...) and Julia Object.keys() built-in function \"keys\"")

println("friend keys: $(json_stringify(Vector{Any}([keys(friend)...])))")
# friend keys: ["name", "country", "age"]
