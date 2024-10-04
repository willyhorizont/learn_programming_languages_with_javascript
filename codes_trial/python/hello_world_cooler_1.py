import time
import random


characters_string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ `~!@#$%^&*()_+-=[]\\{}|;':\",./<>?"
target_string = "Hello, World!"


def print_hello_world():
    result_string = ""
    for target_character in target_string:
        while (result_string != target_string):
            any_character = characters_string[random.randint(0, (len(characters_string) - 1))]
            print(f"{result_string}{any_character}")
            if (any_character == target_character):
                result_string = f"{result_string}{any_character}"
                break
            time.sleep(0.05)
    for _ in range(1, (10 + 1), 1):
        print(target_string)


if __name__ == "__main__":
    print_hello_world()
