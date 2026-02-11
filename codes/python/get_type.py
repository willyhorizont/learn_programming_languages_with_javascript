import datetime

js_like_type = { "Null": "Null", "Undefined": "Undefined", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function", "Error": "Error", "Date": "Date" }

is_like_js_null = lambda anything: (anything is None)

is_like_js_undefined = lambda anything: (anything is None)

is_like_js_boolean = lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))

is_like_js_string = lambda anything: (isinstance(anything, str) == True)

is_like_js_numeric = lambda anything: (isinstance(anything, (__import__("numbers")).Number) == True)

is_like_js_object = lambda anything: (isinstance(anything, dict) == True)

is_like_js_array = lambda anything: (isinstance(anything, list) == True)

is_like_js_function = lambda anything: (callable(anything) == True)

is_like_js_error = lambda anything: (isinstance(anything, BaseException) == True)

is_like_js_date = lambda anything: (isinstance(anything, datetime.datetime) == True)


def get_type_v1(anything):
    '''get_type_v1'''
    if (is_like_js_null(anything) == True):
        return js_like_type["Null"]
    if (is_like_js_undefined(anything) == True):
        return js_like_type["Undefined"]
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
    if (is_like_js_error(anything) == True):
        return js_like_type["Error"]
    if (is_like_js_date(anything) == True):
        return js_like_type["Date"]
    return str(type(anything))


get_type_v2 = lambda anything: (js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else str(type(anything)))  # '''get_type_v2'''


def main():
    from utils import json_stringify

    print("# get type of something in Python")

    any_string = "foo"
    print(f"any_string: {json_stringify(any_string)}")
    print(f'type of any_string: "{get_type_v1(any_string)}"')
    print(f'type of any_string: "{get_type_v2(any_string)}"')

    any_numeric = 123
    print(f"any_numeric: {json_stringify(any_numeric)}")
    print(f'type of any_numeric: "{get_type_v1(any_numeric)}"')
    print(f'type of any_numeric: "{get_type_v2(any_numeric)}"')

    any_boolean = True
    print(f"any_boolean: {json_stringify(any_boolean)}")
    print(f'type of any_boolean: "{get_type_v1(any_boolean)}"')
    print(f'type of any_boolean: "{get_type_v2(any_boolean)}"')

    any_null = None
    print(f"any_null: {json_stringify(any_null)}")
    print(f'type of any_null: "{get_type_v1(any_null)}"')
    print(f'type of any_null: "{get_type_v2(any_null)}"')

    any_array = [1, 2, 3]
    print(f"any_array: {json_stringify(any_array)}")
    print(f'type of any_array: "{get_type_v1(any_array)}"')
    print(f'type of any_array: "{get_type_v2(any_array)}"')

    any_object = {"foo": "bar"}
    print(f"any_object: {json_stringify(any_object)}")
    print(f'type of any_object: "{get_type_v1(any_object)}"')
    print(f'type of any_object: "{get_type_v2(any_object)}"')

    any_error = Exception('Exception: You should give me "respect"!')
    print(f"any_error: {json_stringify(any_error)}")
    print(f'type of any_error: "{get_type_v1(any_error)}"')
    print(f'type of any_error: "{get_type_v2(any_error)}"')

    any_date = datetime.datetime.now()
    print(f"any_date: {json_stringify(any_date)}")
    print(f'type of any_date: "{get_type_v1(any_date)}"')
    print(f'type of any_date: "{get_type_v2(any_date)}"')


if __name__ == "__main__":
    main()
