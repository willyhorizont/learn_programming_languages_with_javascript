from numbers import Number

print('\n# Factorial(n) in Python')


def factorial_v1(number: int) -> int:
    if (isinstance(number, Number) == False):
        return "argument should be a number"
    if ((number > 1) == False):
        return 1
    result = 1
    i = number
    while True:
        result *= i
        i -= 1
        if (i <= 0):
            break
    return result


def factorial_v2(number: int) -> int:
    if (isinstance(number, Number) == False):
        return "argument should be a number"
    if ((number > 1) == False):
        return 1
    result = 1
    i = number
    while (i >= 1):
        result *= i
        i -= 1
    return result


def factorial_v3(number: int) -> int:
    if (isinstance(number, Number) == False):
        return "argument should be a number"
    if ((number > 1) == False):
        return 1
    result = 1
    for i in range(number, 0, -1):
        result *= i
    return result


print('# using factorial function "factorial_v1"')
print('Factorial(5):', factorial_v1(5))
# Factorial(5): 120

print('# using factorial function "factorial_v2"')
print('Factorial(5):', factorial_v2(5))
# Factorial(5): 120

print('# using factorial function "factorial_v3"')
print('Factorial(5):', factorial_v3(5))
# Factorial(5): 120
