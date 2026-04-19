let get_modified_indent_level : unit -> int =
    fun () ->
        let indent_level = ref 0 in
        let rec change_indent_level : unit -> int =
            fun () ->
                incr indent_level;
                if !indent_level < 5 then change_indent_level () else !indent_level
        in
        change_indent_level ()

let () =
    Printf.printf "get_modified_indent_level(): %d\n" (get_modified_indent_level ())

let get_modified_indent_level : unit -> int =
    fun () ->
        let indent_level = ref 0 in
        let rec change_indent_level : unit -> int =
            fun () ->
                indent_level := !indent_level + 1;
                if !indent_level < 5 then change_indent_level () else !indent_level
        in
        change_indent_level ()

let () =
    Printf.printf "get_modified_indent_level(): %d\n" (get_modified_indent_level ())
