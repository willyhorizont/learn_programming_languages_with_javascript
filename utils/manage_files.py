import os
import csv

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))

PATH_CODES_JAVASCRIPT = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'javascript', 'src')
PATH_CODES_PYTHON = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'python')
PATH_CODES_PHP = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'php')
PATH_CODES_GO = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'go')
PATH_CODES_PERL = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'perl')
PATH_CODES_JULIA = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'julia')
PATH_CODES_LUA = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'lua')
PATH_CODES_RUBY = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'ruby')
PATH_CODES_R = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'r')
PATH_CODES_KOTLIN = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'kotlin')

filenames = [
    "000.notes",
    "001.comment",
    "002.hello_world",
    "003.Conditionals",
    "004.Loops",
    "005.Objects",
    "006.Arrays",
    "007.Functions",
    "008.operator_ternary",
    "009.operator_optional_chaining",
    "010.operator_nullish_coalescing",
    "011.operator_spread",
    # "Array.every",
    # "Array.filter",
    # "Array.find",
    # "Array.findIndex",
    # "Array.includes",
    # "Array.map",
    # "Array.reduce",
    # "Array.some",
    # "factorial",
    # "fizzbuzz",
    "xxx.chaos",
]

new_filenames = [
    "000.notes",
    "001.comment",
    "002.hello_world",
    "003.Conditionals",
    "004.Loops",
    "005.Objects",
    "006.Arrays",
    "007.Functions",
    "008.operator_ternary",
    "009.operator_optional_chaining",
    "010.operator_nullish_coalescing",
    "011.operator_spread",
    # "Array.every",
    # "Array.filter",
    # "Array.find",
    # "Array.findIndex",
    # "Array.includes",
    # "Array.map",
    # "Array.reduce",
    # "Array.some",
    # "factorial",
    # "fizzbuzz",
    "xxx.chaos",
]

PATH_CODES = [
    PATH_CODES_JAVASCRIPT,
    PATH_CODES_PYTHON,
    PATH_CODES_PHP,
    PATH_CODES_GO,
    PATH_CODES_PERL,
    PATH_CODES_JULIA,
    PATH_CODES_LUA,
    PATH_CODES_RUBY,
    PATH_CODES_R,
    PATH_CODES_KOTLIN
]


def array_find_index_v6(callback_function, an_array):
    '''JavaScript-like Array.findIndex() function'''
    for array_item_index, array_item in enumerate(an_array):
        if (callback_function(array_item, array_item_index, an_array) == True):
            return array_item_index
    return -1


def rename_files(path_code):
    for filename in os.listdir(path_code):
        path_filename = os.path.join(path_code, filename)
        if os.path.isdir(path_filename):
            path_foldername = path_filename
            foldername_index = array_find_index_v6(lambda current_foldername, *_: current_foldername == filename, filenames)
            if foldername_index == -1:
                continue
            path_new_foldername = os.path.join(path_code, new_filenames[foldername_index])
            if (path_foldername == path_new_foldername):
                continue
            os.replace(path_foldername, path_new_foldername)
            rename_files(path_new_foldername)
            continue
        if os.path.isfile(path_filename):
            filename_extension_tuple = os.path.splitext(os.path.splitext(os.path.basename(path_filename))[0]) if "0.notes" in filename else os.path.splitext(os.path.basename(path_filename))
            filename_without_extension = filename_extension_tuple[0]
            filename_extension = filename_extension_tuple[1]
            filename_index = array_find_index_v6(lambda current_filename, *_: current_filename == filename_without_extension, filenames)
            if filename_index == -1:
                continue
            new_filename = new_filenames[filename_index] + filename_extension + ".txt" if "0.notes" in filename else new_filenames[filename_index] + filename_extension
            path_new_filename = os.path.join(path_code, new_filename)
            if (path_filename == path_new_filename):
                continue
            os.replace(path_filename, path_new_filename)

def main():
    for path_code in PATH_CODES:
        rename_files(path_code)
if __name__ == "__main__":
    main()
