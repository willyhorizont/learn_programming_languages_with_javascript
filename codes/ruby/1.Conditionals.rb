=begin
    Relational Operators / Comparison Operators:
    equal to (==)
    not equal to (!=)
    greater than (>)
    less than (<)
    greater than or equal to (>=)
    less than or equal to (<=)

    Logical Operators:
    Logical AND [&&, and]
    Logical OR [||, or]
    Logical NOT [!, not(x)]
=end

print("\n# basic conditional control flow\n")

my_age = 10
print("my_age: ", my_age, "\n")
if (my_age > 24)
    print("you are old\n")
elsif (my_age > 17)
    print("you are young\n")
else
    print("you are under age\n")
end

my_age = 10
print("my_age: ", my_age, "\n")

if (my_age <= 24)
    print("you are old\n")
else
    print("you are young\n")
end

print("\n# equal to (==)\n")

correct_answer = 100
my_answer = 100
print("my_answer: ", my_answer, "\n")
print("correct_answer: ", correct_answer, "\n")
print("(my_answer == correct_answer): \n")
if (my_answer == correct_answer)
  print("Your answer is correct\n")
else
  print("Your answer is wrong\n")
end

print("\n# not equal to (!=)\n")

correct_answer = 100
my_answer = 25
print("my_answer: ", my_answer, "\n")
print("correct_answer: ", correct_answer, "\n")
print("(my_answer != correct_answer): \n")
if (my_answer != correct_answer)
    print("Your answer is wrong\n")
else
    print("Your answer is correct\n")
end

print("\n# greater than (>)\n")

my_age = 70
print("my_age: ", my_age, "\n")
print("(my_age > 50): \n")
print("You are old\n") if (my_age > 50)

print("\n# less than (<)\n")

my_age = 16
print("my_age: ", my_age, "\n")
print("(my_age < 20): \n")
print("You are young\n") if (my_age < 20)

print("\n# greater than or equal to (>=)\n")

my_age = 73
print("my_age: ", my_age, "\n")
print("(my_age >= 65): \n")
print("You are allowed to retire\n") if (my_age >= 65)

print("\n# less than or equal to (<=)\n")

my_age = 14
print("my_age: ", my_age, "\n")
print("(my_age <= 16): \n")
print("You are not allowed to drive\n") if (my_age <= 16)

print("\n# Logical AND [&&, and]\n")

my_age = 17
print("my_age: ", my_age, "\n")
has_driving_license = false
print("has_driving_license: ", has_driving_license, "\n")
print("((my_age >= 17) && (has_driving_license == true)): \n")
if ((my_age >= 17) && (has_driving_license == true)) then print("You are allowed to drive\n") else print("You are not allowed to drive\n") end

my_age = 17
print("my_age: ", my_age, "\n")
has_driving_license = true
print("has_driving_license: ", has_driving_license, "\n")
print("((my_age >= 17) && (has_driving_license == true)): \n")
if ((my_age >= 17) && (has_driving_license == true)) then print("You are allowed to drive\n") else print("You are not allowed to drive\n") end

my_age = 17
print("my_age: ", my_age, "\n")
has_driving_license = false
print("has_driving_license: ", has_driving_license, "\n")
print("((my_age >= 17) and (has_driving_license == true)): \n")
if ((my_age >= 17) and (has_driving_license == true)) then print("You are allowed to drive\n") else print("You are not allowed to drive\n") end

my_age = 17
print("my_age: ", my_age, "\n")
has_driving_license = true
print("has_driving_license: ", has_driving_license, "\n")
print("((my_age >= 17) and (has_driving_license == true)): \n")
if ((my_age >= 17) and (has_driving_license == true)) then print("You are allowed to drive\n") else print("You are not allowed to drive\n") end

print("\n# Logical OR [||, or]\n")

my_age = 2
print("my_age: ", my_age, "\n")
print("((my_age <= 3) || (my_age >= 65)): \n")
print("You should stay home\n") if ((my_age <= 3) || (my_age >= 65))

my_age = 89
print("my_age: ", my_age, "\n")
print("((my_age <= 3) || (my_age >= 65)): \n")
print("You should stay home\n") if ((my_age <= 3) || (my_age >= 65))

my_age = 2
print("my_age: ", my_age, "\n")
print("((my_age <= 3) or (my_age >= 65)): \n")
print("You should stay home\n") if ((my_age <= 3) or (my_age >= 65))

my_age = 89
print("my_age: ", my_age, "\n")
print("((my_age <= 3) or (my_age >= 65)): \n")
print("You should stay home\n") if ((my_age <= 3) or (my_age >= 65))

print("\n# Logical NOT [!, not]\n")

can_drive = false
print("can_drive: ", can_drive, "\n")
print("!can_drive: ", !can_drive, "\n")

can_drive = true
print("can_drive: ", can_drive, "\n")
print("!can_drive: ", !can_drive, "\n")

can_drive = false
print("can_drive: ", can_drive, "\n")
print("not can_drive: ", not(can_drive), "\n")

can_drive = true
print("can_drive: ", can_drive, "\n")
print("not can_drive: ", not(can_drive), "\n")
