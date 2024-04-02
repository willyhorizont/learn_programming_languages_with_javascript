import sys
import re
import subprocess


def compile_and_run_scala_file():
    if (len(sys.argv) == 1):
        return

    path_file_program = "../Program.scala"
    path_file_scala = sys.argv[1]
    path_file_scala = path_file_scala.strip()
    path_file_scala = path_file_scala.replace("\"", "\\")
    file_name_scala = path_file_scala.split("codes\\scala\\")[1]

    indentation = " " * 4
    scala_object_head = "object Program {"
    scala_object_tail = "}"
    scala_main_method_head = "def main(args: Array[String]): Unit = {"
    scala_main_method_tail = "}"
    scala_main_method_body_code_print_message_1 = f"println(\"copying \\\"~/codes/scala/{file_name_scala}\\\"'s content to \\\"~/Program.scala\\\"'s main method body...\")"
    scala_main_method_body_code_print_message_2 = "println(\"running code from \\\"~/Program.scala\\\"...\\n\")"
    scala_main_method_body_comment_1 = f"// The body of this method is taken from \"~/codes/scala/{file_name_scala}\"'s content"
    scala_comment_1 = "// This file is generated using \"~/utils/compile_and_run_scala_file.py\""
    scala_comment_2 = "// This file is generated because Scala requires a wrapper object with the same name as the file in order to make the program compiled"

    with open(path_file_scala, "r") as source_code, open(path_file_program, "w") as program_file:
        scala_code = source_code.read()
        scala_code = re.sub(r"\n$", "", scala_code)
        scala_code = scala_code.replace("\n", f"\n{indentation}{indentation}")

        program_file.write(f"""{scala_comment_1}
{scala_comment_2}

{scala_object_head}
{indentation}{scala_main_method_head}
{indentation}{indentation}{scala_main_method_body_code_print_message_1}
{indentation}{indentation}{scala_main_method_body_code_print_message_2}
{indentation}{indentation}{scala_main_method_body_comment_1}

{indentation}{indentation}{scala_code}
{indentation}{scala_main_method_tail}
{scala_object_tail}
""")

    subprocess.run(["cd", "../", "&&", "scalac", "Program.scala", "&&", "scala", "Program", "&&", "del", "*.class"], check=True, text=True, shell=True)


if __name__ == "__main__":
    compile_and_run_scala_file()
