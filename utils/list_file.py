import os
import csv

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))
PATH_CSV_OUTPUT_LIST_FILE = os.path.join(PATH_CURRENT_FILE, '..', 'file_list.csv')


def list_file():
    PATH_CODES_JAVASCRIPT = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'javascript', 'src')
    PATH_CODES_GO = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'go')
    PATH_CODES_PERL = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'perl')
    PATH_CODES_PHP = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'php')
    PATH_CODES_PYTHON = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'python')
    PATH_CODES_JULIA = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'julia')
    PATH_CODES_LUA = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'lua')
    PATH_CODES_RUBY = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'ruby')
    PATH_CODES_R = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'r')
    PATH_CODES_KOTLIN = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'kotlin')
    PATH_CODES_SWIFT = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'swift')

    FILE_CODES_JAVASCRIPT = [filename for filename in os.listdir(PATH_CODES_JAVASCRIPT)]
    FILE_CODES_GO = [filename + ".go" for filename in os.listdir(PATH_CODES_GO)]
    FILE_CODES_PHP = [filename for filename in os.listdir(PATH_CODES_PHP)]
    FILE_CODES_PERL = [filename for filename in os.listdir(PATH_CODES_PERL)]
    FILE_CODES_PYTHON = [filename for filename in os.listdir(PATH_CODES_PYTHON)]
    FILE_CODES_JULIA = [filename for filename in os.listdir(PATH_CODES_JULIA)]
    FILE_CODES_LUA = [filename for filename in os.listdir(PATH_CODES_LUA)]
    FILE_CODES_RUBY = [filename for filename in os.listdir(PATH_CODES_RUBY)]
    FILE_CODES_R = [filename for filename in os.listdir(PATH_CODES_R)]
    FILE_CODES_KOTLIN = [filename for filename in os.listdir(PATH_CODES_KOTLIN)]
    FILE_CODES_SWIFT = [filename for filename in os.listdir(PATH_CODES_SWIFT)]

    FILE_CODES_JAVASCRIPT = ["JAVASCRIPT", *FILE_CODES_JAVASCRIPT]
    FILE_CODES_GO = ["GO", *FILE_CODES_GO]
    FILE_CODES_PHP = ["PHP", *FILE_CODES_PHP]
    FILE_CODES_PERL = ["PERL", *FILE_CODES_PERL]
    FILE_CODES_PYTHON = ["PYTHON", *FILE_CODES_PYTHON]
    FILE_CODES_JULIA = ["JULIA", *FILE_CODES_JULIA]
    FILE_CODES_LUA = ["LUA", *FILE_CODES_LUA]
    FILE_CODES_RUBY = ["RUBY", *FILE_CODES_RUBY]
    FILE_CODES_R = ["R", *FILE_CODES_R]
    FILE_CODES_KOTLIN = ["KOTLIN", *FILE_CODES_KOTLIN]
    FILE_CODES_SWIFT = ["SWIFT", *FILE_CODES_SWIFT]

    FILE_CODES = [
        FILE_CODES_JAVASCRIPT,
        FILE_CODES_GO,
        FILE_CODES_PHP,
        FILE_CODES_PERL,
        FILE_CODES_PYTHON,
        FILE_CODES_JULIA,
        FILE_CODES_LUA,
        FILE_CODES_RUBY,
        FILE_CODES_R,
        FILE_CODES_KOTLIN,
        FILE_CODES_SWIFT
    ]

    if os.path.isfile(PATH_CSV_OUTPUT_LIST_FILE):
        os.remove(PATH_CSV_OUTPUT_LIST_FILE)

    for FILE_CODE in FILE_CODES:
        with open(PATH_CSV_OUTPUT_LIST_FILE, 'a', newline='') as csv_file:
            file_codes_list_csv_writer = csv.writer(csv_file, delimiter=";")
            file_codes_list_csv_writer.writerow(FILE_CODE)


if __name__ == "__main__":
    list_file()
