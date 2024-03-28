import os
import csv

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))
PATH_CSV_OUTPUT_LIST_FILE = os.path.join(PATH_CURRENT_FILE, '..', 'file_list.csv')

files_to_be_excluded = ["go.mod", "JSON.lua"]


def get_file_list(path_file):
    file_list = []
    def get_file_list_inner_function(path_file_inner):
        for file_or_folder in os.listdir(path_file_inner):
            current_path_file = os.path.join(path_file_inner, file_or_folder)
            if os.path.isfile(current_path_file):
                if file_or_folder not in files_to_be_excluded:
                    file_list.append(file_or_folder)
                continue
            if (new_file_or_folder := get_file_list_inner_function(current_path_file)) is not None:
                file_list.append(new_file_or_folder)
    get_file_list_inner_function(path_file)
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
    PATH_CODES_VISUAL_BASIC_DOTNET = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'visual_basic_dotnet')
    PATH_CODES_CSHARP = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'csharp')
    PATH_CODES_MATLAB = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'matlab')
    PATH_CODES_GNU_OCTAVE = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'gnu_octave')
    PATH_CODES_WOLFRAM = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'wolfram')
    # PATH_CODES_RAKU = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'raku')

    FILE_CODES_JAVASCRIPT = get_file_list(PATH_CODES_JAVASCRIPT)
    FILE_CODES_PYTHON = get_file_list(PATH_CODES_PYTHON)
    FILE_CODES_PHP = get_file_list(PATH_CODES_PHP)
    FILE_CODES_GO = get_file_list(PATH_CODES_GO)
    FILE_CODES_PERL = get_file_list(PATH_CODES_PERL)
    FILE_CODES_JULIA = get_file_list(PATH_CODES_JULIA)
    FILE_CODES_LUA = get_file_list(PATH_CODES_LUA)
    FILE_CODES_RUBY = get_file_list(PATH_CODES_RUBY)
    FILE_CODES_R = get_file_list(PATH_CODES_R)
    FILE_CODES_KOTLIN = get_file_list(PATH_CODES_KOTLIN)
    FILE_CODES_SWIFT = get_file_list(PATH_CODES_SWIFT)
    FILE_CODES_DART = get_file_list(PATH_CODES_DART)
    FILE_CODES_VISUAL_BASIC_DOTNET = get_file_list(PATH_CODES_VISUAL_BASIC_DOTNET)
    FILE_CODES_CSHARP = get_file_list(PATH_CODES_CSHARP)
    FILE_CODES_MATLAB = get_file_list(PATH_CODES_MATLAB)
    FILE_CODES_GNU_OCTAVE = get_file_list(PATH_CODES_GNU_OCTAVE)
    FILE_CODES_WOLFRAM = get_file_list(PATH_CODES_WOLFRAM)
    # FILE_CODES_RAKU = get_file_list(PATH_CODES_RAKU)

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
    FILE_CODES_VISUAL_BASIC_DOTNET = ["VISUAL_BASIC_DOTNET", *FILE_CODES_VISUAL_BASIC_DOTNET]
    FILE_CODES_CSHARP = ["C#", *FILE_CODES_CSHARP]
    FILE_CODES_MATLAB = ["MATLAB", *FILE_CODES_MATLAB]
    FILE_CODES_GNU_OCTAVE = ["GNU_OCTAVE", *FILE_CODES_GNU_OCTAVE]
    FILE_CODES_WOLFRAM = ["WOLFRAM", *FILE_CODES_WOLFRAM]
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
        FILE_CODES_VISUAL_BASIC_DOTNET,
        FILE_CODES_CSHARP,
        FILE_CODES_MATLAB,
        FILE_CODES_GNU_OCTAVE,
        FILE_CODES_WOLFRAM,
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
