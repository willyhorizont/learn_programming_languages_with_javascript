let my_list : int list = [1; 2; 3; 4];;

let () =
  let item1 = try List.hd my_list with Failure _ -> -1 in
  let item2 = try List.nth my_list 1 with Failure _ -> -1 in
  let pretty = try List.nth my_list 1 with Failure _ -> 0 in
  print_endline (string_of_int item1);
  print_endline (string_of_int item2);
  print_endline (string_of_int pretty)