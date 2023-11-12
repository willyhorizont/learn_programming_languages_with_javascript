import os
import csv

PATH_CURRENT_FILE = os.path.dirname(os.path.abspath(__file__))


def delete_compiled():
    PATH_CODES_D = os.path.join(PATH_CURRENT_FILE, '..', 'codes_trial', 'd')

    for filename in os.listdir(PATH_CODES_D):
        if ".obj" in filename or ".exe" in filename:
            os.remove(os.path.join(PATH_CODES_D, filename))


if __name__ == "__main__":
    delete_compiled()
