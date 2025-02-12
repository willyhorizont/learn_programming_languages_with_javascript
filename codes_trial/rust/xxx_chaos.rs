#![allow(warnings)]
use std::collections::HashMap;
use std::any::type_name;

type RustInt = isize;
type RustUint = usize;
type RustFloat = f32;

#[derive(Clone, Debug)]
enum RustNumeric {
    Int(RustInt),
    Int8(i8),
    Int16(i16),
    Int32(i32),
    Int64(i64),
    Int128(i128),
    IntArchitectureDependent(isize),
    Uint(RustUint),
    Uint8(u8),
    Uint16(u16),
    Uint32(u32),
    Uint64(u64),
    Uint128(u128),
    UintArchitectureDependent(usize),
    Float(RustFloat),
    Float32(f32),
    Float64(f64),
}

#[derive(Clone, Debug)]
enum Any {
    JsLikeString(String),
    JsLikeNumeric(RustNumeric),
    JsLikeBoolean(bool),
    JsLikeNull(()),
    JsLikeArray(Vec<Any>),
    JsLikeObject(HashMap<String, Any>),
    JsLikeFunction(fn(Vec<Any>) -> Any),
}

fn is_like_js_null(something: Any) -> bool {
    if let Any::JsLikeNull(_) = something {
        return true;
    }
    return false;
}

fn is_like_js_boolean(something: Any) -> bool {
    if let Any::JsLikeBoolean(_) = something {
        return true;
    }
    return false;
}

fn is_like_js_string(something: Any) -> bool {
    if let Any::JsLikeString(_) = something {
        return true;
    }
    return false;
}

fn is_like_js_numeric(something: Any) -> bool {
    if let Any::JsLikeNumeric(_) = something {
        return true;
    }
    return false;
}

fn is_like_js_object(something: Any) -> bool {
    if let Any::JsLikeObject(_) = something {
        return true;
    }
    return false;
}

fn is_like_js_array(something: Any) -> bool {
    if let Any::JsLikeArray(_) = something {
        return true;
    }
    return false;
}

fn is_like_js_function(something: Any) -> bool {
    if let Any::JsLikeFunction(_) = something {
        return true;
    }
    return false;
}

fn get_rust_type<T>(_: &T) -> String {
    return String::from(type_name::<T>());
}

fn get_type(something: Any) -> String {
    if (is_like_js_null(something.clone()) == true) {
        return String::from("Null");
    }
    if (is_like_js_boolean(something.clone()) == true) {
        return String::from("Boolean");
    }
    if (is_like_js_string(something.clone()) == true) {
        return String::from("String");
    }
    if (is_like_js_numeric(something.clone()) == true) {
        return String::from("Numeric");
    }
    if (is_like_js_object(something.clone()) == true) {
        return String::from("Object");
    }
    if (is_like_js_array(something.clone()) == true) {
        return String::from("Array");
    }
    if (is_like_js_function(something.clone()) == true) {
        return String::from("Function");
    }
    return get_rust_type(&something);
}

// fn print_type<T>(_: &T) {
//     println!("Type: {}", type_name::<T>());
// }

fn create_new_object_entry(rest_arguments: Vec<Any>) -> Vec<Any> {
    let mut new_object_entry: Vec<Any> = Vec::new();
    let mut array_item_index: RustUint = 0;
    if let Some(Any::JsLikeString(object_key)) = rest_arguments.get(0) {
        let object_value = &rest_arguments[1];
        new_object_entry.push(Any::JsLikeString(String::from(object_key.clone())));
        new_object_entry.push(object_value.clone());
    }
    return new_object_entry;
}

fn create_new_object(rest_arguments: Vec<Any>) -> HashMap<String, Any> {
    let mut new_object: HashMap<String, Any> = HashMap::new();
    let mut array_item_index: RustUint = 0;
    while array_item_index < rest_arguments.len() {
        if let Some(Any::JsLikeArray(object_entry)) = rest_arguments.get(array_item_index) {
            if let Any::JsLikeString(object_key) = &object_entry[0] {
                let object_value = &object_entry[1];
                new_object.insert(object_key.clone(), object_value.clone());
            }
        }
        array_item_index += 1;
    }
    return new_object;
}

fn main() {
    let mut something: Any;
    something = Any::JsLikeString(String::from("foo"));
    println!("get_type(something.clone()): {}", get_type(something.clone()));
    something = Any::JsLikeNumeric(RustNumeric::Int(123));
    println!("get_type(something.clone()): {}", get_type(something.clone()));
    something = Any::JsLikeBoolean(true);
    println!("get_type(something.clone()): {}", get_type(something.clone()));
    something = Any::JsLikeNull(());
    println!("get_type(something.clone()): {}", get_type(something.clone()));
    something = Any::JsLikeArray(vec![
        Any::JsLikeNumeric(RustNumeric::Int(1)),
        Any::JsLikeNumeric(RustNumeric::Int(3)),
        Any::JsLikeNumeric(RustNumeric::Int(3)),
    ]);
    something = Any::JsLikeObject(create_new_object(vec![
        Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("foo")), Any::JsLikeString(String::from("bar"))])),
    ]));
    println!("get_type(something.clone()): {}", get_type(something.clone()));
    something = Any::JsLikeFunction(
        |rest_arguments: Vec<Any>| -> Any {
            let rectangle_width = &rest_arguments[0];
            let rectangle_length = &rest_arguments[1];
            if let Any::JsLikeNumeric(RustNumeric::Int(rectangle_width_ref)) = rectangle_width {
                let mut rectangle_width_rust_int: RustInt = *rectangle_width_ref;
                if let Any::JsLikeNumeric(RustNumeric::Int(rectangle_length_ref)) = rectangle_length {
                    let mut rectangle_length_rust_int: RustInt = *rectangle_length_ref;
                    return (Any::JsLikeNumeric(RustNumeric::Int(rectangle_width_rust_int * rectangle_length_rust_int)));
                }
                panic!("expected numeric rectangle length");
            }
            panic!("expected numeric rectangle width");
        }
    );
    println!("get_type(something.clone()): {}", get_type(something.clone()));
    if let Any::JsLikeFunction(something_as_function) = something.clone() {
        println!("something(7, 5): {:?}", something_as_function(vec![
            Any::JsLikeNumeric(RustNumeric::Int(7)),
            Any::JsLikeNumeric(RustNumeric::Int(5)),
        ]));
    }
    // print_type(&RustNumeric::Int(123));

    let mut my_array: Any = Any::JsLikeArray(vec![
        Any::JsLikeFunction(
            |rest_arguments: Vec<Any>| -> Any {
                let rectangle_width = &rest_arguments[0];
                let rectangle_length = &rest_arguments[1];
                if let Any::JsLikeNumeric(RustNumeric::Int(rectangle_width_ref)) = rectangle_width {
                    let mut rectangle_width_rust_int: RustInt = *rectangle_width_ref;
                    if let Any::JsLikeNumeric(RustNumeric::Int(rectangle_length_ref)) = rectangle_length {
                        let mut rectangle_length_rust_int: RustInt = *rectangle_length_ref;
                        return (Any::JsLikeNumeric(RustNumeric::Int(rectangle_width_rust_int * rectangle_length_rust_int)));
                    }
                    panic!("expected numeric rectangle length");
                }
                panic!("expected numeric rectangle width");
            }
        ),
        Any::JsLikeString(String::from("foo")),
        Any::JsLikeNumeric(RustNumeric::Int(123)),
        Any::JsLikeBoolean(true),
        Any::JsLikeNull(()),
        Any::JsLikeArray(vec![
            Any::JsLikeNumeric(RustNumeric::Int(1)),
            Any::JsLikeNumeric(RustNumeric::Int(3)),
            Any::JsLikeNumeric(RustNumeric::Int(3)),
        ]),
        Any::JsLikeObject(create_new_object(vec![
            Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("foo")), Any::JsLikeString(String::from("bar"))])),
        ])),
    ]);

    let mut my_object: Any = Any::JsLikeObject(create_new_object(vec![
        Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("my_function")), Any::JsLikeFunction(
            |rest_arguments: Vec<Any>| -> Any {
                let rectangle_width = &rest_arguments[0];
                let rectangle_length = &rest_arguments[1];
                if let Any::JsLikeNumeric(RustNumeric::Int(rectangle_width_ref)) = rectangle_width {
                    let mut rectangle_width_rust_int: RustInt = *rectangle_width_ref;
                    if let Any::JsLikeNumeric(RustNumeric::Int(rectangle_length_ref)) = rectangle_length {
                        let mut rectangle_length_rust_int: RustInt = *rectangle_length_ref;
                        return (Any::JsLikeNumeric(RustNumeric::Int(rectangle_width_rust_int * rectangle_length_rust_int)));
                    }
                    panic!("expected numeric rectangle length");
                }
                panic!("expected numeric rectangle width");
            }
        )])),
        Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("my_string")), Any::JsLikeString(String::from("foo"))])),
        Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("my_number")), Any::JsLikeNumeric(RustNumeric::Int(123))])),
        Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("my_bool")), Any::JsLikeBoolean(true)])),
        Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("my_null")), Any::JsLikeNull(())])),
        Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("my_array")), Any::JsLikeArray(vec![
            Any::JsLikeNumeric(RustNumeric::Int(1)),
            Any::JsLikeNumeric(RustNumeric::Int(3)),
            Any::JsLikeNumeric(RustNumeric::Int(3)),
        ])])),
        Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("my_object")), Any::JsLikeObject(create_new_object(vec![
            Any::JsLikeArray(create_new_object_entry(vec![Any::JsLikeString(String::from("foo")), Any::JsLikeString(String::from("bar"))])),
        ]))])),
    ]));
}
