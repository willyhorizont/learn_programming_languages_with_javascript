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

array_map_v1::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.map() function array_map_v1
    local new_array::Any = Vector{Any}([])
    for (array_item_index, array_item) in enumerate(an_array)
        local new_array_item::Any = callback_function(array_item, array_item_index, an_array)
        push!(new_array, new_array_item)
    end
    return (new_array)::Any
end)::Any

array_map_v2::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.map() function array_map_v2
    local new_array::Any = Vector{Any}([])
    for (array_item_index, array_item) in enumerate(an_array)
        push!(new_array, callback_function(array_item, array_item_index, an_array))
    end
    return (new_array)::Any
end)::Any

array_map_v3::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.map() function array_map_v3
    return (Vector{Any}([callback_function(array_item, array_item_index, an_array) for (array_item_index, array_item) in enumerate(an_array)]))::Any
end)::Any

array_map_v4::Any = (callback_function::Any, an_array::Any) -> (Vector{Any}([callback_function(array_item, array_item_index, an_array) for (array_item_index, array_item) in enumerate(an_array)]))::Any  # JavaScript-like Array.map() function array_map_v4

println("\n# JavaScript-like Array.map() in Julia Vector")

numbers::Any = Vector{Any}([12, 34, 27, 23, 65, 93, 36, 87, 4, 254])
println("numbers: $(json_stringify(numbers))")

println("# using JavaScript-like Array.map() function \"array_map_v1\"")

numbers_labeled::Any = array_map_v1(((number::Any, _, _) -> (Dict{String, Any}("$(number)" => (((number % 2) === 0) ? "even" : "odd")))::Any), numbers)
println("labeled numbers: $(json_stringify(numbers_labeled, pretty=true))")
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v2\"")

numbers_labeled::Any = array_map_v2(((number::Any, _, _) -> (Dict{String, Any}("$(number)" => (((number % 2) === 0) ? "even" : "odd")))::Any), numbers)
println("labeled numbers: $(json_stringify(numbers_labeled, pretty=true))")
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v3\"")

numbers_labeled::Any = array_map_v3(((number::Any, _, _) -> (Dict{String, Any}("$(number)" => (((number % 2) === 0) ? "even" : "odd")))::Any), numbers)
println("labeled numbers: $(json_stringify(numbers_labeled, pretty=true))")
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("# using Julia Array.map() built-in function \"map\"")

numbers_labeled::Any = convert(Vector{Any}, map(((number::Any) -> (Dict{String, Any}("$(number)" => (((number % 2) === 0) ? "even" : "odd")))::Any), numbers))
println("labeled numbers: $(json_stringify(numbers_labeled, pretty=true))")
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("\n# JavaScript-like Array.map() in Julia Vector of Dictionaries")

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

println("# using JavaScript-like Array.map() function \"array_map_v1\"")

products_labeled::Any = array_map_v1(((product::Any, _, _) -> (Dict{String, Any}(product..., "label" => (((try product["price"] catch (e) nothing end) > 100) ? "expensive" : "cheap")))::Any), products)
println("labeled products: $(json_stringify(products_labeled, pretty=true))")
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v2\"")

products_labeled::Any = array_map_v2(((product::Any, _, _) -> (Dict{String, Any}(product..., "label" => (((try product["price"] catch (e) nothing end) > 100) ? "expensive" : "cheap")))::Any), products)
println("labeled products: $(json_stringify(products_labeled, pretty=true))")
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v3\"")

products_labeled::Any = array_map_v3(((product::Any, _, _) -> (Dict{String, Any}(product..., "label" => (((try product["price"] catch (e) nothing end) > 100) ? "expensive" : "cheap")))::Any), products)
println("labeled products: $(json_stringify(products_labeled, pretty=true))")
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

println("# using Julia Array.map() built-in function \"map\"")

products_labeled::Any = convert(Vector{Any}, map(((product) -> (Dict{String, Any}(product..., "label" => (((try product["price"] catch (e) nothing end) > 100) ? "expensive" : "cheap")))::Any), products))
println("labeled products: $(json_stringify(products_labeled, pretty=true))")
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]
