# magic shell
# mojo filename.mojo
# \\' to ',\n\t"'",\n\t'

from collections import Dict
from python import Python, PythonObject


def main():
    def create_new_object(*rest_arguments: PythonObject) -> PythonObject:
        var new_object: PythonObject = Python.dict()
        current_index = 0
        while current_index < len(rest_arguments):
            if ((current_index % 2) == 0):
                new_object_key = rest_arguments[current_index]
                new_object_value = rest_arguments[current_index + 1]
                new_object[new_object_key] = new_object_value
            current_index += 1
        return new_object


    var my_object: PythonObject = create_new_object(
        "my_function", Python.evaluate('lambda a, b: (a * b)'),
        "my_string", "foo",
        "my_number", 123,
        "my_bool", True,
        "my_null", None,
        "my_array", [1, 2, 3],
        "my_object", create_new_object(
            "foo", "bar"
        ),
    )
    print(my_object.__getitem__("my_string"))
    print(my_object["my_string"])
    print(my_object)
    # numbers = Python.import_module("numbers")
    # Number = numbers.Number

    js_like_type = create_new_object("Null", "Null", "Boolean", "Boolean", "String", "String", "Numeric", "Numeric", "Object", "Object", "Array", "Array", "Function", "Function")
    print(js_like_type)
    print(js_like_type["Null"])


    def array_reduce(callback_function: PythonObject, any_array: PythonObject, initial_value: PythonObject) -> PythonObject:
        '''JavaScript-like Array.reduce() function'''
        result = initial_value
        array_item_index = 0
        while array_item_index < len(any_array):
            result = callback_function(result, any_array[array_item_index], array_item_index, any_array)
            array_item_index += 1
        return result


    def is_like_js_null(anything: PythonObject) -> PythonObject:
        return ((anything._get_type_name() == "NoneType") and (anything is None))


    def is_like_js_boolean(anything: PythonObject) -> PythonObject:
        return ((anything._get_type_name() == "bool") and ((anything == True) or (anything == False)))


    def is_like_js_string(anything: PythonObject) -> PythonObject:
        return (anything._get_type_name() == "str")


    def is_like_js_numeric(anything: PythonObject) -> PythonObject:
        return ((anything._get_type_name() == "int") or (anything._get_type_name() == "float"))


    def is_like_js_object(anything: PythonObject) -> PythonObject:
        return (anything._get_type_name() == "dict")


    def is_like_js_array(anything: PythonObject) -> PythonObject:
        return (anything._get_type_name() == "list")


    def is_like_js_function(anything: PythonObject) -> PythonObject:
        return (anything._get_type_name() == "function")


    def get_type(anything: PythonObject) -> PythonObject:
        if (is_like_js_null(anything) == True):
            return js_like_type["Null"]
        if (is_like_js_boolean(anything) == True):
            return js_like_type["Boolean"]
        if (is_like_js_string(anything) == True):
            return js_like_type["String"]
        if (is_like_js_numeric(anything) == True):
            return js_like_type["Numeric"]
        if (is_like_js_object(anything) == True):
            return js_like_type["Object"]
        if (is_like_js_array(anything) == True):
            return js_like_type["Array"]
        if (is_like_js_function(anything) == True):
            return js_like_type["Function"]
        return anything._get_type_name()


    def optional_chaining(callback_function: PythonObject) -> PythonObject:
        try:
            return callback_function()
        except any_exception:
            return None


    def nullish_coalescing(anything: PythonObject, default_value: PythonObject) -> PythonObject:
        return (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''



    json_stringify_vmojo_string = "".join(
        '(json_stringify_vmojo := lambda anything, pretty=False, js_like_type=({"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}): (json_stringify_inner := lambda anything_inner, indent=(" " * 4), indent_level=0, get_type=(lambda anything: (js_like_type["Null"] if ((is_like_js_null := (lambda anything: (anything is None)))(anything) == True) else js_like_type["Boolean"] if ((is_like_js_boolean := (lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))))(anything) == True) else js_like_type["String"] if ((is_like_js_string := (lambda anything: (isinstance(anything, str) == True)))(anything) == True) else js_like_type["Numeric"] if ((is_like_js_numeric := (lambda anything: (isinstance(anything, (__import__(',
        "'",
        'numbers',
        "'",
        ').Number,)) == True)))(anything) == True) else js_like_type["Object"] if ((is_like_js_object := (lambda anything: (isinstance(anything, dict) == True)))(anything) == True) else js_like_type["Array"] if ((is_like_js_array := (lambda anything: (isinstance(anything, list) == True)))(anything) == True) else js_like_type["Function"] if ((is_like_js_function := (lambda anything: (callable(anything) == True)))(anything) == True) else str(type(anything)))): ("null" if ((anything_inner_type := get_type(anything_inner)) == js_like_type["Null"]) else (',
        "'",
        '"',
        "'",
        ' + str(anything_inner) + ',
        "'",
        '"',
        "'",
        ') if (anything_inner_type == js_like_type["String"]) else str(anything_inner) if (anything_inner_type == js_like_type["Numeric"]) else "true" if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == True)) else "false" if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == False)) else (("{" + "}") if (len(anything_inner) == 0) else ("".join([(("{\\n" + (indent * (indent_level + 1))) if (pretty == True) else "{ "), *[(((',
        "'",
        '"',
        "'",
        ' + object_key + ',
        "'",
        '": ',
        "'",
        ' + json_stringify_inner(object_value, indent_level=(indent_level + 1))) + ((",\\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((object_entry_index + 1) != len(anything_inner)) else (',
        "'",
        '"',
        "'",
        ' + object_key + ',
        "'",
        '": ',
        "'",
        ' + json_stringify_inner(object_value, indent_level=(indent_level + 1)))) for (object_entry_index, (object_key, object_value)) in enumerate(anything_inner.items())], (("\\n" + (indent * indent_level) + "}") if (pretty == True) else " }")]))) if (anything_inner_type == js_like_type["Object"]) else ("[]" if (len(anything_inner) == 0) else ("".join([(("[\\n" + (indent * (indent_level + 1))) if (pretty == True) else "["), *[((json_stringify_inner(array_item, indent_level=(indent_level + 1)) + ((",\\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((array_item_index + 1) != len(anything_inner)) else json_stringify_inner(array_item, indent_level=(indent_level + 1))) for (array_item_index, array_item) in enumerate(anything_inner)], (("\\n" + (indent * indent_level) + "]") if (pretty == True) else "]")]))) if (anything_inner_type == js_like_type["Array"]) else "[object Function]" if (anything_inner_type == js_like_type["Function"]) else anything_inner_type))(anything))'
    )

    print(json_stringify_vmojo_string)
    json_stringify_vmojo = Python.evaluate(json_stringify_vmojo_string)


    print("".join("get_type(my_string): ", get_type(my_object["my_string"])))
    print("".join("is_like_js_string(my_string): ", is_like_js_string(my_object["my_string"])))
    print("".join("get_type(my_number): ", get_type(my_object["my_number"])))
    print("".join("is_like_js_numeric(my_number): ", is_like_js_numeric(my_object["my_number"])))
    print("".join("get_type(my_bool): ", get_type(my_object["my_bool"])))
    print("".join("is_like_js_boolean(my_bool): ", is_like_js_boolean(my_object["my_bool"])))
    print("".join("get_type(my_null): ", get_type(my_object["my_null"])))
    print("".join("is_like_js_null(my_null): ", is_like_js_null(my_object["my_null"])))
    print("".join("get_type(my_array): ", get_type(my_object["my_array"])))
    print("".join("is_like_js_array(my_array): ", is_like_js_array(my_object["my_array"])))
    print("".join("get_type(my_object): ", get_type(my_object["my_object"])))
    print("".join("is_like_js_object(my_object): ", is_like_js_object(my_object["my_object"])))
    print("".join("get_type(my_function): ", get_type(my_object["my_function"])))
    print("".join("is_like_js_function(my_function): ", is_like_js_function(my_object["my_function"])))
    print("".join("get_type(1.56): ", get_type(1.56)))
    print("".join("is_like_js_numeric(1.56): ", is_like_js_numeric(1.56)))
    print("".join("is_like_js_object(my_object): ", is_like_js_object(my_object)))

    my_function = Python.evaluate('lambda a, b: (a * b)')
    print(get_type(my_function))

    # def get_modified_indent_level() -> PythonObject:
    #     indent_level = 0


    #     def change_indent_level() -> PythonObject:
    #         print("".join("indent_level inside before: ", indent_level))
    #         indent_level += 1
    #         print("".join("indent_level inside after: ", indent_level))
    #         if (indent_level < 5):
    #             print("".join("indent_level < 5"))
    #             # change_indent_level()  # this throw error
    #             # https://docs.modular.com/mojo/roadmap/#nested-functions-cannot-be-recursive
    #             # Nested functions cannot be recursive
    #             # Nested functions (any function that is not a top-level function) cannot be recursive in any way. Nested functions are considered "parameters", and although parameter values do not have to obey lexical order, their uses and definitions cannot form a cycle. Current limitations in Mojo mean that nested functions, which are considered parameter values, cannot be cyclic.
    #         return indent_level
    #         # return 0


    #     print("".join("indent_level outside after: ", indent_level))
    #     return change_indent_level()


    # print("".join("get_modified_indent_level(): ", get_modified_indent_level()))


    def get_modified_indent_level() -> PythonObject:
        var indent_level: PythonObject = 0


        def change_indent_level() -> PythonObject:
            while (indent_level < 5):
                indent_level += 1
            return indent_level


        return change_indent_level()


    print("".join("get_modified_indent_level(): ", get_modified_indent_level()))

    var something: PythonObject
    something = "foo"
    print("something: ", json_stringify_vmojo(something))
    something = 123
    print("something: ", json_stringify_vmojo(something))
    something = True
    print("something: ", json_stringify_vmojo(something))
    something = None
    print("something: ", json_stringify_vmojo(something))
    something = [1, 2, 3]
    print("something: ", json_stringify_vmojo(something))
    something = create_new_object("foo", "bar")
    print("something: ", json_stringify_vmojo(something))
