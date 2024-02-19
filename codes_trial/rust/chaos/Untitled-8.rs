fn array_reduce_v1<F>(callback_function: F, an_array: &Vec<serde_json::Value>, initial_value: serde_json::Value) -> serde_json::Value
where
    F: Fn(&serde_json::Value, &serde_json::Value, usize, &Vec<serde_json::Value>) -> serde_json::Value,
{
    let mut result: serde_json::Value = initial_value;
    let mut array_item_index = 0;

    for array_item in an_array {
        result = callback_function(&result, &array_item, array_item_index, &an_array);

        array_item_index += 1;
    }
    return result;
}

fn main() {

    let numbers_rust = serde_json::json!({
        "json": [i64::MIN, i64::MAX, u64::MIN, u64::MAX, f64::MIN, f64::MAX]
    });
    println!("{}", &numbers_rust["json"]);

    let numbers_rust_total = array_reduce_v1(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_f64() {
            if let Some(current_number_i64) = current_number.as_f64() {
                return serde_json::Value::from(current_result_i64 + current_number_i64);
            }
            return serde_json::Value::from(0.0);
        }
        return serde_json::Value::from(0.0);
    }, &numbers_rust["json"].as_array().unwrap(), serde_json::Value::from(0.0));
    println!("{}", &numbers_rust_total);
}
