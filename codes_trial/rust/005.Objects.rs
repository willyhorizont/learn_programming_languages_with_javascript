#![allow(unused_variables)]
#![allow(unused_parens)]
#![allow(dead_code)]

fn pretty_json_stringify<T>(anything: &T) -> String where T: ?Sized + serde::ser::Serialize {
    let mut buffer = Vec::new();
    let formatter = serde_json::ser::PrettyFormatter::with_indent(b"    ");
    let mut ser = serde_json::Serializer::with_formatter(&mut buffer, formatter);
    anything.serialize(&mut ser).unwrap();
    return String::from_utf8(buffer).unwrap();
}

fn main() {
    let friend = serde_json::json!({
        "name": "Alisa",
        "country": "Finland",
        "age": 25
    });
    println!("friend: {}", pretty_json_stringify(friend.as_object().unwrap()));

    if let Some(country) = friend["country"].as_str() {
        println!("friend, get country: {:?}", country);
        // friend, get country: Finland
    }

    // iterate over and get each key-value pair
    if let Some(object_entry) = friend.as_object() {
        for (object_key, object_value) in object_entry {
            println!("friend, foreach loop, key: {object_key}, value: {object_value}");
        }
        // friend, foreach loop, key: age, value: 25
        // friend, foreach loop, key: country, value: Finland
        // friend, foreach loop, key: name, value: Alisa
    }
    
    // iterate over and get each key-value pair and iteration/entry index
    if let Some(object_entry) = friend.as_object() {
        for (entry_index, (object_key, object_value)) in object_entry.iter().enumerate() {
            println!("friend, foreach loop, iteration/entry index: {entry_index}, key: {object_key}, value: {object_value}");
        }
        // friend, foreach loop, iteration/entry index: 0, key: age, value: 25
        // friend, foreach loop, iteration/entry index: 1, key: country, value: Finland
        // friend, foreach loop, iteration/entry index: 2, key: name, value: Alisa
    }
}
