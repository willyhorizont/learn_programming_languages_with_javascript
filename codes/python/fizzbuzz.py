from numbers import Number

print('\n# FizzBuzz(n) in Python')


def fizzbuzz_v1(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    number = 1
    while True:
        if (result == ""):
            result = f'{number}'
            number += 1
            if (number > stop_number):
                break
            continue
        if (((number % 3) == 0) and ((number % 5) == 0)):
            result = f'{result}, FizzBuzz'
            number += 1
            if (number > stop_number):
                break
            continue
        if ((number % 3) == 0):
            result = f'{result}, Fizz'
            number += 1
            if (number > stop_number):
                break
            continue
        if ((number % 5) == 0):
            result = f'{result}, Buzz'
            number += 1
            if (number > stop_number):
                break
            continue
        result = f'{result}, {number}'
        number += 1
        if (number > stop_number):
            break
    return result


def fizzbuzz_v2(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    number = 1
    while (number <= stop_number):
        if (result == ""):
            result = f'{number}'
            number += 1
            continue
        if (((number % 3) == 0) and ((number % 5) == 0)):
            result = f'{result}, FizzBuzz'
            number += 1
            continue
        if ((number % 3) == 0):
            result = f'{result}, Fizz'
            number += 1
            continue
        if ((number % 5) == 0):
            result = f'{result}, Buzz'
            number += 1
            continue
        result = f'{result}, {number}'
        number += 1
    return result


def fizzbuzz_v3(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    number = 1
    while True:
        if (result == ""):
            result = f'{number}'
        elif (((number % 3) == 0) and ((number % 5) == 0)):
            result = f'{result}, FizzBuzz'
        elif ((number % 3) == 0):
            result = f'{result}, Fizz'
        elif ((number % 5) == 0):
            result = f'{result}, Buzz'
        else:
            result = f'{result}, {number}'
        number += 1
        if (number > stop_number):
            break
    return result


def fizzbuzz_v4(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    number = 1
    while (number <= stop_number):
        if (result == ""):
            result = f'{number}'
        elif (((number % 3) == 0) and ((number % 5) == 0)):
            result = f'{result}, FizzBuzz'
        elif ((number % 3) == 0):
            result = f'{result}, Fizz'
        elif ((number % 5) == 0):
            result = f'{result}, Buzz'
        else:
            result = f'{result}, {number}'
        number += 1
    return result


def fizzbuzz_v5(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    number = 1
    while True:
        result = f'{number}' if (result == "") else f'{result}, FizzBuzz' if (((number % 3) == 0) and ((number % 5) == 0)) else f'{result}, Fizz' if ((number % 3) == 0) else f'{result}, Buzz' if ((number % 5) == 0) else f'{result}, {number}'
        number += 1
        if (number > stop_number):
            break
    return result


def fizzbuzz_v6(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    number = 1
    while (number <= stop_number):
        result = f'{number}' if (result == "") else f'{result}, FizzBuzz' if (((number % 3) == 0) and ((number % 5) == 0)) else f'{result}, Fizz' if ((number % 3) == 0) else f'{result}, Buzz' if ((number % 5) == 0) else f'{result}, {number}'
        number += 1
    return result


def fizzbuzz_v7(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    for number in range(1, stop_number + 1):
        if (result == ""):
            result = f'{number}'
            continue
        if (((number % 3) == 0) and ((number % 5) == 0)):
            result = f'{result}, FizzBuzz'
            continue
        if ((number % 3) == 0):
            result = f'{result}, Fizz'
            continue
        if ((number % 5) == 0):
            result = f'{result}, Buzz'
            continue
        result = f'{result}, {number}'
    return result


def fizzbuzz_v8(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    for number in range(1, stop_number + 1):
        if (result == ""):
            result = f'{number}'
        elif (((number % 3) == 0) and ((number % 5) == 0)):
            result = f'{result}, FizzBuzz'
        elif ((number % 3) == 0):
            result = f'{result}, Fizz'
        elif ((number % 5) == 0):
            result = f'{result}, Buzz'
        else:
            result = f'{result}, {number}'
    return result


def fizzbuzz_v9(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    result = ""
    for number in range(1, stop_number + 1):
        result = f'{number}' if (result == "") else f'{result}, FizzBuzz' if (((number % 3) == 0) and ((number % 5) == 0)) else f'{result}, Fizz' if ((number % 3) == 0) else f'{result}, Buzz' if ((number % 5) == 0) else f'{result}, {number}'
    return result


def fizzbuzz_v10(stop_number):
    if (isinstance(stop_number, Number) == False):
        raise Exception("Argument should be a number")
    if (stop_number < 1):
        raise Exception("Argument should be > 0")
    return ", ".join(['FizzBuzz' if (((number % 3) == 0) and ((number % 5) == 0)) else 'Fizz' if ((number % 3) == 0) else 'Buzz' if ((number % 5) == 0) else f'{number}' for number in range(1, stop_number + 1)])


print('# using fizzbuzz function "fizzbuzz_v1"')
print('FizzBuzz(36):', fizzbuzz_v1(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v2"')
print('FizzBuzz(36):', fizzbuzz_v2(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v3"')
print('FizzBuzz(36):', fizzbuzz_v3(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v4"')
print('FizzBuzz(36):', fizzbuzz_v4(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v5"')
print('FizzBuzz(36):', fizzbuzz_v5(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v6"')
print('FizzBuzz(36):', fizzbuzz_v6(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v7"')
print('FizzBuzz(36):', fizzbuzz_v7(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v8"')
print('FizzBuzz(36):', fizzbuzz_v8(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v9"')
print('FizzBuzz(36):', fizzbuzz_v9(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print('# using fizzbuzz function "fizzbuzz_v10"')
print('FizzBuzz(36):', fizzbuzz_v10(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
