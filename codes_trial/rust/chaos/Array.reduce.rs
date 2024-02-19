type Any = serde_json::Value;

fn array_reduce_v1<F>(callback_function: F, an_array: &Vec<Any>, initial_value: Any) -> Any
where
    F: Fn(&Any, &Any, usize, &Vec<Any>) -> Any,
{
    let mut result: Any = initial_value;
    let mut array_item_index = 0;

    for array_item in an_array {
        result = callback_function(&result, &array_item, array_item_index, &an_array);

        array_item_index += 1;
    }
    return result;
}

fn array_reduce_v2<F>(callback_function: F, an_array: &Vec<Any>, initial_value: Any) -> Any
where
    F: Fn(&Any, &Any, usize, &Vec<Any>) -> Any,
{
    let mut result: Any = initial_value;

    for (array_item_index, array_item) in an_array.iter().enumerate() {
        result = callback_function(&result, &array_item, array_item_index, &an_array);
    }
    return result;
}

fn main() {
    let numbers2 = serde_json::json!({
        "json": [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3]
    });

    let numbers_total_5 = array_reduce_v1(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_i64() {
            if let Some(current_number_i64) = current_number.as_i64() {
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0);
        }
        return Any::from(0);
    }, &numbers2["json"].as_array().unwrap(), Any::from(0));
    println!("numbers_total_5: {:?}", numbers_total_5);

    let numbers_total_6 = array_reduce_v1(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_u64() {
            if let Some(current_number_i64) = current_number.as_u64() {
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0);
        }
        return Any::from(0);
    }, &numbers2["json"].as_array().unwrap(), Any::from(0));
    println!("numbers_total_6: {:?}", numbers_total_6);

    let numbers_total_7 = array_reduce_v1(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_f64() {
            if let Some(current_number_i64) = current_number.as_f64() {
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0);
        }
        return Any::from(0);
    }, &numbers2["json"].as_array().unwrap(), Any::from(0));
    println!("numbers_total_7: {:?}", numbers_total_7);

    let numbers_total_8 = array_reduce_v2(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_f64() {
            if let Some(current_number_i64) = current_number.as_f64() {
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0);
        }
        return Any::from(0);
    }, &numbers2["json"].as_array().unwrap(), Any::from(0));
    println!("numbers_total_8: {:?}", numbers_total_8);

    let numbers_rust = serde_json::json!({
        "json": [i64::MIN, i64::MAX, u64::MIN, u64::MAX, f64::MIN, f64::MAX]
        // [-9223372036854775808,9223372036854775807,0,18446744073709551615,-1.7976931348623157e308,1.7976931348623157e308]
    });
    println!("{}", &numbers_rust["json"]);

    let numbers_rust_total = array_reduce_v1(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_f64() {
            // println!("current_result_i64: {:?}", current_result_i64.to_string());
            if let Some(current_number_i64) = current_number.as_f64() {
                // println!("current_number_i64: {:?}", current_number_i64.to_string());
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0);
        }
        return Any::from(0);
    }, &numbers_rust["json"].as_array().unwrap(), Any::from(0));
    println!("numbers_rust_total: {:?}", numbers_rust_total);
}
