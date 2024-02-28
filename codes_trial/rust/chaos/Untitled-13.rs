#![allow(unused_parens)]
#![allow(while_true)]
#![allow(dead_code)]

use serde_json::{Number, Map};

enum Any {
    Null,
    Bool(bool),
    Number(Number),
    String(String),
    Array(Vec<Any>),
    Object(Map<String, Any>),
    Function(Box<dyn Fn()>),
}

fn main() {
    let my_array_of_get_rectangle_area_functions: Vec<Any> = vec![
        |rectangle_width: i64, rectangle_length: i64| rectangle_width * rectangle_length
    ];
    // let simple_calculator = HashMap::from([("key", "value"), ("k2", "v2")]);
}
