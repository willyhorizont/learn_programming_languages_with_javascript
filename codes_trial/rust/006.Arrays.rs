#![allow(unused_variables)]
#![allow(unused_parens)]
#![allow(dead_code)]

type Any = serde_json::Value;

fn pretty_array_of_primitives(an_array_of_primitives: &Vec<Any>) -> String {
    let mut result = String::from("[");
    for (array_item_index, array_item) in an_array_of_primitives.iter().enumerate() {
        if ((array_item.is_string() == false) && (array_item.is_number() == false) && (array_item.is_boolean() == false) && (array_item.is_null() == false)) {
            continue;
        }
        if let Some(array_item_casted) = array_item.as_str() {
            result += &format!("\"{}\"", array_item_casted);
        }
        if let Some(array_item_casted) = array_item.as_null() {
            result += "null";
        }
        if let Some(array_item_casted) = array_item.as_bool() {
            result += &array_item_casted.to_string();
        }
        if let Some(array_item_casted) = array_item.as_number() {
            result += &array_item_casted.to_string();
        }
        if (array_item_index != (an_array_of_primitives.len() - 1)) {
            result += ", ";
        }
    }
    result += "]";
    return result;
}

fn pretty_json_stringify<T>(anything: &T) -> String where T: ?Sized + serde::ser::Serialize {
    let mut buffer = Vec::new();
    let formatter = serde_json::ser::PrettyFormatter::with_indent(b"    ");
    let mut ser = serde_json::Serializer::with_formatter(&mut buffer, formatter);
    anything.serialize(&mut ser).unwrap();
    return String::from_utf8(buffer).unwrap();
}

fn main() {
    // Array

    let fruits = serde_json::json!(["apple", "mango", "orange"]);
    println!("fruits: {}", pretty_array_of_primitives(fruits.as_array().unwrap()));

    println!("fruits, length: {}", fruits.as_array().unwrap().len());
    // fruits, length: 3

    println!("fruits, get mango: {}", fruits.as_array().unwrap()[1]);
    // fruits, get mango: mango

    println!("fruits, first element: {}", fruits.as_array().unwrap()[0]);
    // fruits, first element: apple

    println!("fruits, last element: {}", fruits.as_array().unwrap()[fruits.as_array().unwrap().len() - 1]);
    // fruits, last element: orange

    if let Some(an_array) = fruits.as_array() {
        for (array_item_index, array_item) in an_array.iter().enumerate() {
            println!("fruits, foreach loop, index: {array_item_index}, value: {array_item}");
        }
        // fruits, foreach loop, index: 0, value: "apple"
        // fruits, foreach loop, index: 1, value: "mango"
        // fruits, foreach loop, index: 2, value: "orange"
    }

    // Array of Objects

    let products = serde_json::json!([
        {
            "id": "P1",
            "name": "bubble gum"
        },
        {
            "id": "P2",
            "name": "potato chips"
        }
    ]);
    println!("products: {}", pretty_json_stringify(products.as_array().unwrap()));

    if let Some(an_array) = products.as_array() {
        for (array_item_index, array_item) in an_array.iter().enumerate() {
            if let Some(object_entry) = array_item.as_object() {
                for (entry_index, (object_key, object_value)) in object_entry.iter().enumerate() {
                    println!("products, foreach loop, array item index: {array_item_index}, iteration/entry index: {entry_index}, key: {object_key}, value: {object_value}");
                }
                // products, foreach loop, array item index: 0, iteration/entry index: 0, key: id, value: "P1"
                // products, foreach loop, array item index: 0, iteration/entry index: 1, key: name, value: "bubble gum"
                // products, foreach loop, array item index: 1, iteration/entry index: 0, key: id, value: "P2"
                // products, foreach loop, array item index: 1, iteration/entry index: 1, key: name, value: "potato chips"
            }
        }
    }
}
