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

array_reduce::Any = (callback_function::Any, an_array::Any, initial_value::Any) -> (begin
    # JavaScript-like Array.reduce() function
    local result::Any = initial_value
    for (array_item_index, array_item) in enumerate(an_array)
        result = callback_function(result, array_item, array_item_index, an_array)
    end
    return (result)::Any
end)::Any

println("\n# JavaScript-like Array.reduce() in Julia Vector")

numbers::Any = Vector{Any}([36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3])
println("numbers: $(json_stringify(numbers))")

println("# using JavaScript-like Array.reduce() function \"array_reduce\"")

numbers_total::Any = array_reduce(((current_result::Any, current_number::Any, _, _) -> (current_result + current_number)::Any), numbers, 0)
println("total number: $(numbers_total)")
# total number: 41.2

println("# using Julia Array.reduce() built-in function \"reduce\"")

numbers_total::Any = reduce(((current_result::Any, current_number::Any) -> (current_result + current_number)::Any), numbers; init=0)
println("total number: $(numbers_total)")
# total number: 41.2

println("# using Julia Array.reduce() built-in function \"foldl\"")

numbers_total::Any = foldl(((current_result::Any, current_number::Any) -> (current_result + current_number)::Any), numbers; init=0)
println("total number: $(numbers_total)")
# total number: 41.2

println("\n# JavaScript-like Array.reduce() in Julia Vector of Dictionaries")

products::Any = Vector{Any}([
    Dict{String, Any}(
        "code" => "pasta",
        "price" => 321
    ),
    Dict{String, Any}(
        "code" => "bubble_gum",
        "price" => 233
    ),
    Dict{String, Any}(
        "code" => "potato_chips",
        "price" => 5
    ),
    Dict{String, Any}(
        "code" => "towel",
        "price" => 499
    )
])
println("products: $(json_stringify(products, pretty=true))")

println("# using JavaScript-like Array.reduce() function \"array_reduce\"")

products_grouped::Any = array_reduce(((current_result::Any, current_product::Any, _, _) -> (((try current_product["price"] catch (e) nothing end) > 100) ? (Dict{String, Any}(current_result..., "expensive" => Vector{Any}([(try current_result["expensive"] catch (e) Vector{Any}([]) end)..., current_product]))) : (Dict{String, Any}(current_result..., "cheap" => Vector{Any}([(try current_result["cheap"] catch (e) Vector{Any}([]) end)..., current_product]))))::Any), products, Dict{String, Any}("expensive" => Vector{Any}([]), "cheap" => Vector{Any}([])))
println("grouped products: $(json_stringify(products_grouped, pretty=true))")
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

println("# using Julia Array.reduce() built-in function \"reduce\"")

products_grouped::Any = reduce(((current_result::Any, current_product::Any) -> (((try current_product["price"] catch (e) nothing end) > 100) ? (Dict{String, Any}(current_result..., "expensive" => Vector{Any}([(try current_result["expensive"] catch (e) Vector{Any}([]) end)..., current_product]))) : (Dict{String, Any}(current_result..., "cheap" => Vector{Any}([(try current_result["cheap"] catch (e) Vector{Any}([]) end)..., current_product]))))::Any), products; init=Dict{String, Any}("expensive" => Vector{Any}([]), "cheap" => Vector{Any}([])))
println("grouped products: $(json_stringify(products_grouped, pretty=true))")
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

println("# using Julia Array.reduce() built-in function \"foldl\"")

products_grouped::Any = foldl(((current_result::Any, current_product::Any) -> (((try current_product["price"] catch (e) nothing end) > 100) ? (Dict{String, Any}(current_result..., "expensive" => Vector{Any}([(try current_result["expensive"] catch (e) Vector{Any}([]) end)..., current_product]))) : (Dict{String, Any}(current_result..., "cheap" => Vector{Any}([(try current_result["cheap"] catch (e) Vector{Any}([]) end)..., current_product]))))::Any), products; init=Dict{String, Any}("expensive" => Vector{Any}([]), "cheap" => Vector{Any}([])))
println("grouped products: $(json_stringify(products_grouped, pretty=true))")
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
