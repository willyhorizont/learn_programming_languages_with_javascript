def generate_something():
    for i in range(1, (1000 + 1), 1):  # (start, stop, step)
        with open("../codes_trial/julia/named_function_test.jl", "a") as program_file:
            program_file.write(f"""asd{i}::Any = function f(rectangle_width::Any, rectangle_length::Any)::Any
    return (rectangle_width * rectangle_length)::Any
end
println("asd{i}(7, 5): $(asd{i}(7, 5))")

""")


if __name__ == '__main__':
    generate_something()
