package main

import "core:fmt"

main :: proc() {
    // while loop

	i1 := 1
	for true {
		if (i1 == 2) {
			i1 += 1
			if (i1 > 5) do break
			continue
		}
		fmt.println("while loop v1, i1 is ", i1, sep = "")
		i1 += 1
		if (i1 > 5) do break
	}

    i2 := 1
	for (i2 <= 5) {
		if (i2 == 2) {
			i2 += 1
			continue
		}
		fmt.println("while loop v2, i2 is ", i2, sep = "")
		i2 += 1
	}

    // for loop

    for i3 := 1; i3 <= 5; i3 += 1 {
        if (i3 == 2) do continue
        fmt.println("for loop, i3 is ", i3, sep = "")
    }
}
