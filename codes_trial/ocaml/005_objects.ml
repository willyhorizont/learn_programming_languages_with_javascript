let rec print_pairs = function
    | [] -> ()
    | (any_object_key, any_object_value) :: rest_object_entries ->
        Printf.printf "%s: %d\n" any_object_key any_object_value;
        print_pairs rest_object_entries

let rec print_pairs_with_index any_object object_entries_index =
    match any_object with
    | [] -> ()
    | (any_object_key, any_object_value) :: rest_object_entries ->
        Printf.printf "Object Entries Index: %d, Key: %s, Value: %d\n" object_entries_index any_object_key any_object_value;
        print_pairs_with_index rest_object_entries (object_entries_index + 1)

let print_pairs_with_index_tail_recursive any_object =
    let rec print_pairs_with_index_tail_recursive_inner any_object object_entries_index =
        match any_object with
        | [] -> ()
        | (any_object_key, any_object_value) :: rest_object_entries ->
            Printf.printf "Object Entries Index: %d, Key: %s, Value: %d\n" object_entries_index any_object_key any_object_value;
            print_pairs_with_index_tail_recursive_inner rest_object_entries (object_entries_index + 1)
    in
    print_pairs_with_index_tail_recursive_inner any_object 0

let () =
    let my_fruit = [("apple", 1); ("banana", 2); ("cherry", 3)] in
    let my_fruit_object_keys_length = List.length my_fruit in
    print_int my_fruit_object_keys_length;
    print_endline "";
    if List.length my_fruit == 0 then print_endline "0" else print_endline "not 0";
    print_pairs my_fruit;
    print_pairs_with_index my_fruit 0
    print_pairs_with_index_tail_recursive my_fruit