print_then_return = lambda anything: [print(anything), anything][-1]
from get_type import js_like_type, is_like_js_null, is_like_js_boolean, is_like_js_string, is_like_js_numeric, is_like_js_object, is_like_js_array, is_like_js_function, get_type_v2 as get_type
from array_reduce import js_like_array_reduce_v2 as js_like_array_reduce
from array_map import js_like_array_map_v6 as js_like_array_map
from json_stringify import json_stringify_v9 as json_stringify
from iso_8601_string import get_iso_8601_string_v2 as get_iso_8601_string
# from extract_date import get_iso_8601_string_v2 as extract_date
