use serde_json::json;
use serde_json::Value;

fn array_filter_v1<F>(callback_function: F, an_array: &Vec<Value>) -> Vec<Value>
where
    F: Fn(Value, usize, &[Value]) -> bool,
{
    let mut data_filtered = Vec::new();
    let mut array_item_index = 0;
    for array_item in an_array {
        let is_condition_match = callback_function(*array_item, array_item_index, an_array);
        if is_condition_match {
            data_filtered.push(*array_item);
        }
        array_item_index += 1;
    }
    return data_filtered;
}

fn main() {
    let numbers = json!({
        "json": [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
    });
    println!("{}", numbers["json"].to_string());
    println!("{}", &numbers["json"]);
    
    let mut numbers_even_1 = Vec::new();
    
    if let serde_json::Value::Array(an_array) = &numbers["json"] {
        for array_item in an_array {
            if let Some(number) = array_item.as_i64() {
                if (number % 2) == 0 {
                    numbers_even_1.push(number);
                }
            }
        }
    }
    println!("even numbers only: {:?}", numbers_even_1);

    let numbers_even_2 = array_filter_v1(|array_item, _, _| {
        if let Some(number) = array_item.as_i64() {
            return (number % 2) == 0;
        }
        return false
    }, &numbers["json"].as_array().unwrap());

    println!("even numbers only: {:?}", numbers_even_2);
}
