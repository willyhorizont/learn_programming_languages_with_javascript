import os
import csv

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))


def delete_compiled():
    PATH_CODES_KOTLIN = os.path.join(PATH_CURRENT_FILE, '..', 'codes', 'kotlin')

    for filename in os.listdir(PATH_CODES_KOTLIN):
        if ".jar" in filename:
            os.remove(os.path.join(PATH_CODES_KOTLIN, filename))


if __name__ == "__main__":
    delete_compiled()
