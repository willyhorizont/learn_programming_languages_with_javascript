# magic shell
# mojo filename.mojo
# \\' to ',\n\t"'",\n\t'

from collections import Dict
from python import Python, PythonObject


def create_new_object_entries(new_object_key, new_object_value) -> PythonObject:
    var new_object_entries: PythonObject = [new_object_key, new_object_value]
    return new_object_entries


def create_new_object(*rest_arguments: PythonObject) -> PythonObject:
    var new_object: PythonObject = Python.dict()
    current_index = 0
    for current_argument in rest_arguments:
        if ((current_index % 2) == 0):
            new_object_key = String(current_argument)
            new_object_value = rest_arguments[current_index + 1]
            new_object[new_object_key] = new_object_value
        current_index += 1
    return new_object


def main():
    print("Hello, World!")

    var d = Dict[String, PythonObject]()
    d["a"] = 1
    d["b"] = 2
    print(len(d))      # prints 2
    print(d["a"])      # prints 1
    # print(d.pop("b"))  # prints 2
    # print(len(d))      # prints 1

    # py_dict = Python.dict()
    # py_dict["item_name"] = "whizbang"
    # py_dict["price"] = 11.75
    # py_dict["inventory"] = 100
    # print(py_dict)

    # create_new_object("name", "Alisa", "country", "Finland", "age", 25)

    # var py_list = ["cat", 2, 3.14159, 4]