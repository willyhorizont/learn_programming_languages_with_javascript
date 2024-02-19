use serde_json::{json, Value};

fn main() {
    // Creating a vector of serde_json::Value containing Option values
    let options: Vec<Value> = vec![
        json!(null),          // Represents None
        json!(42),            // Represents Some(42)
        json!("hello"),       // Represents Some("hello")
        json!(true),          // Represents Some(true)
    ];

    // Accessing and printing the values
    for option in options {
        match option {
            Value::Null => println!("Value: None"),
            _ => println!("Value: Some({})", option),
        }
    }
}
