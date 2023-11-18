package main

import "core:fmt"

main :: proc() {
	fmt.println("Hello, World!")
    
    something: any = "asd"
	fmt.println("something: ", something, sep = "")
    something = 123
	fmt.println("something: ", something, sep = "")
    something = true
	fmt.println("something: ", something, sep = "")
}
