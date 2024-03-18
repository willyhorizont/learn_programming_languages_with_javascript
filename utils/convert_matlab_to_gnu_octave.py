import os


def convert_matlab_to_gnu_octave():
    path_directory_matlab = "../codes/matlab"
    path_directory_gnu_octave = "../codes/gnu_octave"

    for file_or_directory_in_path_directory_matlab in os.listdir(path_directory_matlab):
        path_file_matlab = f"{path_directory_matlab}/{file_or_directory_in_path_directory_matlab}"
        path_file_gnu_octave = f"{path_directory_gnu_octave}/{file_or_directory_in_path_directory_matlab}"
        if os.path.isfile(path_file_matlab):
            with open(path_file_matlab, "r") as source_code, open(path_file_gnu_octave, "w+") as gnu_octave_code:
                matlab_code = source_code.read()
                if file_or_directory_in_path_directory_matlab != "000_notes.m.txt":
                    matlab_code = matlab_code.replace("isstring", "ischar")
                    matlab_code = matlab_code.replace("strcat", "cstrcat")
                    matlab_code = matlab_code.replace("Matlab", "GNU Octave")
                gnu_octave_code.write(matlab_code)


if __name__ == "__main__":
    convert_matlab_to_gnu_octave()
