package main

import "core:fmt"

array :: []any;
object :: map[string]any;

main :: proc() {
	// ? function statement or function declaration and function expression at the same time

    get_rectangle_area_v1 :: proc(rectangle_width: int, rectangle_length: int) -> int {
        return rectangle_width * rectangle_length
    }
    // call the function example: get_rectangle_area_v1(3, 4)

    // ? function expression
}
