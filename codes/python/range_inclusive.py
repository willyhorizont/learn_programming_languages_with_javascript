range_inclusive_v1 = lambda start_number, stop_number: list(range(start_number, (stop_number + 1), 1)) if (start_number < stop_number) else list(range(start_number, (stop_number - 1), -1)) if (start_number > stop_number) else [(start_number or stop_number)]

range_inclusive_v2 = lambda start_number, stop_number: (lambda step_number: (list(range(start_number, (stop_number + step_number), step_number))))(1 if (start_number < stop_number) else -1)

range_inclusive_v3 = lambda start_number, stop_number: [(start_number or stop_number)] if (start_number == stop_number) else (lambda step_number: (list(range(start_number, (stop_number + step_number), step_number))))(1 if (start_number < stop_number) else -1)

range_inclusive_v4 = lambda start_number, stop_number: [(start_number + i) if (start_number < stop_number) else (start_number - i) if (start_number > stop_number) else (start_number or stop_number) for i in range(abs(stop_number - start_number) + 1)]

def main():
    print(f"range_inclusive_v1(1, 10): {range_inclusive_v1(1, 10)}")  # range_inclusive_v1(1, 10): [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    print(f"range_inclusive_v1(10, 1): {range_inclusive_v1(10, 1)}")  # range_inclusive_v1(10, 1): [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    print(f"range_inclusive_v1(10, 10): {range_inclusive_v1(10, 10)}")  # range_inclusive_v1(10, 10): [10]
    print(f"range_inclusive_v2(1, 10): {range_inclusive_v2(1, 10)}")  # range_inclusive_v2(1, 10): [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    print(f"range_inclusive_v2(10, 1): {range_inclusive_v2(10, 1)}")  # range_inclusive_v2(10, 1): [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    print(f"range_inclusive_v2(10, 10): {range_inclusive_v2(10, 10)}")  # range_inclusive_v2(10, 10): [10]
    print(f"range_inclusive_v3(1, 10): {range_inclusive_v3(1, 10)}")  # range_inclusive_v3(1, 10): [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    print(f"range_inclusive_v3(10, 1): {range_inclusive_v3(10, 1)}")  # range_inclusive_v3(10, 1): [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    print(f"range_inclusive_v3(10, 10): {range_inclusive_v3(10, 10)}")  # range_inclusive_v3(10, 10): [10]
    print(f"range_inclusive_v4(1, 10): {range_inclusive_v4(1, 10)}")  # range_inclusive_v4(1, 10): [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    print(f"range_inclusive_v4(10, 1): {range_inclusive_v4(10, 1)}")  # range_inclusive_v4(10, 1): [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    print(f"range_inclusive_v4(10, 10): {range_inclusive_v4(10, 10)}")  # range_inclusive_v4(10, 10): [10]


if __name__ == "__main__":
    main()
