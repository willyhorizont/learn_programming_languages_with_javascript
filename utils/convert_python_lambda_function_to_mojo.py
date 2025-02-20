def convert_python_lambda_function_to_mojo():
    indentation = (" " * 4)
    with open("../lambda_function.py", "r") as python_lambda_function_code_file, open("../python_lambda_function.mojo", "w") as python_lambda_function_mojo_code_file:
        python_lambda_function_code = python_lambda_function_code_file.read()
        python_lambda_function_code = f"{indentation}{indentation}'{python_lambda_function_code}'"
        python_lambda_function_code = python_lambda_function_code.replace("'", "\\'")
        python_lambda_function_code = python_lambda_function_code.replace(f"{indentation}{indentation}\\'", f"{indentation}{indentation}'")
        python_lambda_function_code = python_lambda_function_code[:-2] + "'"
        python_lambda_function_code = python_lambda_function_code.replace("\\'", f"',\n{indentation}{indentation}\"'\",\n{indentation}{indentation}'")
        python_lambda_function_code = python_lambda_function_code.replace("\\n", "\\\\n")
        # print(python_lambda_function_code)
        python_lambda_function_mojo_code = f"""from python import Python

def main():
    python_lambda_function_string = "".join(
{python_lambda_function_code}
    )

    print(python_lambda_function_string)
    python_lambda_function = Python.evaluate(python_lambda_function_string)
    # try the python lambda function
    # python_lambda_function(...)

"""
        python_lambda_function_mojo_code_file.write(python_lambda_function_mojo_code)


if __name__ == "__main__":
    convert_python_lambda_function_to_mojo()
