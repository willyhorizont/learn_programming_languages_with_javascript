'''
Relational Operators / Comparison Operators:
equal to (==)
not equal to (!=)
identical to (is) *compares if it is the exact same object in memory.
not identical to (not) *compares if it is the exact same object in memory.
greater than (>)
less than (<)
greater then or equal to (>=)
less then or equal to (<=)

Logical Operators:
Logical AND (and)
Logical OR (or)
Logical NOT (not)
'''

CORRECT_ANSWER = 100

print("\n# equal to (==)\n")

my_answer = 100.0
print("my_answer: ", my_answer)
print("CORRECT_ANSWER: ", CORRECT_ANSWER)
print("(my_answer == CORRECT_ANSWER): ")
print("Your answer is correct") if (my_answer == CORRECT_ANSWER) else print("Your answer is wrong")

print("\n# not equal to (!=)\n")

my_answer = 25.0
print("my_answer: ", my_answer)
print("CORRECT_ANSWER: ", CORRECT_ANSWER)
print("(my_answer != CORRECT_ANSWER): ")
print("Your answer is correct") if (my_answer != CORRECT_ANSWER) else print("Your answer is wrong")

print("\n# identical to (is)\n")

my_answer = 100.0
print("my_answer: ", my_answer)
print("CORRECT_ANSWER: ", CORRECT_ANSWER)
print("(my_answer is CORRECT_ANSWER): ")
print("Your answer is correct") if (my_answer is CORRECT_ANSWER) else print("Your answer is wrong")

print("\n# not identical to (not)\n")

my_answer = 25.0
print("my_answer: ", my_answer)
print("CORRECT_ANSWER: ", CORRECT_ANSWER)
print("(my_answer is not CORRECT_ANSWER): ")
print("Your answer is correct") if (my_answer is not CORRECT_ANSWER) else print("Your answer is wrong")

print("\n# greater than (>)\n")

my_age = 70
print("my_age: ", my_age)
print("(my_age > 50): ")
if (my_age > 50):
    print("You are old")

print("\n# less than (<)\n")

my_age = 16
print("my_age: ", my_age)
print("(my_age < 20): ")
if (my_age < 20):
    print("You are young")

print("\n# greater then or equal to (>=)\n")

my_age = 73
print("my_age: ", my_age)
print("(my_age >= 65): ")
if (my_age >= 65):
    print("You are allowed to retire")

print("\n# less then or equal to (<=)\n")

my_age = 14
print("my_age: ", my_age)
print("(my_age <= 16): ")
if (my_age <= 16):
    print("You are not allowed to drive")

print("\n# Logical AND (and)\n")

my_age = 17
print("my_age: ", my_age)
has_driving_license = False
print("has_driving_license: ", has_driving_license)
print("((my_age >= 17) and (has_driving_license == True)): ")
if ((my_age >= 17) and (has_driving_license == True)):
    print("You are allowed to drive")
else:
    print("You are not allowed to drive")

my_age = 17
print("my_age: ", my_age)
has_driving_license = True
print("has_driving_license: ", has_driving_license)
print("((my_age >= 17) and (has_driving_license == True)): ")
if ((my_age >= 17) and (has_driving_license == True)):
    print("You are allowed to drive")
else:
    print("You are not allowed to drive")

print("\n# Logical OR (or)\n")

my_age = 2
print("my_age: ", my_age)
print("((my_age <= 3) or (my_age >= 65)): ")
if ((my_age <= 3) or (my_age >= 65)):
    print("You should stay home")

my_age = 89
print("my_age: ", my_age)
print("((my_age <= 3) or (my_age >= 65)): ")
if ((my_age <= 3) or (my_age >= 65)):
    print("You should stay home")

print("\n# Logical NOT (not)\n")

can_drive = False
print("can_drive:", can_drive)
print("not can_drive:", not can_drive)

can_drive = True
print("can_drive:", can_drive)
print("not can_drive:", not can_drive)
