package main

import "core:fmt"

array :: []any;
object :: map[string]any;

main :: proc() {
	friend := map[string]any{
		"name" = "Alisa",
		"country" = "Finland",
		"age" = 25,
	}

    fmt.println("friend, get country: ", friend["country"], sep = "")
	// friend, get country: Finland

    for object_key, object_value in friend {
		fmt.println("friend, for loop, key: ", object_key, ", value: ", object_value, sep = "")
	}
    // friend, for loop, key: name , value: Alisa
    // friend, for loop, key: country , value: Finland
    // friend, for loop, key: age , value: 25

    // iterate over and get each key-value pair and iteration/entry index
    iteration_index := 0
    for object_key, object_value in friend {
		fmt.println("friend, for loop, index: ", iteration_index, ", key: ", object_key, ", value: ", object_value, sep = "")
        iteration_index += 1
	}
    // friend, for loop, index: 0, key: age, value: 25
    // friend, for loop, index: 1, key: country, value: Finland
    // friend, for loop, index: 2, key: name, value: Alisa
}
