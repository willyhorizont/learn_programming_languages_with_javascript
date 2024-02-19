use serde_json::json;

fn array_filter_v1<F, T>(callback_function: F, an_array: &[T]) -> Vec<T>
where
    F: Fn(&T, usize, &[T]) -> bool,
    T: Clone, // Add this constraint
{
    let mut data_filtered = Vec::new();
    for (array_item_index, array_item) in an_array.iter().enumerate() {
        let is_condition_match = callback_function(array_item, array_item_index, an_array);
        if is_condition_match {
            data_filtered.push(array_item.clone()); // Clone the item
        }
    }
    data_filtered
}

fn main() {
    let numbers = json!({
        "json": [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
    });
    println!("{}", numbers["json"].to_string());

    let numbers_array = &numbers["json"].as_array().unwrap(); // Extract array

    let numbers_even_2 = array_filter_v1(|value, _, _| {
        if let Some(number) = value.as_i64() {
            return number % 2 == 0;
        }
        false // Return false for non-integer values
    }, numbers_array);

    println!("even numbers only: {:?}", numbers_even_2);
}