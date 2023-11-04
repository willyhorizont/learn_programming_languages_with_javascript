using Printf
using Statistics

println("\n# Factorial(n) in Julia")

function factorial_v1(number::Int)
    if ((number > 1) === false)
        return 1
    end
    result = 1
    for i in number:-1:1
        result *= i
    end
    return result
end

function factorial_v2(number::Int)
    if ((number > 1) === false)
        return 1
    end
    result = 1
    i = number
    while true
        result *= i
        i -= 1
        if (i <= 0)
            break
        end
    end
    return result
end

function factorial_v3(number::Int)
    if ((number > 1) === false)
        return 1
    end
    result = 1
    i = number
    while i >= 1
        result *= i
        i -= 1
    end
    return result
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
