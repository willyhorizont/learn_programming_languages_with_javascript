# while loop

i = 1
while True:
    if (i == 2):
        i += 1
        if (i > 5):
            break
        continue
    print(f"while loop v1, i is {i}")
    i += 1
    if (i > 5):
        break

i = 1
while (i <= 5):
    if (i == 2):
        i += 1
        continue
    print(f"while loop v2, i is {i}")
    i += 1

# for loop

for i in range(1, (5 + 1), 1): # (start, stop, step)
    if (i == 2):
        continue
    print(f"for loop ascending, i is {i}")

for i in range(5, (1 - 1), -1): # (start, stop, step)
    if (i == 2):
        continue
    print(f"for loop descending, i is {i}")
