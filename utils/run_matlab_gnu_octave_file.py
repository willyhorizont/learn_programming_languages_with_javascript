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

    indentation = " " * 4

    matlab_message_1 = "% This file is generated using \"~/utils/run_matlab_gnu_octave_file.py\""
    matlab_message_2 = "% This file is generated because MATLAB requires a wrapper function with the same name as the file in order to make the program running"

    gnu_octave_message_1 = "% This file is generated using \"~/utils/run_matlab_gnu_octave_file.py\""
    gnu_octave_message_2 = "% This file is generated because Octave requires a wrapper function with the same name as the file in order to make the program running"

    matlab_gnu_octave_function_head = "function temp()"
    matlab_gnu_octave_function_tail = "end"

    matlab_function_body_code_print_message_2 = "disp(strcat(\"running code from \"\"~/temp.m\"\"...\", sprintf(\"\\n\")));"
    gnu_octave_function_body_code_print_message_2 = "disp(cstrcat(\"running code from \"\"~/temp.m\"\"...\", sprintf(\"\\n\")));"

    if ("matlab" in path_file_matlab_or_gnu_octave):
        with open(path_file_matlab_or_gnu_octave, "r") as source_code, open(path_file_temp, "w") as temp_file:
            matlab_code = source_code.read()
            matlab_code = re.sub(r"\n$", "", matlab_code)
            matlab_code = matlab_code.replace("\n", f"\n{indentation}")

            file_name_matlab = path_file_matlab_or_gnu_octave.split("codes\\matlab\\")[1]
            matlab_comment_1 = f"% The body of this function is taken from \"~/codes/matlab/{file_name_matlab}\"'s content"
            matlab_function_body_code_print_message_1 = f"disp(\"copying \"\"~/codes/matlab/{file_name_matlab}\"\"'s content to \"\"~/temp.m\"\"'s function body...\");"

            temp_file.write(f"""{matlab_message_1}
{matlab_message_2}

{matlab_gnu_octave_function_head}
{indentation}{matlab_function_body_code_print_message_1}
{indentation}{matlab_function_body_code_print_message_2}
{indentation}{matlab_comment_1}

{indentation}{matlab_code}
{matlab_gnu_octave_function_tail}
""")

        subprocess.run(["cd", "../", "&&", "matlab", "-batch", "\"run('temp.m');\""], check=True, text=True, shell=True)

    if ("gnu_octave" in path_file_matlab_or_gnu_octave):
        with open(path_file_matlab_or_gnu_octave, "r") as source_code, open(path_file_temp, "w") as temp_file:
            gnu_octave_code = source_code.read()
            gnu_octave_code = re.sub(r"\n$", "", gnu_octave_code)
            gnu_octave_code = gnu_octave_code.replace("\n", f"\n{indentation}")

            file_name_gnu_octave = path_file_matlab_or_gnu_octave.split("codes\\gnu_octave\\")[1]
            gnu_octave_comment_1 = f"% The body of this function is taken from \"~/codes/gnu_octave/{file_name_gnu_octave}\"'s content"
            gnu_octave_code_function_body_print_message_1 = f"disp(\"copying \"\"~/codes/gnu_octave/{file_name_gnu_octave}\"\"'s content to \"\"~/temp.m\"\"'s function body...\");"

            temp_file.write(f"""{gnu_octave_message_1}
{gnu_octave_message_2}

{matlab_gnu_octave_function_head}
{indentation}{gnu_octave_code_function_body_print_message_1}
{indentation}{gnu_octave_function_body_code_print_message_2}
{indentation}{gnu_octave_comment_1}

{indentation}{gnu_octave_code}
{matlab_gnu_octave_function_tail}
""")

        subprocess.run(["cd", "../", "&&", "octave-cli", "temp.m"], check=True, text=True, shell=True)


if __name__ == "__main__":
    run_matlab_gnu_octave_file()

