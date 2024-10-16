struct js_like_type_struct
    Null::Any
    Boolean::Any
    String::Any
    Numeric::Any
    Object::Any
    Array::Any
    Function::Any
end

js_like_type::Any = js_like_type_struct(
    "Null",
    "Boolean",
    "String",
    "Numeric",
    "Object",
    "Array",
    "Function"
)

is_like_js_null::Any = (anything::Any) -> ((anything === nothing) && (isnothing(anything) === true))::Any

is_like_js_boolean::Any = (anything::Any) -> ((isa(anything, Bool) === true) && ((anything === true) || (anything === false)))::Any

is_like_js_string::Any = (anything::Any) -> (isa(anything, AbstractString) === true)::Any

is_like_js_numeric::Any = (anything::Any) -> (isa(anything, Number) === true)::Any

is_like_js_object::Any = (anything::Any) -> (isa(anything, Dict{String, Any}) === true)::Any

is_like_js_array::Any = (anything::Any) -> ((isa(anything, Array{Any, 1}) === true) && (isa(anything, Vector{Any}) === true))::Any

is_like_js_function::Any = (anything::Any) -> (isa(anything, Function) === true)::Any

get_type::Any = (anything::Any) -> (begin
    if (is_like_js_null(anything) === true) return (js_like_type.Null)::Any end
    if (is_like_js_boolean(anything) === true) return (js_like_type.Boolean)::Any end
    if (is_like_js_string(anything) === true) return (js_like_type.String)::Any end
    if (is_like_js_numeric(anything) === true) return (js_like_type.Numeric)::Any end
    if (is_like_js_object(anything) === true) return (js_like_type.Object)::Any end
    if (is_like_js_array(anything) === true) return (js_like_type.Array)::Any end
    if (is_like_js_function(anything) === true) return (js_like_type.Function)::Any end
    return ("\"$(typeof(anything))\"")::Any
end)::Any

json_stringify::Any = (anything::Any; pretty::Any=false) -> (begin
    # custom JSON.stringify() function
    local indent::Any = repeat(" ", 4)
    local indent_level::Any = 0
    local json_stringify_inner::Any = (anything_inner::Any) -> (begin
        if (get_type(anything_inner) === js_like_type.Null) return ("null")::Any end
        if (get_type(anything_inner) === js_like_type.String) return ("\"$(anything_inner)\"")::Any end
        if ((get_type(anything_inner) === js_like_type.Numeric) || (get_type(anything_inner) === js_like_type.Boolean)) return ("$(anything_inner)")::Any end
        if (get_type(anything_inner) === js_like_type.Array)
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
        if (get_type(anything_inner) === js_like_type.Object)
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
        if (get_type(anything_inner) === js_like_type.Function) return ("\"[object Function]\"")::Any end
        return ("\"$(typeof(anything))\"")::Any
    end)::Any
    return (json_stringify_inner(anything))::Any
end)::Any

println("\n# JavaScript-like Array.includes() in Julia")

my_friends::Any = Vector{Any}(["Alisa", "Trivia"])
println("my friends: $(json_stringify(my_friends))")

println("# using Julia Array.includes() built-in operator \"in\"")

a_name::Any = "Alisa"
is_my_friend::Any = (a_name in my_friends)
println("is my friends includes \"$(a_name)\": $(is_my_friend)")
# is my friends includes "Alisa": true

a_name::Any = "Trivia"
is_my_friend::Any = (a_name in my_friends)
println("is my friends includes \"$(a_name)\": $(is_my_friend)")
# is my friends includes "Trivia": true

a_name::Any = "Tony"
is_my_friend::Any = (a_name in my_friends)
println("is my friends includes \"$(a_name)\": $(is_my_friend)")
# is my friends includes "Tony": true

a_name::Any = "Ezekiel"
is_my_friend::Any = (a_name in my_friends)
println("is my friends includes \"$(a_name)\": $(is_my_friend)")
# is my friends includes "Ezekiel": true
