from python import Python, PythonObject


def main():


    def create_new_object(*rest_arguments: PythonObject) -> PythonObject:
        var new_object: PythonObject = Python.dict()
        current_index = 0
        while (current_index < len(rest_arguments)):
            if ((current_index % 3) == 0):
                new_object_key = rest_arguments[current_index]
                new_object_value = rest_arguments[current_index + 2]
                new_object[new_object_key] = new_object_value
            current_index += 1
        return new_object


    def create_new_array(*rest_arguments: PythonObject) -> PythonObject:
        var new_array: PythonObject = Python.list()
        current_index = 0
        while (current_index < len(rest_arguments)):
            new_array_item = rest_arguments[current_index]
            new_array.append(new_array_item)
            current_index += 1
        return new_array


    js_like_type = create_new_object("Null", ":", "Null", "Boolean", ":", "Boolean", "String", ":", "String", "Numeric", ":", "Numeric", "Object", ":", "Object", "Array", ":", "Array", "Function", ":", "Function")


    def array_reduce(callback_function: PythonObject, any_array: PythonObject, initial_value: PythonObject) -> PythonObject:
        '''JavaScript-like Array.reduce() function'''
        result = initial_value
        array_item_index = 0
        while (array_item_index < len(any_array)):
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
        return js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else anything._get_type_name()


    def optional_chaining(callback_function: PythonObject) -> PythonObject:
        try:
            return callback_function()
        except any_exception:
            return None


    def nullish_coalescing(anything: PythonObject, default_value: PythonObject) -> PythonObject:
        return (default_value if (is_like_js_null(anything) == True) else anything)


    json_stringify = Python.evaluate("".join('(json_stringify_vmojo := lambda anything, pretty=False, js_like_type=({"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}): (json_stringify_inner := lambda anything_inner, indent=(" " * 4), indent_level=0, get_type=(lambda anything: (js_like_type["Null"] if ((is_like_js_null := (lambda anything: (anything is None)))(anything) == True) else js_like_type["Boolean"] if ((is_like_js_boolean := (lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))))(anything) == True) else js_like_type["String"] if ((is_like_js_string := (lambda anything: (isinstance(anything, str) == True)))(anything) == True) else js_like_type["Numeric"] if ((is_like_js_numeric := (lambda anything: (isinstance(anything, (__import__(', "'", 'numbers', "'", ').Number,)) == True)))(anything) == True) else js_like_type["Object"] if ((is_like_js_object := (lambda anything: (isinstance(anything, dict) == True)))(anything) == True) else js_like_type["Array"] if ((is_like_js_array := (lambda anything: (isinstance(anything, list) == True)))(anything) == True) else js_like_type["Function"] if ((is_like_js_function := (lambda anything: (callable(anything) == True)))(anything) == True) else str(type(anything)))): ("null" if ((anything_inner_type := get_type(anything_inner)) == js_like_type["Null"]) else (', "'", '"', "'", ' + str(anything_inner) + ', "'", '"', "'", ') if (anything_inner_type == js_like_type["String"]) else str(anything_inner) if (anything_inner_type == js_like_type["Numeric"]) else "true" if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == True)) else "false" if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == False)) else (("{" + "}") if (len(anything_inner) == 0) else ("".join([(("{\\n" + (indent * (indent_level + 1))) if (pretty == True) else "{ "), *[(((', "'", '"', "'", ' + str(object_key) + ', "'", '": ', "'", ' + json_stringify_inner(object_value, indent_level=(indent_level + 1))) + ((",\\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((object_entry_index + 1) != len(anything_inner)) else (', "'", '"', "'", ' + st(object_key) + ', "'", '": ', "'", ' + json_stringify_inner(object_value, indent_level=(indent_level + 1)))) for (object_entry_index, (object_key, object_value)) in enumerate(anything_inner.items())], (("\\n" + (indent * indent_level) + "}") if (pretty == True) else " }")]))) if (anything_inner_type == js_like_type["Object"]) else ("[]" if (len(anything_inner) == 0) else ("".join([(("[\\n" + (indent * (indent_level + 1))) if (pretty == True) else "["), *[((json_stringify_inner(array_item, indent_level=(indent_level + 1)) + ((",\\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((array_item_index + 1) != len(anything_inner)) else json_stringify_inner(array_item, indent_level=(indent_level + 1))) for (array_item_index, array_item) in enumerate(anything_inner)], (("\\n" + (indent * indent_level) + "]") if (pretty == True) else "]")]))) if (anything_inner_type == js_like_type["Array"]) else "[object Function]" if (anything_inner_type == js_like_type["Function"]) else anything_inner_type))(anything))'))

    print("# JavaScript-like JSON.stringify() in Python")

    var my_array: PythonObject = create_new_array(
        Python.evaluate("lambda a, b: (a * b)"),
        "foo",
        123,
        True,
        None,
        create_new_array(1, 2, 3),
        create_new_object("foo", ":", "bar")
    )
    print("".join('json_stringify(my_array): ', json_stringify(my_array)))
    print("".join('json_stringify(my_array, pretty=True): ', json_stringify(my_array, pretty=True)))

    var my_object: PythonObject = create_new_object(
        "my_function", ":", Python.evaluate("lambda a, b: (a * b)"),
        "my_string", ":", "foo",
        "my_number", ":", 123,
        "my_bool", ":", True,
        "my_null", ":", None,
        "my_array", ":", create_new_array(1, 2, 3),
        "my_object", ":", create_new_object(
            "foo", ":", "bar"
        )
    )
    print("".join('json_stringify(my_object): ', json_stringify(my_object)))
    print("".join('json_stringify(my_object, pretty=True): ', json_stringify(my_object, pretty=True)))

