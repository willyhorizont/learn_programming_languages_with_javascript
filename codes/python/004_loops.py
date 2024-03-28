# while loop

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

i = 1
while (i <= 5):
    if (i == 2):
        i += 1
        continue
    print(f"while loop v2, i is {i}")
    i += 1

# for loop and also foreach loop

for i in range(1, (10 + 1), 1):  # (start, stop, step)
    if (i > 5):
        break
    if (i == 2):
        continue
    print(f"for loop ascending, i is {i}")

for i in range(10, (1 - 1), -1):  # (start, stop, step)
    if (i <= 5):
        break
    if (i == 9):
        continue
    print(f"for loop descending, i is {i}")
