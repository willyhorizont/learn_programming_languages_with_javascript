import os
import csv

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))

PATH_CODES_KOTLIN = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'kotlin')
PATH_CODES_TRIAL = os.path.join(PATH_CURRENT_FILE, '..', 'codes_trial')

PATH_CODES = [
    PATH_CODES_KOTLIN,
    PATH_CODES_TRIAL
]

compiled_extensions = [
    ".jar",
    ".exe"
]


def delete_compiled(path_code):
    for filename in os.listdir(path_code):
        path_filename = os.path.join(path_code, filename)
        if os.path.isdir(path_filename):
            delete_compiled(path_filename)
            continue
        if os.path.isfile(path_filename) and any([compiled_extension in filename for compiled_extension in compiled_extensions]):
            os.remove(path_filename)


def main():
    for path_code in PATH_CODES:
        delete_compiled(path_code)


if __name__ == "__main__":
    main()
