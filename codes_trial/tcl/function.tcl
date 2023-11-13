proc get_rectangle_area_v1 {rectangle_width rectangle_length} {
    return [expr $rectangle_width * $rectangle_length]
}
# call the function example: get_rectangle_area_v1 3 4
puts [get_rectangle_area_v1 3 4]

# ? function with default arguments

proc greet_someone {greet {person_name "Alisa"}} {
    return [concat $greet " " $person_name]
}
puts [greet_someone "good night"]

proc multiply_v1 {a} {
    proc multiply_by {b} {
        return [expr $a * $b]
    }
    return multiply_by
}

set multiply_by2 [multiply_v1 2]
set multiply_by2_result [$multiply_by2 10]
puts $multiply_by2_result
