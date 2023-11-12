def factorial_v1(number)
    return "argument should be a number" if (number.is_a?(Numeric) == false)
    return 1 if ((number > 1) == false)
    result = 1
    i = number
    while true
        result *= i
        i -= 1
        break if (i <= 0)
    end
    return result
end

def factorial_v2(number)
    return "argument should be a number" unless (number.is_a?(Numeric) == true)
    return 1 unless ((number > 1) == true)
    result = 1
    i = number
    while true
        result *= i
        i -= 1
        break if (i <= 0)
    end
    return result
end

def factorial_v3(number)
    return "argument should be a number" if (number.is_a?(Numeric) == false)
    return 1 if ((number > 1) == false)
    result = 1
    i = number
    while (i >= 1)
        result *= i
        i -= 1
    end
    return result
end

def factorial_v4(number)
    return "argument should be a number" unless (number.is_a?(Numeric) == true)
    return 1 unless ((number > 1) == true)
    result = 1
    i = number
    while (i >= 1)
        result *= i
        i -= 1
    end
    return result
end

def factorial_v5(number)
    return "argument should be a number" if (number.is_a?(Numeric) == false)
    return 1 if ((number > 1) == false)
    result = 1
    (number.downto(1)).each do |i|
        result *= i
    end
    return result
end

def factorial_v6(number)
    return "argument should be a number" unless (number.is_a?(Numeric) == true)
    return 1 unless ((number > 1) == true)
    result = 1
    (number.downto(1)).each do |i|
        result *= i
    end
    return result
end

print("\n# using factorial function \"factorial_v1\"")
print("\nFactorial(5): ", factorial_v1(5))
# Factorial(5): 120

print("\n# using factorial function \"factorial_v2\"")
print("\nFactorial(5): ", factorial_v2(5))
# Factorial(5): 120

print("\n# using factorial function \"factorial_v3\"")
print("\nFactorial(5): ", factorial_v3(5))
# Factorial(5): 120

print("\n# using factorial function \"factorial_v4\"")
print("\nFactorial(5): ", factorial_v4(5))
# Factorial(5): 120

print("\n# using factorial function \"factorial_v5\"")
print("\nFactorial(5): ", factorial_v5(5))
# Factorial(5): 120

print("\n# using factorial function \"factorial_v6\"")
print("\nFactorial(5): ", factorial_v6(5))
# Factorial(5): 120
