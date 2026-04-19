let rec string_repeat any_string repeat_count = if repeat_count <= 0 then "" else any_string ^ (string_repeat any_string (repeat_count - 1));;

let () =
  let indent = string_repeat " " 4;
  print_endline indent;