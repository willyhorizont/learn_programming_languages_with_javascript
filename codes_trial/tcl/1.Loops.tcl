# while loop

set i 1
while {1} {
    if {$i == 2} {
        set i [expr $i + 1]
        if {$i > 5} {
            break
        }
        continue
    }
    puts "while loop v1, i is $i"
    set i [expr $i + 1]
    if {$i > 5} {
        break
    }
}

set i 1
while {$i <= 5} {
    if {$i == 2} {
        set i [expr $i + 1]
        continue
    }
    puts "while loop v2, i is $i"
    set i [expr $i + 1]
}

# for loop

for {set i 1} {$i <= 5} {set i [expr {$i + 1}]} {
    if {$i == 2} {
        continue
    }
    puts "for loop, i is $i"
}
