import os
import shutil

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))

files_to_be_excluded = ["go.mod", "JSON.lua"]


def get_file_path_list(path_file, exclude_list):
    file_list = []
    def get_file_list_inner_function(path_file_inner, exclude_list_inner):
        for file_or_folder in os.listdir(path_file_inner):
            current_path_file = os.path.join(path_file_inner, file_or_folder)
            if os.path.isfile(current_path_file):
                if file_or_folder not in exclude_list_inner:
                    file_list.append({ "file_name": file_or_folder, "file_path": current_path_file})
                continue
            if (new_file_or_folder := get_file_list_inner_function(current_path_file, exclude_list_inner)) is not None:
                file_list.append({ "file_name": new_file_or_folder, "file_path": current_path_file })
    get_file_list_inner_function(path_file, exclude_list)
    return file_list


def rename_files():
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
    # PATH_CODES_RAKU = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'raku')

    FILE_PATHS_JAVASCRIPT = get_file_path_list(PATH_CODES_JAVASCRIPT, files_to_be_excluded)
    FILE_PATHS_PYTHON = get_file_path_list(PATH_CODES_PYTHON, files_to_be_excluded)
    FILE_PATHS_PHP = get_file_path_list(PATH_CODES_PHP, files_to_be_excluded)
    FILE_PATHS_GO = get_file_path_list(PATH_CODES_GO, files_to_be_excluded)
    FILE_PATHS_PERL = get_file_path_list(PATH_CODES_PERL, files_to_be_excluded)
    FILE_PATHS_JULIA = get_file_path_list(PATH_CODES_JULIA, files_to_be_excluded)
    FILE_PATHS_LUA = get_file_path_list(PATH_CODES_LUA, files_to_be_excluded)
    FILE_PATHS_RUBY = get_file_path_list(PATH_CODES_RUBY, files_to_be_excluded)
    FILE_PATHS_R = get_file_path_list(PATH_CODES_R, files_to_be_excluded)
    FILE_PATHS_KOTLIN = get_file_path_list(PATH_CODES_KOTLIN, files_to_be_excluded)
    FILE_PATHS_SWIFT = get_file_path_list(PATH_CODES_SWIFT, files_to_be_excluded)
    FILE_PATHS_DART = get_file_path_list(PATH_CODES_DART, files_to_be_excluded)
    # FILE_PATHS_RAKU = get_file_path_list(PATH_CODES_RAKU, files_to_be_excluded)

    CODES_JAVASCRIPT = { "programming_language_name": "JAVASCRIPT", "file_extension": ".js", "file_path_and_name": FILE_PATHS_JAVASCRIPT }
    CODES_PYTHON = { "programming_language_name": "PYTHON", "file_extension": ".py", "file_path_and_name": FILE_PATHS_PYTHON }
    CODES_PHP = { "programming_language_name": "PHP", "file_extension": ".php", "file_path_and_name": FILE_PATHS_PHP }
    CODES_GO = { "programming_language_name": "GO", "file_extension": ".go", "file_path_and_name": FILE_PATHS_GO }
    CODES_PERL = { "programming_language_name": "PERL", "file_extension": ".pl", "file_path_and_name": FILE_PATHS_PERL }
    CODES_JULIA = { "programming_language_name": "JULIA", "file_extension": ".jl", "file_path_and_name": FILE_PATHS_JULIA }
    CODES_LUA = { "programming_language_name": "LUA", "file_extension": ".lua", "file_path_and_name": FILE_PATHS_LUA }
    CODES_RUBY = { "programming_language_name": "RUBY", "file_extension": ".rb", "file_path_and_name": FILE_PATHS_RUBY }
    CODES_R = { "programming_language_name": "R", "file_extension": ".r", "file_path_and_name": FILE_PATHS_R }
    CODES_KOTLIN = { "programming_language_name": "KOTLIN", "file_extension": ".kt", "file_path_and_name": FILE_PATHS_KOTLIN }
    CODES_SWIFT = { "programming_language_name": "SWIFT", "file_extension": ".swift", "file_path_and_name": FILE_PATHS_SWIFT }
    CODES_DART = { "programming_language_name": "DART", "file_extension": ".dart", "file_path_and_name": FILE_PATHS_DART }
    # CODES_RAKU = { "programming_language_name": "RAKU", "file_extension": ".raku", "file_path_and_name": FILE_PATHS_RAKU }

    CODES = [
        CODES_JAVASCRIPT,
        CODES_PYTHON,
        CODES_PHP,
        CODES_GO,
        CODES_PERL,
        CODES_JULIA,
        CODES_LUA,
        CODES_RUBY,
        CODES_R,
        CODES_KOTLIN,
        CODES_SWIFT,
        CODES_DART,
        # CODES_RAKU
    ]

    for code in CODES:
        # shutil.move(code, dst)
        file_extension = code.get("file_extension")
        for file_path_and_name in code.get("file_path_and_name"):
            file_name = file_path_and_name.get("file_name")
            file_path = file_path_and_name.get("file_path")
            if ".txt" in file_name:
                new_file_name = file_name.replace(file_extension, "").replace(".txt", "").replace(".", "_").lower() + file_extension + ".txt"
                new_file_path = file_path.replace(file_name, new_file_name)
                shutil.move(file_path, new_file_path)
                continue
            new_file_name = file_name.replace(file_extension, "").replace(".", "_").lower() + file_extension
            new_file_path = file_path.replace(file_name, new_file_name)
            shutil.move(file_path, new_file_path)


if __name__ == "__main__":
    rename_files()
