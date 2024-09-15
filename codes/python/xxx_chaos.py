array_item_index = 0
for array_item in ["a", "b", "c"]:
    print(array_item)
    print(array_item_index)
    array_item_index += 1

print(f"range(1, 10, 1): {list(range(1, 10, 1))}")  # range(1, 10, 1): [1, 2, 3, 4, 5, 6, 7, 8, 9]
print(f"range(1, 10): {list(range(1, 10))}")  # range(1, 10): [1, 2, 3, 4, 5, 6, 7, 8, 9]
print(f"range(10): {list(range(10))}")  # range(10): [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(f"range(1, 10, 2): {list(range(1, 10, 2))}")  # range(1, 10, 2): [1, 3, 5, 7, 9]
print(f"range(10, 1, -1): {list(range(10, 1, -1))}")  # range(10, 1, -1): [10, 9, 8, 7, 6, 5, 4, 3, 2]
print(f"range(10, 1): {list(range(10, 1))}")  # range(10, 1): []
print(f"range(10, 1, -2): {list(range(10, 1, -2))}")  # range(10, 1, -2): [10, 8, 6, 4, 2]