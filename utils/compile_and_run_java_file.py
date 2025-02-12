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

    java_comment_1 = "// This file is generated using \"~/utils/compile_and_run_java_file.py\""
    java_comment_2 = "// This file is generated because Java requires a wrapper object with the same name as the file in order to make the program compiled"
    java_code_print_message_1 = f"System.out.println(\"copying \\\"~/codes/java/{file_name_java}\\\"'s content to \\\"~/Program.java\\\"...\");"
    java_code_print_message_2 = "System.out.println(\"running code from \\\"~/Program.java\\\"...\\n\");"

    with open(path_file_java, "r") as source_code, open(path_file_program, "w") as program_file:
        java_code = source_code.read()
        java_code = re.sub(r"\n$", "", java_code)
        java_code = java_code.replace("public static void main(String[] args) {", f"""public static void main(String[] args) {{
        {java_code_print_message_1}
        {java_code_print_message_2}
""")

        program_file.write(f"""{java_comment_1}
{java_comment_2}

{java_code}
""")

    subprocess.run(["cd", "../", "&&", "javac", "Program.java", "&&", "java", "Program", "&&", "del", "*.class"], check=True, text=True, shell=True)


if __name__ == "__main__":
    compile_and_run_java_file()
