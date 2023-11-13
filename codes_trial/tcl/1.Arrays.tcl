# Array in TCL

# initialization v1
set fruits1 [list "apple" "mango" "orange"]

puts "fruits1, length: [llength $fruits1]"
# fruits1, length: 3

for {set array_item_index 0} {$array_item_index <= ([llength $fruits1] - 1)} {set array_item_index [expr {$array_item_index + 1}]} {
    set array_item [lindex $fruits1 $array_item_index]
    puts "fruits1, index: $array_item_index, value: $array_item"
}
# fruits1, for loop, index: 0, value: apple
# fruits1, for loop, index: 1, value: mango
# fruits1, for loop, index: 2, value: orange

# initialization v2
set fruits2 {"apple" "mango" "orange"}

puts "fruits2, length: [llength $fruits2]"
# fruits2, length: 3

for {set array_item_index 0} {$array_item_index <= ([llength $fruits2] - 1)} {set array_item_index [expr {$array_item_index + 1}]} {
    set array_item [lindex $fruits2 $array_item_index]
    puts "fruits2, index: $array_item_index, value: $array_item"
}
# fruits2, for loop, index: 0, value: apple
# fruits2, for loop, index: 1, value: mango
# fruits2, for loop, index: 2, value: orange

# Array of Objects in TCL

set products {
    {
        id "P1"
        name "bubble gum"
    }
    {
        id "P2"
        name "potato chips"
    }
}

puts "products, length: [llength $products]"
# products, length: 2

for {set array_item_index 0} {$array_item_index <= ([llength $products] - 1)} {set array_item_index [expr {$array_item_index + 1}]} {
    set array_item [lindex $products $array_item_index]
    foreach {object_key object_value} $array_item {
        puts "products, loop, index: $array_item_index, value: key: $object_key, value: $object_value"
   
}
# products, loop, index: 0, value: key: id, value: P1
# products, loop, index: 0, value: key: name, value: bubble gum
# products, loop, index: 1, value: key: id, value: P2
# products, loop, index: 1, value: key: name, value: potato chips
