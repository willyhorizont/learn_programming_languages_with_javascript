import os
import shutil

file_names_sorted = [
    "000_notes",
    "001_comment",
    "002_hello_world",
    "003_conditionals",
    "004_loops",
    "005_objects",
    "006_arrays",
    "007_functions",
    "008_operator_ternary",
    "009_operator_optional_chaining",
    "010_operator_nullish_coalescing",
    "011_operator_spread",
    "array_every",
    "array_filter",
    "array_find",
    "array_find_index",
    "array_includes",
    "array_map",
    "array_reduce",
    "array_some",
    "custom_error_and_error_handling",
    "factorial",
    "fizzbuzz",
    "www_001_abbreviate_name",
    "www_002_count_vowels",
    "xxx_chaos",
    "yyy_required_features",
]

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))


def manage_go_files():
    path_directory_go = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'go')
    for file_name in file_names_sorted:
        current_path = os.path.join(path_directory_go, file_name)
        if os.path.isdir(current_path) == False:
            print(f"{current_path} directory is not found")
        if os.path.isdir(current_path):
            for a_file_name in os.listdir(current_path):
                path_file = os.path.join(current_path, a_file_name)
                if a_file_name.endswith(".go.txt"):
                    if a_file_name != f"{file_names_sorted[0]}.go.txt":
                        shutil.move(path_file, os.path.join(current_path, f"{file_names_sorted[0]}.go.txt"))
                    continue
                if a_file_name.endswith(".go"):
                    if a_file_name != f"{file_name}.go":
                        shutil.move(path_file, os.path.join(current_path, f"{file_name}.go"))
                    continue
                if a_file_name == "go.mod":
                    with open(path_file, "w+") as file_content_go_mod:
                        file_content_go_mod.write(f"""module {file_name}

go 1.21.4
""")


def main():
    manage_go_files()


if __name__ == "__main__":
    main()
