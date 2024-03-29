package main

import (
	"fmt"
)

const EMPTY_STRING = ""
const TAB = "    "

func main() {
    // while loop

    i1 := 1
    for (true) {
        if (i1 == 2) {
            if (i1 >= 5) {
                break
            }
            i1 += 1
            continue
        }
        fmt.Println("while loop v1, i1 is", fmt.Sprint(i1))
        if (i1 >= 5) {
            break
        }
        i1 += 1
    }

    i2 := 1
    for (i2 <= 5) {
        if (i2 == 2) {
            i2 += 1
            continue
        }
        fmt.Println("while loop v2, i2 is", fmt.Sprint(i2))
        i2 += 1
    }

    // for loop

    for i3 := 1; i3 <= 10; i3 += 1 {
		if (i3 > 5) {
			break
		}
        if (i3 == 2) {
            continue
        }
        fmt.Println("for loop, i3 is", fmt.Sprint(i3))
    }
}
