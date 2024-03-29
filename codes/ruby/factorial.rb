print("\n", "# Factorial(n) in Ruby")

def factorial_v1(number)
    raise StandardError.new("Argument should be a number") if (number.is_a?(Numeric) == false)
    raise StandardError.new("Argument should be >= 0") if (number < 0)
    return 1 if (number == 0)
    result = 1
    i = number
    while (true)
        result *= i
        break if (i <= 1)
        i -= 1
    end
    return result
end

def factorial_v2(number)
    raise StandardError.new("Argument should be a number") if (number.is_a?(Numeric) == false)
    raise StandardError.new("Argument should be >= 0") if (number < 0)
    return 1 if (number == 0)
    result = 1
    i = number
    while (i >= 1)
        result *= i
        i -= 1
    end
    return result
end

def factorial_v3(number)
    raise StandardError.new("Argument should be a number") if (number.is_a?(Numeric) == false)
    raise StandardError.new("Argument should be >= 0") if (number < 0)
    return 1 if (number == 0)
    result = 1
    (number.step(1, -1)).each do |i| # start.f(stop, step)
        result *= i
    end
    return result
end

def factorial_v4(number)
    raise StandardError.new("Argument should be a number") if (number.is_a?(Numeric) == false)
    raise StandardError.new("Argument should be >= 0") if (number < 0)
    return 1 if (number == 0)
    return (number * factorial_v4(number - 1))
end

print("\n", "# using factorial function \"factorial_v1\"")
print("\n", "Factorial(5): ", factorial_v1(5))
# Factorial(5): 120

print("\n", "# using factorial function \"factorial_v2\"")
print("\n", "Factorial(5): ", factorial_v2(5))
# Factorial(5): 120

print("\n", "# using factorial function \"factorial_v3\"")
print("\n", "Factorial(5): ", factorial_v3(5))
# Factorial(5): 120

print("\n", "# using factorial function \"factorial_v4\"")
print("\n", "Factorial(5): ", factorial_v4(5))
# Factorial(5): 120
