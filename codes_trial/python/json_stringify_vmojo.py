(json_stringify_vmojo := lambda anything, pretty=False, js_like_type=({"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}): (json_stringify_inner := lambda anything_inner, indent=(" " * 4), indent_level=0, get_type=(lambda anything: (js_like_type["Null"] if ((is_like_js_null := (lambda anything: (anything is None)))(anything) == True) else js_like_type["Boolean"] if ((is_like_js_boolean := (lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))))(anything) == True) else js_like_type["String"] if ((is_like_js_string := (lambda anything: (isinstance(anything, str) == True)))(anything) == True) else js_like_type["Numeric"] if ((is_like_js_numeric := (lambda anything: (isinstance(anything, (__import__('numbers').Number,)) == True)))(anything) == True) else js_like_type["Object"] if ((is_like_js_object := (lambda anything: (isinstance(anything, dict) == True)))(anything) == True) else js_like_type["Array"] if ((is_like_js_array := (lambda anything: (isinstance(anything, list) == True)))(anything) == True) else js_like_type["Function"] if ((is_like_js_function := (lambda anything: (callable(anything) == True)))(anything) == True) else str(type(anything)))): ("null" if ((anything_inner_type := get_type(anything_inner)) == js_like_type["Null"]) else ('"' + str(anything_inner) + '"') if (anything_inner_type == js_like_type["String"]) else str(anything_inner) if (anything_inner_type == js_like_type["Numeric"]) else "true" if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == True)) else "false" if ((anything_inner_type == js_like_type["Boolean"]) and (anything_inner == False)) else (("{" + "}") if (len(anything_inner) == 0) else ("".join([(("{\n" + (indent * (indent_level + 1))) if (pretty == True) else "{ "), *[((('"' + str(object_key) + '": ' + json_stringify_inner(object_value, indent_level=(indent_level + 1))) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((object_entry_index + 1) != len(anything_inner)) else ('"' + str(object_key) + '": ' + json_stringify_inner(object_value, indent_level=(indent_level + 1)))) for (object_entry_index, (object_key, object_value)) in enumerate(anything_inner.items())], (("\n" + (indent * indent_level) + "}") if (pretty == True) else " }")]))) if (anything_inner_type == js_like_type["Object"]) else ("[]" if (len(anything_inner) == 0) else ("".join([(("[\n" + (indent * (indent_level + 1))) if (pretty == True) else "["), *[((json_stringify_inner(array_item, indent_level=(indent_level + 1)) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((array_item_index + 1) != len(anything_inner)) else json_stringify_inner(array_item, indent_level=(indent_level + 1))) for (array_item_index, array_item) in enumerate(anything_inner)], (("\n" + (indent * indent_level) + "]") if (pretty == True) else "]")]))) if (anything_inner_type == js_like_type["Array"]) else "[object Function]" if (anything_inner_type == js_like_type["Function"]) else anything_inner_type))(anything))