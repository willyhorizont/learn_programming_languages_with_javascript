def increment_name(increment_stop=10, prefix_name=""):
    if isinstance(increment_stop, int) == False:
        increment_stop = 10
    if isinstance(prefix_name, str) == False:
        prefix_name = ""
    for i in range(1, increment_stop + 1):
        print(f"{prefix_name}{i}")


if __name__ == "__main__":
    increment_name(13, "get_rectangle_area_v")
