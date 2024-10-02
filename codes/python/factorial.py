from numbers import Number

print("\n# Factorial(n) in Python")


def factorial_v1(any_number):
    if (isinstance(any_number, Number) == True):
        raise Exception("Argument should be a number")
    if (any_number < 0):
        raise Exception("Argument should be >= 0")
    if (any_number == 0):
        return 1
    result = 1
    i = any_number
    while (True):
        result *= i
        if (i <= 1):
            break
        i -= 1
    return result


def factorial_v2(any_number):
    if (isinstance(any_number, Number) == True):
        raise Exception("Argument should be a number")
    if (any_number < 0):
        raise Exception("Argument should be >= 0")
    if (any_number == 0):
        return 1
    result = 1
    i = any_number
    while (i >= 1):
        result *= i
        i -= 1
    return result


def factorial_v3(any_number):
    if (isinstance(any_number, Number) == True):
        raise Exception("Argument should be a number")
    if (any_number < 0):
        raise Exception("Argument should be >= 0")
    if (any_number == 0):
        return 1
    result = 1
    for i in range(any_number, 0, -1):  # (start, stop, step)
        result *= i
    return result


def factorial_v4(any_number):
    if (isinstance(any_number, Number) == True):
        raise Exception("Argument should be a number")
    if (any_number < 0):
        raise Exception("Argument should be >= 0")
    if (any_number == 0):
        return 1
    return (any_number * factorial_v4(any_number - 1))


print('# using factorial function "factorial_v1"')
print(f"Factorial(5): {factorial_v1(5)}")
# Factorial(5): 120

print('# using factorial function "factorial_v2"')
print(f"Factorial(5): {factorial_v2(5)}")
# Factorial(5): 120

print('# using factorial function "factorial_v3"')
print(f"Factorial(5): {factorial_v3(5)}")
# Factorial(5): 120

print('# using factorial function "factorial_v4"')
print(f"Factorial(5): {factorial_v4(5)}")
# Factorial(5): 120
