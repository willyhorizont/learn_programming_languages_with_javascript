import sys
import re
import subprocess


def compile_and_run_java_file():
    if (len(sys.argv) == 1):
        return

    path_file_program = "../Program.java"
    path_file_java = sys.argv[1]
    path_file_java = path_file_java.strip()
    path_file_java = path_file_java.replace("\"", "\\")
    file_name_java = path_file_java.split("codes\\java\\")[1]

    indentation = (" " * 4)
    java_object_head = """import java.util.ArrayList;
import java.util.HashMap;
import java.util.AbstractMap;

@SuppressWarnings("unchecked")
public class Program {"""
    java_object_tail = "}"
    java_main_method_head = "public static void main(String[] args) {"
    java_main_method_tail = "}"
    # java_main_method_try_catch_head = "try {"
    # java_main_method_try_catch_tail = """} catch (Throwable throwable) {
    #         System.out.println("Caught a Throwable: " + throwable);
    #     }"""
    java_main_method_body_code_print_message_1 = f"System.out.println(\"copying \\\"~/codes/java/{file_name_java}\\\"'s content to \\\"~/Program.java\\\"'s main method body inside try block...\");"
    java_main_method_body_code_print_message_2 = "System.out.println(\"running code from \\\"~/Program.java\\\"...\\n\");"
    java_main_method_body_comment_1 = f"// The body of this method is taken from \"~/codes/java/{file_name_java}\"'s content"
    java_comment_1 = "// This file is generated using \"~/utils/compile_and_run_java_file.py\""
    java_comment_2 = "// This file is generated because Java requires a wrapper object with the same name as the file in order to make the program compiled"

    with open(path_file_java, "r") as source_code, open(path_file_program, "w") as program_file:
        java_code = source_code.read()
        java_code = re.sub(r"\n$", "", java_code)
        java_code = java_code.replace("\n", f"\n{indentation}{indentation}")

        program_file.write(f"""{java_comment_1}
{java_comment_2}

{java_object_head}
{indentation}{java_main_method_head}
{indentation}{indentation}{java_main_method_body_code_print_message_1}
{indentation}{indentation}{java_main_method_body_code_print_message_2}
{indentation}{indentation}{java_main_method_body_comment_1}

{indentation}{indentation}{java_code}
{indentation}{java_main_method_tail}
{java_object_tail}
""")

    subprocess.run(["cd", "../", "&&", "javac", "Program.java", "&&", "java", "Program", "&&", "del", "*.class"], check=True, text=True, shell=True)


if __name__ == "__main__":
    compile_and_run_java_file()
