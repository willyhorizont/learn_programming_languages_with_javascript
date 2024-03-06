import os
import csv

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))
PATH_CSV_OUTPUT_LIST_FILE = os.path.join(PATH_CURRENT_FILE, '..', 'file_list.csv')

files_to_be_excluded = ["go.mod", "JSON.lua"]


def get_file_list(path_file, exclude_list):
    file_list = []
    def get_file_list_inner_function(path_file_inner, exclude_list_inner):
        for file_or_folder in os.listdir(path_file_inner):
            current_path_file = os.path.join(path_file_inner, file_or_folder)
            if os.path.isfile(current_path_file):
                if file_or_folder not in exclude_list_inner:
                    file_list.append(file_or_folder)
                continue
            if (new_file_or_folder := get_file_list_inner_function(current_path_file, exclude_list_inner)) is not None:
                file_list.append(new_file_or_folder)
    get_file_list_inner_function(path_file, exclude_list)
    return file_list


def list_files():
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
    PATH_CODES_SWIFT = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'swift')
    PATH_CODES_DART = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'dart')
    # PATH_CODES_VB = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'vb')
    # PATH_CODES_CS = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'c#')
    # PATH_CODES_GDSCRIPT = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'gdscript')
    # PATH_CODES_RAKU = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'raku')

    FILE_CODES_JAVASCRIPT = get_file_list(PATH_CODES_JAVASCRIPT, files_to_be_excluded)
    FILE_CODES_PYTHON = get_file_list(PATH_CODES_PYTHON, files_to_be_excluded)
    FILE_CODES_PHP = get_file_list(PATH_CODES_PHP, files_to_be_excluded)
    FILE_CODES_GO = get_file_list(PATH_CODES_GO, files_to_be_excluded)
    FILE_CODES_PERL = get_file_list(PATH_CODES_PERL, files_to_be_excluded)
    FILE_CODES_JULIA = get_file_list(PATH_CODES_JULIA, files_to_be_excluded)
    FILE_CODES_LUA = get_file_list(PATH_CODES_LUA, files_to_be_excluded)
    FILE_CODES_RUBY = get_file_list(PATH_CODES_RUBY, files_to_be_excluded)
    FILE_CODES_R = get_file_list(PATH_CODES_R, files_to_be_excluded)
    FILE_CODES_KOTLIN = get_file_list(PATH_CODES_KOTLIN, files_to_be_excluded)
    FILE_CODES_SWIFT = get_file_list(PATH_CODES_SWIFT, files_to_be_excluded)
    FILE_CODES_DART = get_file_list(PATH_CODES_DART, files_to_be_excluded)
    # FILE_CODES_VB = get_file_list(PATH_CODES_VB, files_to_be_excluded)
    # FILE_CODES_CS = get_file_list(PATH_CODES_CS, files_to_be_excluded)
    # FILE_CODES_GDSCRIPT = get_file_list(PATH_CODES_GDSCRIPT, files_to_be_excluded)
    # FILE_CODES_RAKU = get_file_list(PATH_CODES_RAKU, files_to_be_excluded)

    FILE_CODES_JAVASCRIPT = ["JAVASCRIPT", *FILE_CODES_JAVASCRIPT]
    FILE_CODES_PYTHON = ["PYTHON", *FILE_CODES_PYTHON]
    FILE_CODES_PHP = ["PHP", *FILE_CODES_PHP]
    FILE_CODES_GO = ["GO", *FILE_CODES_GO]
    FILE_CODES_PERL = ["PERL", *FILE_CODES_PERL]
    FILE_CODES_JULIA = ["JULIA", *FILE_CODES_JULIA]
    FILE_CODES_LUA = ["LUA", *FILE_CODES_LUA]
    FILE_CODES_RUBY = ["RUBY", *FILE_CODES_RUBY]
    FILE_CODES_R = ["R", *FILE_CODES_R]
    FILE_CODES_KOTLIN = ["KOTLIN", *FILE_CODES_KOTLIN]
    FILE_CODES_SWIFT = ["SWIFT", *FILE_CODES_SWIFT]
    FILE_CODES_DART = ["DART", *FILE_CODES_DART]
    # FILE_CODES_VB = ["VB", *FILE_CODES_VB]
    # FILE_CODES_CS = ["C#", *FILE_CODES_CS]
    # FILE_CODES_GDSCRIPT = ["GDSCRIPT", *FILE_CODES_GDSCRIPT]
    # FILE_CODES_RAKU = ["RAKU", *FILE_CODES_RAKU]

    FILE_CODES = [
        FILE_CODES_JAVASCRIPT,
        FILE_CODES_PYTHON,
        FILE_CODES_PHP,
        FILE_CODES_GO,
        FILE_CODES_PERL,
        FILE_CODES_JULIA,
        FILE_CODES_LUA,
        FILE_CODES_RUBY,
        FILE_CODES_R,
        FILE_CODES_KOTLIN,
        FILE_CODES_SWIFT,
        FILE_CODES_DART,
        # FILE_CODES_VB,
        # FILE_CODES_CS,
        # FILE_CODES_GDSCRIPT,
        # FILE_CODES_RAKU
    ]

    if os.path.isfile(PATH_CSV_OUTPUT_LIST_FILE):
        os.remove(PATH_CSV_OUTPUT_LIST_FILE)

    for FILE_CODE in FILE_CODES:
        with open(PATH_CSV_OUTPUT_LIST_FILE, 'a', newline='') as csv_file:
            file_codes_list_csv_writer = csv.writer(csv_file, delimiter=";")
            file_codes_list_csv_writer.writerow(FILE_CODE)


if __name__ == "__main__":
    list_files()
