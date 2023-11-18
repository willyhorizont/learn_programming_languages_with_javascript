package main

import "core:fmt"

array :: []any;
object :: map[string]any;

main :: proc() {
	// Array in Odin

	fruits := array{"apple", "mango", "orange"}

    fmt.println("fruits, length:", len(fruits), sep = "")
	// fruits, length: 3

    fmt.println("fruits, get mango:", fruits[1], sep = "")
	// fruits, get mango: mango

	fmt.println("fruits, first element:", fruits[0], sep = "")
	// fruits, first element: apple

    fmt.println("fruits, last element:", fruits[len(fruits)-1], sep = "")
	// fruits, last element: orange

    for arrayItem, array_item_index in fruits {
		fmt.println("fruits, for loop, index:", array_item_index, ", value:", arrayItem, sep = "")
	}
	// fruits, for loop, index: 0, value: apple
	// fruits, for loop, index: 1, value: mango
	// fruits, for loop, index: 2, value: orange

    // Array of Objects in Odin

    products := array{
		object{
			"id" =   "P1",
			"name" = "bubble gum",
		},
		object{
			"id" =   "P2",
			"name" = "potato chips",
		},
	}

    for arrayItem, array_item_index in products {
        for object_key, object_value in arrayItem.(object) {
            fmt.println("products, for loop, index:", array_item_index, ", key: ", object_key, ", value:", object_value, sep = "")
        }
	}
    // products, for loop, index: 0 , key:  name , value: bubble gum
    // products, for loop, index: 0 , key:  id , value: P1
    // products, for loop, index: 1 , key:  id , value: P2
    // products, for loop, index: 1 , key:  name , value: potato chips
}
