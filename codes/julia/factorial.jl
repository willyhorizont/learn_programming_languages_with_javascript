println("\n# Factorial(n) in Julia")

function factorial_v1(number::Int)
    if (number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (number == 0) return 1 end
    result = 1
    i = number
    while (true)
        result *= i
        if (i <= 1) break end
        i -= 1
    end
    return result
end

function factorial_v2(number::Int)
    if (number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (number == 0) return 1 end
    result = 1
    i = number
    while (i >= 1)
        result *= i
        i -= 1
    end
    return result
end

function factorial_v3(number::Int)
    if (number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (number == 0) return 1 end
    result = 1
    for i in (number:-1:1) # (start:step:stop)
        result *= i
    end
    return result
end

function factorial_v4(number::Int)
    if (number < 0) throw(ErrorException("Argument should be >= 0")) end
    if (number == 0) return 1 end
    return (number * factorial_v4(number - 1))
end

println("# using factorial function \"factorial_v1\"")
println("Factorial(5): ", factorial_v1(5))
# Factorial(5): 120

println("# using factorial function \"factorial_v2\"")
println("Factorial(5): ", factorial_v2(5))
# Factorial(5): 120

println("# using factorial function \"factorial_v3\"")
println("Factorial(5): ", factorial_v3(5))
# Factorial(5): 120

println("# using factorial function \"factorial_v4\"")
println("Factorial(5): ", factorial_v4(5))
# Factorial(5): 120
