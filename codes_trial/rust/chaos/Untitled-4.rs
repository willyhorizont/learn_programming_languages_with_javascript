use serde_json::json;
// use serde_json::Value;

// fn array_filter_v1<F>(callback_function: F, an_array: &Vec<Value>) -> Vec<Value>
// where
//     F: Fn(&Value, usize, &[Value]) -> bool,
// {
//     let mut data_filtered = Vec::new();
//     let mut array_item_index = 0;
//     for array_item in an_array {
//         let is_condition_match = callback_function(array_item, array_item_index, an_array);
//         if is_condition_match {
//             data_filtered.push(array_item.clone());
//         }
//         array_item_index += 1;
//     }
//     return data_filtered;
// }
fn array_filter_v1<F, T>(callback_function: F, an_array: &Vec<T>) -> Vec<T>
where
    F: Fn(&T, usize, &Vec<T>) -> bool,
{
    let mut data_filtered = Vec::new();
    let mut array_item_index = 0;
    for array_item in an_array {
        let is_condition_match = callback_function(&array_item, array_item_index, &an_array);
        if is_condition_match {
            if let Some(number) = &array_item.as_i64() {
                data_filtered.push(number);
            }
        }
        array_item_index += 1;
    }
    return data_filtered;
}
// fn array_filter_v2<F, T>(callback_function: F, an_array: &Vec<T>) -> Vec<T>
// where
//     F: Fn(&T, usize, &Vec<T>) -> bool,
// {
//     let mut data_filtered = Vec::new();
//     let mut array_item_index = 0;
//     for array_item in an_array {
//         let is_condition_match = callback_function(&array_item, array_item_index, &an_array);
//         if is_condition_match {
//             if let Some(number) = &array_item.as_i64() {
//                 data_filtered.push(number);
//             }
//         }
//         array_item_index += 1;
//     }
//     return data_filtered;
// }

fn print_type_of<T>(_: &T) {
    println!("{}", std::any::type_name::<T>())
}

fn main() {
    let numbers = json!({
        "json": [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
    });
    println!("{}", numbers["json"].to_string());
    println!("{}", &numbers["json"]);
    
    let mut numbers_even_1 = Vec::new();
    
    if let serde_json::Value::Array(an_array) = &numbers["json"] {
        print_type_of(&an_array);
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

    if let serde_json::Value::Array(an_array) = &numbers["json"] {
        let numbers_even_3 = array_filter_v2(|array_item, _, _| {
            if let Some(number) = array_item.as_i64() {
                return (number % 2) == 0;
            }
            return false
        }, &an_array);
        println!("even numbers only: {:?}", numbers_even_3);
    }

    // if let serde_json::Value::Array(an_array) = &numbers["json"] {
    //     let numbers_even_3: Vec<_> = an_array
    //         .iter()
    //         .filter_map(|array_item| array_item.as_i64())
    //         .filter(|&number| number % 2 == 0)
    //         .collect();
    //     println!("even numbers only: {:?}", numbers_even_3);
    // }
}
