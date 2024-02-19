fn maybe_return_value(condition: bool) -> Option<i32> {
    if condition {
        Some(42)
    } else {
        None
    }
}

fn main() {
    let maybe_value = maybe_return_value(false);

    if let Some(value) = maybe_value {
        println!("The value is: {}", value);
    } else {
        println!("The value is None");
    }
}