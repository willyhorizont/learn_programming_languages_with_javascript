println("\n# Factorial(n) in Julia")

factorial_v1::Any = (a_number::Any) -> (begin
    if (a_number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (a_number === 0) return (1)::Any end
    local result::Any = 1
    local i::Any = a_number
    while (true)
        result *= i
        if (i <= 1) break end
        i -= 1
    end
    return (result)::Any
end)::Any

factorial_v2::Any = (a_number::Any) -> (begin
    if (a_number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (a_number === 0) return (1)::Any end
    local result::Any = 1
    local i::Any = a_number
    while (i >= 1)
        result *= i
        i -= 1
    end
    return (result)::Any
end)::Any

factorial_v3::Any = (a_number::Any) -> (begin
    if (a_number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (a_number === 0) return (1)::Any end
    local result::Any = 1
    for i in (a_number:-1:1) # (start:step:stop)
        result *= i
    end
    return (result)::Any
end)::Any

factorial_v4::Any = (a_number::Any) -> (begin
    if (a_number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (a_number === 0) return (1)::Any end
    return (a_number * factorial_v4(a_number - 1))::Any
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
