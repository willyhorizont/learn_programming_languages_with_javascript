// use serde_json::json;
type Any = serde_json::Value;

fn print_type_of<T>(_: &T) {
    println!("{}", std::any::type_name::<T>())
}

fn array_filter_v1(an_array: &Vec<Any>) -> bool {
    // fn array_filter_v1<T>(an_array: &Vec<T>) -> bool {
    println!("&an_array");
    print_type_of(&an_array);
    let mut data_filtered = Vec::new();
    println!("&array_item");
    for array_item in an_array {
        print_type_of(&array_item);
        if let Some(number) = array_item.as_i64() {
            if (number % 2) == 0 {
                data_filtered.push(number);
            }
        }
    }
    println!("data_filtered 1: {:?}", data_filtered);
    print_type_of(&data_filtered);
    return true;
}

fn array_filter_v2(an_array: &Vec<Any>) -> bool {
// fn array_filter_v1<T>(an_array: &Vec<T>) -> bool {
    println!("&an_array");
    print_type_of(&an_array);
    let mut data_filtered: Vec<Any> = Vec::new();
    println!("&array_item");
    for array_item in an_array {
        print_type_of(&array_item);
        if let Some(number) = array_item.as_i64() {
            if (number % 2) == 0 {
                data_filtered.push(Any::from(number));
            }
        }
    }
    println!("data_filtered 2: {:?}", data_filtered);
    print_type_of(&data_filtered);
    return true;
}

fn array_filter_v3<F>(callback_function: F, an_array: &Vec<Any>) -> bool
where
    F: Fn(&Any, usize, &Vec<Any>) -> bool,
{
    // fn array_filter_v1<T>(an_array: &Vec<T>) -> bool {
    println!("&an_array");
    print_type_of(&an_array);
    let mut data_filtered = Vec::new();
    println!("&array_item");
    let mut array_item_index = 0;
    for array_item in an_array {
        let is_condition_match = callback_function(&array_item, array_item_index, &an_array);
        println!("is_condition_match: {:?}", is_condition_match);

        print_type_of(&array_item);
        if is_condition_match == true {
            // data_filtered.push(array_item.clone());
            if let Some(number) = array_item.as_i64() {
                data_filtered.push(number);
            }
            // if let Some(number) = array_item.as_i64() {
            //     data_filtered.push(number);
            //     continue;
            // }
            // if let Some(number) = array_item.as_f64() {
            //     data_filtered.push(number);
            //     continue;
            // }
            // if let Some(number) = array_item.as_u64() {
            //     data_filtered.push(number);
            //     continue;
            // }
        }
        array_item_index += 1;
    }
    println!("data_filtered 3: {:?}", data_filtered);
    print_type_of(&data_filtered);
    return true;
}

fn array_filter_v4<F>(callback_function: F, an_array: &Vec<Any>) -> bool
where
    F: Fn(&Any, usize, &Vec<Any>) -> bool,
{
    // fn array_filter_v1<T>(an_array: &Vec<T>) -> bool {
    println!("&an_array");
    print_type_of(&an_array);
    let mut data_filtered: Vec<Any> = Vec::new();
    println!("&array_item");
    let mut array_item_index = 0;
    for array_item in an_array {
        let is_condition_match = callback_function(&array_item, array_item_index, &an_array);
        println!("is_condition_match: {:?}", is_condition_match);

        print_type_of(&array_item);
        if is_condition_match == true {
            // data_filtered.push(array_item.clone());
            if let Some(number) = array_item.as_i64() {
                data_filtered.push(Any::from(number));
            }
        }
        array_item_index += 1;
    }
    println!("data_filtered 4: {:?}", data_filtered);
    print_type_of(&data_filtered);
    return true;
}

// fn array_filter_v5<F>(callback_function: F, an_array: &Vec<Any>) -> Vec<Any>
// where
//     F: Fn(&Any, usize, &Vec<Any>) -> bool,
// {
//     // fn array_filter_v1<T>(an_array: &Vec<T>) -> bool {
//     println!("&an_array");
//     print_type_of(&an_array);
//     let mut data_filtered = Vec::new();
//     println!("&array_item");
//     let mut array_item_index = 0;
//     for array_item in an_array {
//         let is_condition_match = callback_function(&array_item, array_item_index, &an_array);
//         println!("is_condition_match: {:?}", is_condition_match);

//         print_type_of(&array_item);
//         if is_condition_match == true {
//             // data_filtered.push(array_item.clone());
//             if let Some(number) = array_item.as_i64() {
//                 data_filtered.push(number);
//             }
//             // if let Some(number) = array_item.as_i64() {
//             //     data_filtered.push(number);
//             //     continue;
//             // }
//             // if let Some(number) = array_item.as_f64() {
//             //     data_filtered.push(number);
//             //     continue;
//             // }
//             // if let Some(number) = array_item.as_u64() {
//             //     data_filtered.push(number);
//             //     continue;
//             // }
//         }
//         array_item_index += 1;
//     }
//     println!("data_filtered 3: {:?}", data_filtered);
//     print_type_of(&data_filtered);
//     return data_filtered;
// }

fn array_filter_v6<F>(callback_function: F, an_array: &Vec<Any>) -> Vec<Any>
where
    F: Fn(&Any, usize, &Vec<Any>) -> bool,
{
    // fn array_filter_v1<T>(an_array: &Vec<T>) -> bool {
    println!("&an_array");
    print_type_of(&an_array);
    let mut data_filtered: Vec<Any> = Vec::new();
    println!("&array_item");
    let mut array_item_index = 0;
    for array_item in an_array {
        let is_condition_match = callback_function(&array_item, array_item_index, &an_array);
        println!("is_condition_match: {:?}", is_condition_match);

        print_type_of(&array_item);
        if is_condition_match == true {
            // data_filtered.push(array_item.clone());
            if let Some(number) = array_item.as_i64() {
                data_filtered.push(Any::from(number));
            }
        }
        array_item_index += 1;
    }
    println!("data_filtered 4: {:?}", data_filtered);
    print_type_of(&data_filtered);
    return data_filtered;
}

fn array_filter_v7<F>(callback_function: F, an_array: &Vec<Any>) -> Vec<Any>
where
    F: Fn(&Any, usize, &Vec<Any>) -> bool,
{
    let mut data_filtered: Vec<Any> = Vec::new();
    let mut array_item_index = 0;

    for array_item in an_array {
        let is_condition_match = callback_function(&array_item, array_item_index, &an_array);

        if is_condition_match == true {
            // if let Some(number) = array_item.as_i64() {
            //     data_filtered.push(Any::from(number));
            // }
            if let Some(a_number) = array_item.as_number() {
                // data_filtered.push(Any::from(a_number));
                if let Some(a_number_f64) = a_number.as_f64() {
                    data_filtered.push(Any::from(a_number_f64));
                    continue;
                }
                if let Some(a_number_i64) = a_number.as_i64() {
                    data_filtered.push(Any::from(a_number_i64));
                    continue;
                }
                if let Some(a_number_u64) = a_number.as_u64() {
                    data_filtered.push(Any::from(a_number_u64));
                    continue;
                }
                continue;
            }
            // if let Some(an_array) = array_item.as_array() {
            //     data_filtered.push(Any::from(an_array));
            //     continue;
            // }
            if let Some(a_sub_array) = array_item.as_array() {
                data_filtered.push(Any::Array(a_sub_array.clone()));
                continue;
            }
            // if let Some(an_array) = array_item.as_array_mut() {
            //     data_filtered.push(Any::from(an_array));
            //     continue;
            // }
            // if let Some(a_sub_array) = array_item.as_array_mut() {
            //     data_filtered.push(Any::Array(a_sub_array.clone()));
            //     continue;
            // }
            if let Some(a_bool) = array_item.as_bool() {
                data_filtered.push(Any::from(a_bool));
                continue;
            }
            if let Some(a_null) = array_item.as_null() {
                data_filtered.push(Any::from(a_null));
                continue;
            }
            // if let Some(an_object) = array_item.as_object() {
            //     data_filtered.push(Any::from(an_object));
            //     continue;
            // }
            if let Some(an_object) = array_item.as_object() {
                let object_map: serde_json::Map<String, Any> = an_object.clone();
                let object_value = Any::Object(object_map);
                data_filtered.push(object_value);
                continue;
            }
            // if let Some(an_object) = array_item.as_object_mut() {
            //     data_filtered.push(Any::from(an_object));
            //     continue;
            // }
            // if let Some(an_object) = array_item.as_object_mut() {
            //     let object_map: serde_json::Map<String, Any> = an_object.clone();
            //     let object_value = Any::Object(object_map);
            //     data_filtered.push(object_value);
            //     continue;
            // }
            if let Some(a_string) = array_item.as_str() {
                data_filtered.push(Any::from(a_string));
                continue;
            }
        }
        array_item_index += 1;
    }
    return data_filtered;
}

fn array_filter_v8<F>(callback_function: F, an_array: &Vec<Any>) -> Vec<Any>
where
    F: Fn(&Any, usize, &Vec<Any>) -> bool,
{
    let mut data_filtered: Vec<Any> = Vec::new();

    for (array_item_index, array_item) in an_array.iter().enumerate() {
        let is_condition_match = callback_function(&array_item, array_item_index, &an_array);

        if is_condition_match == true {
            // if let Some(number) = array_item.as_i64() {
            //     data_filtered.push(Any::from(number));
            // }
            if let Some(a_number) = array_item.as_number() {
                // data_filtered.push(Any::from(a_number));
                if let Some(a_number_f64) = a_number.as_f64() {
                    data_filtered.push(Any::from(a_number_f64));
                    continue;
                }
                if let Some(a_number_i64) = a_number.as_i64() {
                    data_filtered.push(Any::from(a_number_i64));
                    continue;
                }
                if let Some(a_number_u64) = a_number.as_u64() {
                    data_filtered.push(Any::from(a_number_u64));
                    continue;
                }
                continue;
            }
            // if let Some(an_array) = array_item.as_array() {
            //     data_filtered.push(Any::from(an_array));
            //     continue;
            // }
            if let Some(a_sub_array) = array_item.as_array() {
                data_filtered.push(Any::Array(a_sub_array.clone()));
                continue;
            }
            // if let Some(an_array) = array_item.as_array_mut() {
            //     data_filtered.push(Any::from(an_array));
            //     continue;
            // }
            // if let Some(a_sub_array) = array_item.as_array_mut() {
            //     data_filtered.push(Any::Array(a_sub_array.clone()));
            //     continue;
            // }
            if let Some(a_bool) = array_item.as_bool() {
                data_filtered.push(Any::from(a_bool));
                continue;
            }
            if let Some(a_null) = array_item.as_null() {
                data_filtered.push(Any::from(a_null));
                continue;
            }
            // if let Some(an_object) = array_item.as_object() {
            //     data_filtered.push(Any::from(an_object));
            //     continue;
            // }
            if let Some(an_object) = array_item.as_object() {
                let object_map: serde_json::Map<String, Any> = an_object.clone();
                let object_value = Any::Object(object_map);
                data_filtered.push(object_value);
                continue;
            }
            // if let Some(an_object) = array_item.as_object_mut() {
            //     data_filtered.push(Any::from(an_object));
            //     continue;
            // }
            // if let Some(an_object) = array_item.as_object_mut() {
            //     let object_map: serde_json::Map<String, Any> = an_object.clone();
            //     let object_value = Any::Object(object_map);
            //     data_filtered.push(object_value);
            //     continue;
            // }
            if let Some(a_string) = array_item.as_str() {
                data_filtered.push(Any::from(a_string));
                continue;
            }
        }
    }
    return data_filtered;
}

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
    let numbers = serde_json::json!({
        "json": [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
    });
    println!("{}", numbers["json"].to_string());
    println!("{}", &numbers["json"]);
    print_type_of(&numbers["json"].to_string());
    print_type_of(&&numbers["json"]);
    
    let mut numbers_even_1 = Vec::new();
    if let Any::Array(an_array) = &numbers["json"] {
        println!("&an_array");
        print_type_of(&an_array);
        println!("&array_item");
        for array_item in an_array {
            print_type_of(&array_item);
            if let Some(number) = array_item.as_i64() {
                if (number % 2) == 0 {
                    numbers_even_1.push(number);
                }
            }
        }
    }
    println!("even numbers only: {:?}", numbers_even_1);
    print_type_of(&numbers_even_1);
    
    if let Any::Array(an_array) = &numbers["json"] {
        println!("&an_array");
        print_type_of(&an_array);

        let numbers_even_2 = array_filter_v7(|array_item, _, _| {
            if let Some(number) = array_item.as_i64() {
                return (number % 2) == 0;
            }
            return false;
        }, &an_array);
        println!("numbers_even_2: {:?}", numbers_even_2);
        print_type_of(&numbers_even_2);
    }

    print_type_of(&numbers["json"].as_array().unwrap());
    array_filter_v1(&numbers["json"].as_array().unwrap());
    array_filter_v2(&numbers["json"].as_array().unwrap());

    array_filter_v3(|array_item, _, _| {
        if let Some(number) = array_item.as_i64() {
            return (number % 2) == 0;
        }
        return false;
    }, &numbers["json"].as_array().unwrap());

    array_filter_v4(|array_item, _, _| {
        if let Some(number) = array_item.as_i64() {
            return (number % 2) == 0;
        }
        return false;
    }, &numbers["json"].as_array().unwrap());

    // let numbers_even_5 = array_filter_v5(|array_item, _, _| {
    //     if let Some(number) = array_item.as_i64() {
    //         return (number % 2) == 0;
    //     }
    //     return false;
    // }, &numbers["json"].as_array().unwrap());
    // println!("numbers_even_5: {:?}", numbers_even_5);

    let numbers_even_6 = array_filter_v6(|array_item, _, _| {
        if let Some(number) = array_item.as_i64() {
            return (number % 2) == 0;
        }
        return false;
    }, &numbers["json"].as_array().unwrap());
    println!("numbers_even_6: {:?}", numbers_even_6);
    print_type_of(&numbers_even_6);
    
    if let Any::Array(an_array) = &numbers["json"] {
        println!("&an_array");
        print_type_of(&an_array);
        let numbers_even_7 = array_filter_v6(|array_item, _, _| {
            if let Some(number) = array_item.as_i64() {
                return (number % 2) == 0;
            }
            return false;
        }, &numbers["json"].as_array().unwrap());
        println!("numbers_even_7: {:?}", numbers_even_7);
        print_type_of(&numbers_even_7);
    }

    let numbers_even_8 = array_filter_v7(|array_item, _, _| {
        if let Some(number) = array_item.as_i64() {
            return (number % 2) == 0;
        }
        return false;
    }, &numbers["json"].as_array().unwrap());
    println!("numbers_even_8: {:?}", numbers_even_8);
    print_type_of(&numbers_even_8);

    let numbers_even_9 = array_filter_v8(|array_item, _, _| {
        if let Some(number) = array_item.as_i64() {
            return (number % 2) == 0;
        }
        return false;
    }, &numbers["json"].as_array().unwrap());
    println!("numbers_even_9: {:?}", numbers_even_9);
    print_type_of(&numbers_even_9);

    // if let Any::Array(an_array) = &numbers["json"] {
    //     let numbers_even_3: Vec<_> = an_array
    //         .iter()
    //         .filter_map(|array_item| array_item.as_i64())
    //         .filter(|&number| number % 2 == 0)
    //         .collect();
    //     println!("even numbers only: {:?}", numbers_even_3);
    // }

    let numbers_total_1 = array_reduce_v1(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_i64() {
            if let Some(current_number_i64) = current_number.as_i64() {
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0);
        }
        return Any::from(0);
    }, &numbers["json"].as_array().unwrap(), Any::from(0));
    println!("numbers_total_1: {:?}", numbers_total_1);
    print_type_of(&numbers_total_1);

    if let Any::Array(an_array) = &numbers["json"] {
        println!("&an_array");
        print_type_of(&an_array);

        let numbers_total_2 = array_reduce_v1(|current_result, current_number, _, _| {
            if let Some(current_result_i64) = current_result.as_i64() {
                if let Some(current_number_i64) = current_number.as_i64() {
                    return Any::from(current_result_i64 + current_number_i64);
                }
                return Any::from(0);
            }
            return Any::from(0);
        }, &an_array, Any::from(0));
        println!("numbers_total_2: {:?}", numbers_total_2);
        print_type_of(&numbers_total_2);
    }

    let numbers_total_3 = array_reduce_v1(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_i64() {
            if let Some(current_number_i64) = current_number.as_i64() {
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0);
        }
        return Any::from(0);
    }, &numbers_even_8, Any::from(0));
    println!("numbers_total_3: {:?}", numbers_total_3);
    print_type_of(&numbers_total_3);

    // let numbers_total_4 = array_reduce_v1(|current_result, current_number, _, _| {
    //     if let (Some(current_result_i64), Some(current_number_i64)) = (current_result.as_i64(), current_number.as_i64()) {
    //         return Any::from(current_result_i64 + current_number_i64);
    //     }
    //     return Any::from(0);
    // }, &numbers_even_8, Any::from(0));
    // println!("numbers_total_4: {:?}", numbers_total_4);
    // print_type_of(&numbers_total_4);

    let numbers2 = serde_json::json!({
        "json": [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3]
    });

    let numbers_total_5 = array_reduce_v1(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_f64() {
            if let Some(current_number_i64) = current_number.as_f64() {
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0.0);
        }
        return Any::from(0.0);
    }, &numbers2["json"].as_array().unwrap(), Any::from(0.0));
    println!("numbers_total_5: {:?}", numbers_total_5);
    print_type_of(&numbers_total_5);

    let numbers_total_6 = array_reduce_v2(|current_result, current_number, _, _| {
        if let Some(current_result_i64) = current_result.as_f64() {
            if let Some(current_number_i64) = current_number.as_f64() {
                return Any::from(current_result_i64 + current_number_i64);
            }
            return Any::from(0.0);
        }
        return Any::from(0.0);
    }, &numbers2["json"].as_array().unwrap(), Any::from(0.0));
    println!("numbers_total_6: {:?}", numbers_total_6);
    print_type_of(&numbers_total_6);
}
