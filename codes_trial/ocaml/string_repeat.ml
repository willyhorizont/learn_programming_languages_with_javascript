let rec string_repeat_v1 any_string repeat_count =
    (* '''JavaScript-like String.repeat() function string_repeat_v1''' *)
    if repeat_count <= 0 then "" else any_string ^ (string_repeat_v1 any_string (repeat_count - 1))

let string_repeat_v2 any_string repeat_count =
    (* '''JavaScript-like String.repeat() function string_repeat_v2''' *)
    let rec string_repeat_inner current_result current_item =
        if current_item <= 0 then current_result
        else string_repeat_inner (current_result ^ any_string) (current_item - 1)
    in string_repeat_inner "" repeat_count
