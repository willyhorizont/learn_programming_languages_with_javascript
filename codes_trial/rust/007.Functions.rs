#![allow(unused_variables)]
#![allow(unused_parens)]
#![allow(dead_code)]
#![allow(unused_must_use)]



// ? < function statement or function declaration

fn get_rectangle_area_v1(rectangle_width: i64, rectangle_length: i64) -> i64 {
    return rectangle_width * rectangle_length;
}

// ? function statement or function declaration />



// ? < Passing functions as arguments to other functions

fn say_hello_v1<F>(callback_function: F) where F: Fn() {
    println!("hello");
    callback_function();
}

fn say_how_are_you_v1() {
    println!("how are you?");
}

// ? Passing functions as arguments to other functions />



// ? < Returning functions as values from other functions

fn multiply_v1(a: i64) -> impl Fn(i64) -> i64 {
    return move |b| a * b;
}

fn multiply_v2(a: i64) -> Box<dyn Fn(i64) -> i64> {
    return Box::new(move |b| a * b);
}

// ? Returning functions as values from other functions />



fn main() {
    // ? < function expression with closure syntax or named closure syntax function

    let get_rectangle_area_v2 = |rectangle_width: i64, rectangle_length: i64| -> i64 {
        return rectangle_width * rectangle_length;
    };

    let get_rectangle_area_v3 = |rectangle_width: i64, rectangle_length: i64| rectangle_width * rectangle_length;

    // ? function expression with closure syntax or named closure syntax function />



    // ? < anonymous function expression with closure syntax
    
    |rectangle_width: i64, rectangle_length: i64| -> i64 {
        return rectangle_width * rectangle_length;
    };
    
    |rectangle_width: i64, rectangle_length: i64| rectangle_width * rectangle_length;

    // ? anonymous function expression with closure syntax />


    
    // ? < Passing functions as arguments to other functions

    say_hello_v1(say_how_are_you_v1);

    say_hello_v1(|| println!("how are you?"));

    let say_hello_v2 = |callback_function: &dyn Fn()| {
        println!("hello");
        callback_function();
    };

    let say_how_are_you_v2 = || println!("how are you?");

    say_hello_v2(&say_how_are_you_v2);

    say_hello_v2(&|| println!("how are you?"));

    // ? Passing functions as arguments to other functions />



    // ? < Assigning functions to variables, but unfortunately we can't freely storing them in data structures

    let get_rectangle_area_v2_copy = |rectangle_width: i64, rectangle_length: i64| -> i64 {
        return rectangle_width * rectangle_length;
    };

    let get_rectangle_area_v3_copy = |rectangle_width: i64, rectangle_length: i64| rectangle_width * rectangle_length;

    // ? Assigning functions to variables, but unfortunately we can't freely storing them in data structures />



    // ? < Returning functions as values from other functions

    let multiply_by_2 = multiply_v1(2);
    let multiply_by_2_result = multiply_by_2(10); // 20
    println!("{:?}", multiply_by_2_result);

    // ? Returning functions as values from other functions />
}
