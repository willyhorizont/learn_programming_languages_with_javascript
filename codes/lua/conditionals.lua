--[[
    Relational Operators / Comparison Operators:
    equal to (==)
    not equal to (~=)
    greater than (>)
    less than (<)
    greater then or equal to (>=)
    less then or equal to (<=)

    Logical Operators:
    Logical AND (and)
    Logical OR (or)
    Logical NOT (not)
]]

print("\n-- basic conditional control flow\n")

my_age = 10
print("my_age: " .. my_age)
if (my_age > 24) then
    print("you are old")
elseif (my_age > 17) then
    print("you are young")
else
    print("you are under age")
end

print("\n-- equal to (==)\n")

correct_answer = 100
my_answer = 100
print("my_answer: " .. my_answer)
print("correct_answer: " .. tostring(correct_answer))
print("(my_answer == correct_answer): ")
if (my_answer == correct_answer) then
    print("Your answer is correct")
else
    print("Your answer is wrong")
end

print("\n-- not equal to (~=)\n")

correct_answer = 100
my_answer = 25
print("my_answer: " .. my_answer)
print("correct_answer: " .. tostring(correct_answer))
print("(my_answer ~= correct_answer): ")
if (my_answer ~= correct_answer) then
    print("Your answer is wrong")
else
    print("Your answer is correct")
end

print("\n-- greater than (>)\n")

my_age = 70
print("my_age: " .. my_age)
print("(my_age > 50): ")
if (my_age > 50) then print("You are old") end

print("\n-- less than (<)\n")

my_age = 16
print("my_age: " .. my_age)
print("(my_age < 20): ")
if (my_age < 20) then print("You are young") end

print("\n-- greater then or equal to (>=)\n")

my_age = 73
print("my_age: " .. my_age)
print("(my_age >= 65): ")
if (my_age >= 65) then print("You are allowed to retire") end

print("\n-- less then or equal to (<=)\n")

my_age = 14
print("my_age: " .. my_age)
print("(my_age <= 16): ")
if (my_age <= 16) then print("You are not allowed to drive") end

print("\n-- Logical AND (and)\n")

my_age = 17
print("my_age: " .. my_age)
has_driving_license = false
print("has_driving_license: " .. tostring(has_driving_license))
print("((my_age >= 17) and (has_driving_license == true)): ")
if ((my_age >= 17) and (has_driving_license == true)) then print("You are allowed to drive") else print("You are not allowed to drive") end

my_age = 17
print("my_age: " .. my_age)
has_driving_license = true
print("has_driving_license: " .. tostring(has_driving_license))
print("((my_age >= 17) and (has_driving_license == true)): ")
if ((my_age >= 17) and (has_driving_license == true)) then print("You are allowed to drive") else print("You are not allowed to drive") end

print("\n-- Logical OR (or)\n")

my_age = 2
print("my_age: " .. my_age)
print("((my_age <= 3) or (my_age >= 65)): ")
if ((my_age <= 3) or (my_age >= 65)) then print("You should stay home") end

my_age = 89
print("my_age: " .. my_age)
print("((my_age <= 3) or (my_age >= 65)): ")
if ((my_age <= 3) or (my_age >= 65)) then print("You should stay home") end

print("\n-- Logical NOT (not)\n")

can_drive = false
print("can_drive:" .. tostring(can_drive))
print("not can_drive:" .. tostring(not can_drive))

can_drive = true
print("can_drive:" .. tostring(can_drive))
print("not can_drive:" .. tostring(not can_drive))
