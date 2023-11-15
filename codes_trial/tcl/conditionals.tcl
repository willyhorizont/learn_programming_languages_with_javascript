# Relational Operators / Comparison Operators:
# equal to [==, eq]
# not equal to [!=, ne]
# greater than [>, gt]
# less than [<, lt]
# greater than or equal to [>=, ge]
# less than or equal to [<=, le]

# Logical Operators:
# Logical AND (&&)
# Logical OR (||)
# Logical NOT (!)

puts "\n# basic conditional control flow\n"

set my_age 10
puts "\$my_age: $my_age"
if {$my_age > 24} {
    puts "you are old"
} elseif {$my_age > 17} {
    puts "you are young"
} else {
    puts "you are under age"
}

puts "\n# equal to \[==, eq\]\n"

set my_answer "100"
puts "\$my_answer: $my_answer"
set correct_answer 100
puts "\$correct_answer: $correct_answer"
puts "(\$my_answer == \$correct_answer):"
if {$my_answer == $correct_answer} {
    puts "your answer is correct"
} else {
    puts "your answer is wrong"
}

set my_answer "100"
puts "\$my_answer: $my_answer"
set correct_answer 100
puts "\$correct_answer: $correct_answer"
puts "(\$my_answer eq \$correct_answer):"
if {$my_answer eq $correct_answer} {
    puts "your answer is correct"
} else {
    puts "your answer is wrong"
}

set my_answer 100
puts "\$my_answer: $my_answer"
set correct_answer 100
puts "\$correct_answer: $correct_answer"
puts "(\$my_answer == \$correct_answer):"
if {$my_answer == $correct_answer} {
    puts "your answer is correct"
} else {
    puts "your answer is wrong"
}

set my_answer 100
puts "\$my_answer: $my_answer"
set correct_answer 100
puts "\$correct_answer: $correct_answer"
puts "(\$my_answer eq \$correct_answer):"
if {$my_answer eq $correct_answer} {
    puts "your answer is correct"
} else {
    puts "your answer is wrong"
}

puts "\n# not equal to \[!=, ne\]\n"

set my_answer "25"
puts "\$my_answer: $my_answer"
set correct_answer 100
puts "\$correct_answer: $correct_answer"
puts "(\$my_answer != \$correct_answer):"
if {$my_answer != $correct_answer} {
    puts "your answer is wrong"
} else {
    puts "your answer is correct"
}

set my_answer "25"
puts "\$my_answer: $my_answer"
set correct_answer 100
puts "\$correct_answer: $correct_answer"
puts "(\$my_answer ne \$correct_answer):"
if {$my_answer ne $correct_answer} {
    puts "your answer is wrong"
} else {
    puts "your answer is correct"
}

set my_answer 25
puts "\$my_answer: $my_answer"
set correct_answer 100
puts "\$correct_answer: $correct_answer"
puts "(\$my_answer != \$correct_answer):"
if {$my_answer != $correct_answer} {
    puts "your answer is wrong"
} else {
    puts "your answer is correct"
}

set my_answer 25
puts "\$my_answer: $my_answer"
set correct_answer 100
puts "\$correct_answer: $correct_answer"
puts "(\$my_answer ne \$correct_answer):"
if {$my_answer ne $correct_answer} {
    puts "your answer is wrong"
} else {
    puts "your answer is correct"
}

puts "\n# greater than \[>, gt\]\n"

set my_age "70"
puts "\$my_age: $my_age"
puts "(\$my_age > 50):"
if {$my_age > 50} {
    puts "you are old"
}

# set my_age "70"
# puts "\$my_age: $my_age"
# puts "(\$my_age gt 50):"
# if {$my_age gt 50} {
#     puts "you are old"
# }

set my_age 70
puts "\$my_age: $my_age"
puts "(\$my_age > 50):"
if {$my_age > 50} {
    puts "you are old"
}

# set my_age 70
# puts "\$my_age: $my_age"
# puts "(\$my_age gt 50):"
# if {$my_age gt 50} {
#     puts "you are old"
# }

puts "\n# less than \[<, lt\]\n"

set my_age "16"
puts "\$my_age: $my_age"
puts "(\$my_age < 20):"
if {$my_age < 20} {
    puts "you are young"
}

# set my_age "16"
# puts "\$my_age: $my_age"
# puts "(\$my_age lt 20):"
# if {$my_age lt 20} {
#     puts "you are young"
# }

set my_age 16
puts "\$my_age: $my_age"
puts "(\$my_age < 20):"
if {$my_age < 20} {
    puts "you are young"
}

# set my_age 16
# puts "\$my_age: $my_age"
# puts "(\$my_age lt 20):"
# if {$my_age lt 20} {
#     puts "you are young"
# }

puts "\n# greater than or equal to \[>=, ge\]\n"

set my_age "73"
puts "\$my_age: $my_age"
puts "(\$my_age >= 65):"
if {$my_age >= 65} {
    puts "You are allowed to retire"
}

# set my_age "73"
# puts "\$my_age: $my_age"
# puts "(\$my_age ge 65):"
# if {$my_age ge 65} {
#     puts "You are allowed to retire"
# }

set my_age 73
puts "\$my_age: $my_age"
puts "(\$my_age >= 65):"
if {$my_age >= 65} {
    puts "You are allowed to retire"
}

# set my_age 73
# puts "\$my_age: $my_age"
# puts "(\$my_age ge 65):"
# if {$my_age ge 65} {
#     puts "You are allowed to retire"
# }

puts "\n# less than or equal to \[<=, le\]\n"

set my_age "14"
puts "\$my_age: $my_age"
puts "(\$my_age <= 16):"
if {$my_age <= 16} {
    puts "You are allowed to retire"
}

# set my_age "14"
# puts "\$my_age: $my_age"
# puts "(\$my_age le 16):"
# if {$my_age le 16} {
#     puts "You are allowed to retire"
# }

set my_age 14
puts "\$my_age: $my_age"
puts "(\$my_age <= 16):"
if {$my_age <= 16} {
    puts "You are allowed to retire"
}

# set my_age 14
# puts "\$my_age: $my_age"
# puts "(\$my_age le 16):"
# if {$my_age le 16} {
#     puts "You are allowed to retire"
# }

puts "\n# Logical AND (&&)\n"

set my_age 17
puts "\$my_age: $my_age"
set has_driving_license 0
puts "\$has_driving_license: $has_driving_license"
puts "((\$my_age >= 17) && \$has_driving_license):"
if {(($my_age >= 17) && $has_driving_license)} {
    puts "You are allowed to drive"
} else {
    puts "You are not allowed to drive"
}

set my_age 17
puts "\$my_age: $my_age"
set has_driving_license 1
puts "\$has_driving_license: $has_driving_license"
puts "((\$my_age >= 17) && \$has_driving_license):"
if {(($my_age >= 17) && $has_driving_license)} {
    puts "You are allowed to drive"
} else {
    puts "You are not allowed to drive"
}

puts "\n# Logical OR (||)\n"

set my_age 1
puts "\$my_age: $my_age"
puts "((\$my_age <= 3) || (\$my_age >= 65)):"
if {(($my_age <= 3) || ($my_age >= 65))} {
    puts "You should stay home"
}

set my_age 89
puts "\$my_age: $my_age"
puts "((\$my_age <= 3) || (\$my_age >= 65)):"
if {(($my_age <= 3) || ($my_age >= 65))} {
    puts "You should stay home"
}

puts "\n# Logical NOT (!)\n"

set can_drive 0
puts "\$can_drive: $can_drive"
puts "!\$can_drive: [expr {!$can_drive}]"

set can_drive 1
set cant_drive !$can_drive
puts "\$can_drive: $can_drive"
puts "!\$can_drive: [expr {!$can_drive}]"
