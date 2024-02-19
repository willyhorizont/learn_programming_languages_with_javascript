fn array_filter_v8<F>(callback_function: F, mut an_array: Vec<serde_json::value::Value>) -> Vec<serde_json::value::Value>
where
    F: Fn(&serde_json::value::Value, usize, &Vec<serde_json::value::Value>) -> bool,
{
    let mut data_filtered: Vec<serde_json::Value> = Vec::new();
    let mut array_item_index = 0;

    for array_item in an_array.iter_mut() {
        let is_condition_match = callback_function(&array_item, array_item_index, &an_array);

        if is_condition_match == true {
            if let Some(a_number) = array_item.as_number() {
                if let Some(a_number_i64) = a_number.as_i64() {
                    data_filtered.push(serde_json::value::Value::from(a_number_i64));
                    continue;
                }
                if let Some(a_number_f64) = a_number.as_f64() {
                    data_filtered.push(serde_json::value::Value::from(a_number_f64));
                    continue;
                }
                if let Some(a_number_u64) = a_number.as_u64() {
                    data_filtered.push(serde_json::value::Value::from(a_number_u64));
                    continue;
                }
                continue;
            }
            if let Some(a_sub_array) = array_item.as_array_mut() {
                data_filtered.push(serde_json::value::Value::Array(a_sub_array.clone()));
                continue;
            }
            if let Some(a_bool) = array_item.as_bool() {
                data_filtered.push(serde_json::value::Value::from(a_bool));
                continue;
            }
            if let Some(a_null) = array_item.as_null() {
                data_filtered.push(serde_json::value::Value::from(a_null));
                continue;
            }
            if let Some(an_object) = array_item.as_object_mut() {
                let object_map: serde_json::Map<String, serde_json::Value> = an_object.clone();
                let object_value = serde_json::value::Value::Object(object_map);
                data_filtered.push(object_value);
                continue;
            }
            if let Some(a_string) = array_item.as_str() {
                data_filtered.push(serde_json::value::Value::from(a_string));
                continue;
            }
        }
        array_item_index += 1;
    }
    return data_filtered;
}

fn main() {
    let numbers = serde_json::json!({
        "json": [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
    });

    let numbers_even_9 = array_filter_v8(|array_item, _, _| {
        if let Some(number) = array_item.as_i64() {
            return (number % 2) == 0;
        }
        return false;
    }, numbers["json"].as_array().unwrap().clone()); // Pass the cloned array
    println!("numbers_even_9: {:?}", numbers_even_9);
}
