# initialization v1
array set friend1 [dict create name "Alisa" country "Finland" age 25]

# iterate over and get each key-value pair
foreach object_key [array names friend1] {
    set object_value $friend1($object_key)
    puts "friend1, key: $object_key, value: $object_value"
}
# friend1, foreach loop, key: country, value: Finland
# friend1, foreach loop, key: age, value: 25
# friend1, foreach loop, key: name, value: Alisa

# initialization v2
array set friend2 [dict create {*}{
    name "Alisa"
    country "Finland"
    age 25
}]

# iterate over and get each key-value pair
foreach object_key [array names friend2] {
    set object_value $friend2($object_key)
    puts "friend2, key: $object_key, value: $object_value"
}
# friend2, foreach loop, key: country, value: Finland
# friend2, foreach loop, key: age, value: 25
# friend2, foreach loop, key: name, value: Alisa

# initialization v3
array set friend3 {
    name "Alisa"
    country "Finland"
    age 25
}

# iterate over and get each key-value pair
foreach object_key [array names friend3] {
    set object_value $friend3($object_key)
    puts "friend3, key: $object_key, value: $object_value"
}
# friend3, foreach loop, key: country, value: Finland
# friend3, foreach loop, key: age, value: 25
# friend3, foreach loop, key: name, value: Alisa
