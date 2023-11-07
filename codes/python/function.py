
# ? function statement or function declaration

def get_rectangle_area_v1(rectangle_width, rectangle_length):
    return rectangle_width * rectangle_length


# call the function example: get_rectangle_area_v1(3, 4)

# ? function expression with lambda function or named lambda function

get_rectangle_area_v2 = lambda rectangle_width, rectangle_length: rectangle_width * rectangle_length
# call the function example: get_rectangle_area_v2(3, 4)

# ? anonymous function or anonymous lambda function or lambda function
lambda rectangle_width, rectangle_length: rectangle_width * rectangle_length

'''
    In Python, a function is a first-class citizen, which means it supports:
    • Passing functions as arguments to other functions
    • Assigning functions to variables or storing them in data structures
    • Returning functions as values from other functions (closure)
'''

# ? Passing functions as arguments to other functions


def say_hello(do_something):
    print("hello")
    do_something()


def say_how_are_you():
    print("how are you?")


say_hello(say_how_are_you)

say_hello(lambda: print("how are you ?"))

# ? Assigning functions to variables or storing them in data structures

get_rectangle_area_v2 = lambda rectangle_width, rectangle_length: rectangle_width * rectangle_length

my_array_of_get_rectangle_area_functions = [
    get_rectangle_area_v1,
    lambda rectangle_width, rectangle_length: rectangle_width * rectangle_length
]

get_rectangle_area_function1 = my_array_of_get_rectangle_area_functions[0](3, 4)
get_rectangle_area_function2 = my_array_of_get_rectangle_area_functions[1](3, 4)


def exponentiation(a, b):
    return a ** b


simple_calculator = {
    "exponentiation": exponentiation,
    "addition": lambda a, b: a + b
}

simple_calculator_result1 = simple_calculator["exponentiation"](2, 4)
simple_calculator_result2 = simple_calculator["addition"](9, 3)

# ? Returning functions as values from other functions (closure)


def multiply_v1(a):
    def multiply_by(b):
        return a * b
    return multiply_by


multiply_by_2 = multiply_v1(2)
multiply_by_2_result = multiply_by_2(10)  # 20


def multiply_v2(a):
    multiply_by = lambda b: a * b
    return multiply_by


multiply_by_3 = multiply_v2(3)
multiply_by_3_result = multiply_by_3(10)  # 30


def multiply_v3(a):
    return lambda b: a * b


multiply_by_4 = multiply_v3(4)
multiply_by_4_result = multiply_by_4(10)  # 40


multiply_v4 = lambda a: lambda b: a * b
multiply_by_5 = multiply_v4(5)
multiply_by_5_result = multiply_by_5(10)  # 50
