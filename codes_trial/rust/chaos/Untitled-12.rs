#![allow(unused_parens)]
#![allow(while_true)]
#![allow(dead_code)]

type Any = serde_json::Value;

fn print_type_of<T>(_: &T) {
    println!("{}", std::any::type_name::<T>())
}

fn pretty_array_of_primitives(an_array_of_primitives: &Vec<Any>) -> String {
    let mut result = String::from("[");
    for (array_item_index, array_item) in an_array_of_primitives.iter().enumerate() {
        let mut is_an_array_of_primitives = false;
        if let Some(_array_item_casted) = array_item.as_str() {
            is_an_array_of_primitives = true;
        }
        if let Some(_array_item_casted) = array_item.as_number() {
            is_an_array_of_primitives = true;
        }
        if let Some(_array_item_casted) = array_item.as_null() {
            is_an_array_of_primitives = true;
        }
        if let Some(_array_item_casted) = array_item.as_bool() {
            is_an_array_of_primitives = true;
        }
        if (is_an_array_of_primitives == false) {
            continue;
        }
        if let Some(array_item_casted) = array_item.as_str() {
            result += &format!("\"{}\"", array_item_casted);
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

fn array_filter_v8<F>(callback_function: F, an_array: &Vec<serde_json::Value>) -> Vec<serde_json::Value>
where
    F: Fn(&serde_json::Value, usize, &Vec<serde_json::Value>) -> bool,
{
    let mut data_filtered: Vec<serde_json::Value> = Vec::new();

    for (array_item_index, array_item) in an_array.iter().enumerate() {
        let is_condition_match = callback_function(&array_item, array_item_index, &an_array);

        if is_condition_match == true {
            // if let Some(number) = array_item.as_i64() {
            //     data_filtered.push(serde_json::Value::from(number));
            // }
            if let Some(a_number) = array_item.as_number() {
                // data_filtered.push(serde_json::Value::from(a_number));
                if let Some(a_number_f64) = a_number.as_f64() {
                    data_filtered.push(serde_json::Value::from(a_number_f64));
                    continue;
                }
                if let Some(a_number_i64) = a_number.as_i64() {
                    data_filtered.push(serde_json::Value::from(a_number_i64));
                    continue;
                }
                if let Some(a_number_u64) = a_number.as_u64() {
                    data_filtered.push(serde_json::Value::from(a_number_u64));
                    continue;
                }
                continue;
            }
            // if let Some(an_array) = array_item.as_array() {
            //     data_filtered.push(serde_json::Value::from(an_array));
            //     continue;
            // }
            if let Some(a_sub_array) = array_item.as_array() {
                data_filtered.push(serde_json::Value::Array(a_sub_array.clone()));
                continue;
            }
            // if let Some(an_array) = array_item.as_array_mut() {
            //     data_filtered.push(serde_json::Value::from(an_array));
            //     continue;
            // }
            // if let Some(a_sub_array) = array_item.as_array_mut() {
            //     data_filtered.push(serde_json::Value::Array(a_sub_array.clone()));
            //     continue;
            // }
            if let Some(a_bool) = array_item.as_bool() {
                data_filtered.push(serde_json::Value::from(a_bool));
                continue;
            }
            if let Some(a_null) = array_item.as_null() {
                data_filtered.push(serde_json::Value::from(a_null));
                continue;
            }
            // if let Some(an_object) = array_item.as_object() {
            //     data_filtered.push(serde_json::Value::from(an_object));
            //     continue;
            // }
            if let Some(an_object) = array_item.as_object() {
                let object_map: serde_json::Map<String, serde_json::Value> = an_object.clone();
                let object_value = serde_json::Value::Object(object_map);
                data_filtered.push(object_value);
                continue;
            }
            // if let Some(an_object) = array_item.as_object_mut() {
            //     data_filtered.push(serde_json::Value::from(an_object));
            //     continue;
            // }
            // if let Some(an_object) = array_item.as_object_mut() {
            //     let object_map: serde_json::Map<String, serde_json::Value> = an_object.clone();
            //     let object_value = serde_json::Value::Object(object_map);
            //     data_filtered.push(object_value);
            //     continue;
            // }
            if let Some(a_string) = array_item.as_str() {
                data_filtered.push(serde_json::Value::from(a_string));
                continue;
            }
        }
    }
    return data_filtered;
}

fn main() {
    let friend = serde_json::json!({
        "json": ["apple", "mango", "orange"]
    });
    println!("{}", pretty_array_of_primitives(&friend["json"].as_array().unwrap()));
    print_type_of(friend["json"].as_array().unwrap());
    
    let friend2: Vec<Any> = vec![
        Any::from("apple"),
        Any::from("mango"),
        Any::from("orange")
    ];
    print_type_of(&friend2);
    
    let numbers = serde_json::json!({
        "json": [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
    });
    print_type_of(numbers["json"].as_array().unwrap());
    
    let numbers_even_9 = array_filter_v8(|array_item, _, _| {
        if let Some(number) = array_item.as_i64() {
            return (number % 2) == 0;
        }
        return false;
    }, &numbers["json"].as_array().unwrap());
    println!("numbers_even_9: {:?}", numbers_even_9);
    print_type_of(&numbers_even_9);
}
