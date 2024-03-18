import sys
import re
import subprocess


def run_matlab_gnu_octave_file():
    if (len(sys.argv) == 1):
        return

    path_file_temp = "../temp.m"
    path_file_matlab_or_gnu_octave = sys.argv[1]
    path_file_matlab_or_gnu_octave = path_file_matlab_or_gnu_octave.strip()
    path_file_matlab_or_gnu_octave = path_file_matlab_or_gnu_octave.replace("\"", "\\")

    if ("matlab" in path_file_matlab_or_gnu_octave):
        with open(path_file_matlab_or_gnu_octave, "r") as source_code, open(path_file_temp, "w") as temp_file:
            matlab_code = source_code.read()
            matlab_code = re.sub(r"\n$", "", matlab_code)
            matlab_code = matlab_code.replace("\n", "\n    ")
            file_name_matlab = path_file_matlab_or_gnu_octave.split("codes\\matlab\\")[1]
            temp_file.write(f"% This file is generated using \"../utils/run_matlab_gnu_octave_file.py\"\n% This file is generated because MATLAB requires a wrapper function with the same name as the file in order to make the program running\nfunction temp()\n    disp(\"copying code to \"\"../../temp.m\"\"'s function body...\");\n    disp(strcat(\"running \"\"../../temp.m\"\"...\", sprintf(\"\\n\")));\n    % The body of this function is taken from \"../codes/matlab/{file_name_matlab}\"'s content\n\n    {matlab_code}\nend\n")

        subprocess.run(["cd", "../", "&&", "matlab", "-batch", "\"run('temp.m');\""], check=True, text=True, shell=True)

    if ("gnu_octave" in path_file_matlab_or_gnu_octave):
        with open(path_file_matlab_or_gnu_octave, "r") as source_code, open(path_file_temp, "w") as temp_file:
            gnu_octave_code = source_code.read()
            gnu_octave_code = re.sub(r"\n$", "", gnu_octave_code)
            gnu_octave_code = gnu_octave_code.replace("\n", "\n    ")
            file_name_gnu_octave = path_file_matlab_or_gnu_octave.split("codes\\gnu_octave\\")[1]
            temp_file.write(f"% This file is generated using \"../utils/run_matlab_gnu_octave_file.py\"\n% This file is generated because Octave requires a wrapper function with the same name as the file in order to make the program running\nfunction temp()\n    disp(\"copying code to \"\"../../temp.m\"\"'s function body...\");\n    disp(cstrcat(\"running \"\"../../temp.m\"\"...\", sprintf(\"\\n\")));\n    % The body of this function is taken from \"../codes/gnu_octave/{file_name_gnu_octave}\"'s content\n\n    {gnu_octave_code}\nend\n")

        subprocess.run(["cd", "../", "&&", "octave-cli", "temp.m"], check=True, text=True, shell=True)


if __name__ == "__main__":
    run_matlab_gnu_octave_file()

