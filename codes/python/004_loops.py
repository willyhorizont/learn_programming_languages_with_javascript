# generate_number_sequence_v2
generate_number_sequence = lambda start_number, stop_number: list(range(start_number, (stop_number + 1), 1)) if (stop_number > start_number) else list(range(start_number, (stop_number - 1), -1)) if (start_number > stop_number) else [0]


# while loop


@lambda _: _()
def _():
    i = 1
    while (True):
        if (i == 2):
            if (i >= 5):
                break
            i += 1
            continue
        print(f"while loop v1, i is {i}")
        if (i >= 5):
            break
        i += 1


@lambda _: _()
def _():
    i = 1
    while (i <= 5):
        if (i == 2):
            i += 1
            continue
        print(f"while loop v2, i is {i}")
        i += 1


# for loop and also forEach loop


@lambda _: _()
def _():
    for i in range(1, (10 + 1), 1):  # (start, stop, step)
        if (i > 5):
            break
        if (i == 2):
            continue
        print(f"for loop ascending, i is {i}")


@lambda _: _()
def _():
    for i in range(10, (1 - 1), -1):  # (start, stop, step)
        if (i <= 5):
            break
        if (i == 9):
            continue
        print(f"for loop descending, i is {i}")


@lambda _: _()
def _():
    for i in generate_number_sequence(1, 10):
        if (i > 5):
            break
        if (i == 2):
            continue
        print(f"for loop ascending, i is {i}")


@lambda _: _()
def _():
    for i in generate_number_sequence(10, 1):
        if (i <= 5):
            break
        if (i == 9):
            continue
        print(f"for loop descending, i is {i}")

