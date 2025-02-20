println("\n# Factorial(n) in Julia")

factorial_v1::Any = (any_number::Any) -> (begin
    if (any_number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (any_number === 0) return (1)::Any end
    local result::Any = 1
    local i::Any = any_number
    while (true)
        result *= i
        if (i <= 1) break end
        i -= 1
    end
    return (result)::Any
end)::Any

factorial_v2::Any = (any_number::Any) -> (begin
    if (any_number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (any_number === 0) return (1)::Any end
    local result::Any = 1
    local i::Any = any_number
    while (i >= 1)
        result *= i
        i -= 1
    end
    return (result)::Any
end)::Any

factorial_v3::Any = (any_number::Any) -> (begin
    if (any_number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (any_number === 0) return (1)::Any end
    local result::Any = 1
    for i in (any_number:-1:1) # (start:step:stop)
        result *= i
    end
    return (result)::Any
end)::Any

factorial_v4::Any = (any_number::Any) -> (begin
    if (any_number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (any_number === 0) return (1)::Any end
    return (any_number * factorial_v4(any_number - 1))::Any
end)::Any

println("# using factorial function \"factorial_v1\"")
println("Factorial(5): $(factorial_v1(5))")
# Factorial(5): 120

println("# using factorial function \"factorial_v2\"")
println("Factorial(5): $(factorial_v2(5))")
# Factorial(5): 120

println("# using factorial function \"factorial_v3\"")
println("Factorial(5): $(factorial_v3(5))")
# Factorial(5): 120

println("# using factorial function \"factorial_v4\"")
println("Factorial(5): $(factorial_v4(5))")
# Factorial(5): 120
