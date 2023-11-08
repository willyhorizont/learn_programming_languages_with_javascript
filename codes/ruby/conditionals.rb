=begin
Relational Operators / Comparison Operators:
equal to (==)
not equal to (!=)
greater than (>)
less than (<)
greater then or equal to (>=)
less then or equal to (<=)

Logical Operators:
Logical AND [&&, and]
Logical OR [||, or]
Logical NOT [!, not(x)]
=end

CORRECT_ANSWER = 100

print("\n# equal to (==)\n")

my_answer = 100.0
print("my_answer: ", my_answer, "\n")
print("CORRECT_ANSWER: ", CORRECT_ANSWER, "\n")
print("(my_answer == CORRECT_ANSWER): ")
if (my_answer == CORRECT_ANSWER)
  print("Your answer is correct")
else
  print("Your answer is wrong")
end

print("\n# not equal to (!=)\n")

my_answer = 25.0
print("my_answer: ", my_answer, "\n")
print("CORRECT_ANSWER: ", CORRECT_ANSWER, "\n")
print("(my_answer != CORRECT_ANSWER): ")
if (my_answer != CORRECT_ANSWER)
  print("Your answer is correct")
else
  print("Your answer is wrong")
end

print("\n# greater than (>)\n")

my_age = 70
print("my_age: ", my_age, "\n")
print("(my_age > 50): ")
print("You are old") if (my_age > 50)

print("\n# less than (<)\n")

my_age = 16
print("my_age: ", my_age, "\n")
print("(my_age < 20): ")
print("You are young") if (my_age < 20)

print("\n# greater then or equal to (>=)\n")

my_age = 73
print("my_age: ", my_age, "\n")
print("(my_age >= 65): ")
print("You are allowed to retire") if (my_age >= 65)

print("\n# less then or equal to (<=)\n")

my_age = 14
print("my_age: ", my_age, "\n")
print("(my_age <= 16): ")
print("You are not allowed to drive") if (my_age <= 16)

print("\n# Logical AND [&&, and]\n")

my_age = 17
print("my_age: ", my_age, "\n")
has_driving_license = false
print("has_driving_license: ", has_driving_license, "\n")
print("((my_age >= 17) && (has_driving_license == true)): ")
if ((my_age >= 17) && (has_driving_license == true)) then print("You are allowed to drive") else print("You are not allowed to drive") end

my_age = 17
print("my_age: ", my_age, "\n")
has_driving_license = true
print("has_driving_license: ", has_driving_license, "\n")
print("((my_age >= 17) && (has_driving_license == true)): ")
if ((my_age >= 17) && (has_driving_license == true)) then print("You are allowed to drive") else print("You are not allowed to drive") end

my_age = 17
print("my_age: ", my_age, "\n")
has_driving_license = false
print("has_driving_license: ", has_driving_license, "\n")
print("((my_age >= 17) and (has_driving_license == true)): ")
if ((my_age >= 17) and (has_driving_license == true)) then print("You are allowed to drive") else print("You are not allowed to drive") end

my_age = 17
print("my_age: ", my_age, "\n")
has_driving_license = true
print("has_driving_license: ", has_driving_license, "\n")
print("((my_age >= 17) and (has_driving_license == true)): ")
if ((my_age >= 17) and (has_driving_license == true)) then print("You are allowed to drive") else print("You are not allowed to drive") end

print("\n# Logical OR [||, or]\n")

my_age = 2
print("my_age: ", my_age, "\n")
print("((my_age <= 3) || (my_age >= 65)): ")
print("You should stay home") if ((my_age <= 3) || (my_age >= 65))

my_age = 89
print("my_age: ", my_age, "\n")
print("((my_age <= 3) || (my_age >= 65)): ")
print("You should stay home") if ((my_age <= 3) || (my_age >= 65))

my_age = 2
print("my_age: ", my_age, "\n")
print("((my_age <= 3) or (my_age >= 65)): ")
print("You should stay home") if ((my_age <= 3) or (my_age >= 65))

my_age = 89
print("my_age: ", my_age, "\n")
print("((my_age <= 3) or (my_age >= 65)): ")
print("You should stay home") if ((my_age <= 3) or (my_age >= 65))

print("\n# Logical NOT [!, not]\n")

can_drive = false
print("can_drive:", can_drive, "\n")
print("!can_drive:", !can_drive, "\n")

can_drive = true
print("can_drive:", can_drive, "\n")
print("!can_drive:", !can_drive, "\n")

can_drive = false
print("can_drive:", can_drive, "\n")
print("not can_drive:", not(can_drive), "\n")

can_drive = true
print("can_drive:", can_drive, "\n")
print("not can_drive:", not(can_drive), "\n")
