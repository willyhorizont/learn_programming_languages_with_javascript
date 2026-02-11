type ocaml_numeric =
    OcamlInt of int
    | OcamlFloat of float

type js_like_type =
    JsLikeNull
    | JsLikeBoolean of bool
    | JsLikeNumeric of ocaml_numeric
    | JsLikeString of string
    | JsLikeArray of js_like_type list
    | JsLikeObject of (string * js_like_type) list
    | JsLikeFunction of (js_like_type list -> js_like_type)

let json_stringify_simple something =
    match something with
    | JsLikeNull -> "null"
    | JsLikeString something_as_string -> "\"" ^ something_as_string ^ "\""
    | JsLikeBoolean something_as_boolean -> if something_as_boolean then "true" else "false"
    | JsLikeNumeric (OcamlInt something_as_numeric) -> string_of_int something_as_numeric
    | JsLikeNumeric (OcamlFloat something_as_numeric) -> string_of_float something_as_numeric
    | JsLikeObject _ -> "{...}"
    | JsLikeArray _ -> "[...]"
    | JsLikeFunction _ -> "[object Function]"

let print_js_like_simple something =
    print_endline (json_stringify_simple something)

let string_repeat any_string repeat_count =
    (* '''JavaScript-like String.repeat() function string_repeat_v2''' *)
    let rec string_repeat_inner current_result current_item =
        if current_item <= 0 then current_result
        else string_repeat_inner (current_result ^ any_string) (current_item - 1)
    in string_repeat_inner "" repeat_count

let object_entries anything =
    let rec object_entries_inner (current_result : js_like_type list) (any_object_inside : (string * js_like_type) list) (object_entries_index : int) : js_like_type list =
        match any_object_inside with
        | [] -> current_result
        | (any_object_key, any_object_value) :: rest_object_entries ->
            object_entries_inner (current_result @ [JsLikeArray [JsLikeString any_object_key; any_object_value]]) rest_object_entries (object_entries_index + 1)
    in
    match anything with
    | JsLikeObject any_object -> JsLikeArray (object_entries_inner [] any_object 0)
    | _ -> JsLikeArray []

let array_for_each anything callback_function =
    let rec array_for_each_inner (any_array_inside : js_like_type list) (callback_function_inner : (js_like_type list -> js_like_type)) (array_item_index : int) : js_like_type =
        match any_array_inside with
        | [] -> JsLikeNull
        | array_item :: rest_array ->
            let _ = callback_function_inner [array_item; JsLikeNumeric (OcamlInt array_item_index); JsLikeArray any_array_inside] in
            let _ = array_for_each_inner rest_array callback_function_inner (array_item_index + 1) in
            JsLikeNull
    in
    match anything with
    | JsLikeArray any_array ->
        let _ = array_for_each_inner any_array callback_function 0 in
        JsLikeNull
    | _ -> JsLikeNull

let json_stringify (rest_arguments : js_like_type list) : js_like_type =
    let indent = string_repeat " " 4 in
    let anything = try List.nth rest_arguments 0 with Failure _ -> JsLikeNull in
    let pretty = try List.nth rest_arguments 1 with Failure _ -> JsLikeNull in
    let rec json_stringify_inner (anything_inside : js_like_type) (indent_level : int) : string =
        match anything_inside with
        | JsLikeNull -> "null"
        | JsLikeString something_as_string -> "\"" ^ something_as_string ^ "\""
        | JsLikeBoolean something_as_boolean -> if something_as_boolean then "true" else "false"
        | JsLikeNumeric (OcamlInt something_as_numeric) -> string_of_int something_as_numeric
        | JsLikeNumeric (OcamlFloat something_as_numeric) -> string_of_float something_as_numeric
        | JsLikeObject something_as_object ->
            if List.length something_as_object == 0 then "{}"
            else
                let any_object_entries =
                    List.mapi
                        (fun object_entry_index (object_key, object_value) ->
                            let current_result_separator = if pretty = JsLikeBoolean true then ",\n" ^ string_repeat indent (indent_level + 1) else ", " in
                            let current_result = "\"" ^ object_key ^ "\": " ^ (json_stringify_inner object_value (indent_level + 1)) in
                            if (object_entry_index + 1) != List.length something_as_object then current_result ^ current_result_separator else current_result)
                        something_as_object
                in
                (if pretty = JsLikeBoolean true then "{\n" ^ string_repeat indent (indent_level + 1) else "{ ")
                ^ String.concat "" any_object_entries
                ^ (if pretty = JsLikeBoolean true then "\n" ^ string_repeat indent indent_level ^ "}" else " }")
        | JsLikeArray something_as_array ->
            if List.length something_as_array == 0 then "[]"
            else
                let any_array_entries =
                    List.mapi
                        (fun array_item_index array_item ->
                            let current_result_separator = if pretty = JsLikeBoolean true then ",\n" ^ string_repeat indent (indent_level + 1) else ", " in
                            let current_result = json_stringify_inner array_item (indent_level + 1) in
                            if (array_item_index + 1) != List.length something_as_array then current_result ^ current_result_separator else current_result)
                        something_as_array
                in
                (if pretty = JsLikeBoolean true then "[\n" ^ string_repeat indent (indent_level + 1) else "[")
                ^ String.concat "" any_array_entries
                ^ (if pretty = JsLikeBoolean true then "\n" ^ string_repeat indent indent_level ^ "]" else "]")
        (* | JsLikeObject something_as_object -> if List.length something_as_object == 0 then "{}" else (if pretty = JsLikeBoolean true then "{\n" ^ string_repeat indent (indent_level + 1) else "{ ") ^ String.concat "" List.mapi (fun object_entry_index (object_key, object_value) -> if (object_entry_index + 1) != List.length something_as_object then "\"" ^ object_key ^ "\": " ^ (json_stringify_inner object_value (indent_level + 1)) ^ if pretty = JsLikeBoolean true then ",\n" ^ string_repeat indent (indent_level + 1) else ", " else "\"" ^ object_key ^ "\": " ^ (json_stringify_inner object_value (indent_level + 1))) something_as_object ^ (if pretty = JsLikeBoolean true then "\n" ^ string_repeat indent indent_level ^ "}" else " }") *)
        (* | JsLikeArray something_as_array -> if List.length something_as_array == 0 then "[]" else (if pretty = JsLikeBoolean true then "[\n" ^ string_repeat indent (indent_level + 1) else "[") ^ String.concat "" List.mapi (fun array_item_index array_item -> if (array_item_index + 1) != List.length something_as_array then json_stringify_inner array_item (indent_level + 1) ^ if pretty = JsLikeBoolean true then ",\n" ^ string_repeat indent (indent_level + 1) else ", " else json_stringify_inner array_item (indent_level + 1)) something_as_array ^ (if pretty = JsLikeBoolean true then "\n" ^ string_repeat indent indent_level ^ "]" else "]")         *)
        (*
        | JsLikeObject something_as_object ->
            if List.length something_as_object == 0 then "{}"
            else (if pretty = JsLikeBoolean true then "{\n" ^ string_repeat indent (indent_level + 1) else "{ ") ^ String.concat "" List.mapi (fun object_entry_index (object_key, object_value) -> if (object_entry_index + 1) != List.length something_as_object then "\"" ^ object_key ^ "\": " ^ JsLikeString (json_stringify_inner object_value (indent_level + 1)) else "\"" ^ object_key ^ "\": " ^ JsLikeString (json_stringify_inner object_value (indent_level + 1)) ^ (if pretty = JsLikeBoolean true then ",\n" ^ string_repeat indent (indent_level + 1) else ", ")) something_as_object ^ (if pretty = JsLikeBoolean true then "\n" ^ string_repeat indent indent_level ^ "}" else " }")
        *)
        (*
        | JsLikeArray something_as_array ->
            if List.length something_as_array == 0 then "[]"
            else (if pretty = JsLikeBoolean true then "[\n" ^ string_repeat indent (indent_level + 1) else "[") ^ String.concat "" List.mapi (fun array_item_index array_item -> if (array_item_index + 1) != (List.length something_as_object) then JsLikeString (json_stringify_inner array_item (indent_level + 1)) else JsLikeString (json_stringify_inner array_item (indent_level + 1)) ^ (if pretty = JsLikeBoolean true then ",\n" ^ string_repeat indent (indent_level + 1) else ", ")) something_as_array ^ (if pretty = JsLikeBoolean true then "\n" ^ string_repeat indent indent_level ^ "]" else "]")
        *)
        | JsLikeFunction _ -> "\"[object Function]\""
    in
    JsLikeString (json_stringify_inner anything 0)

let console_log anything =
    match anything with
    | JsLikeString anything_as_string ->
        print_endline anything_as_string
    | _ -> print_endline "error!"

let () =
    let something : js_like_type ref = ref JsLikeNull in
    something := JsLikeString "foo";
    print_js_like_simple !something;
    (* let _ = json_stringify [!something] in *)
    console_log (json_stringify [!something]);
    something := JsLikeNumeric (OcamlInt 123);
    print_js_like_simple !something;
    something := JsLikeBoolean true;
    print_js_like_simple !something;
    something := JsLikeNull;
    print_js_like_simple !something;
    something := JsLikeArray [JsLikeNumeric (OcamlInt 1); JsLikeNumeric (OcamlInt 2); JsLikeNumeric (OcamlInt 3)];
    print_js_like_simple !something;
    something := JsLikeObject [("foo", JsLikeString "bar")];
    print_js_like_simple !something;

    print_js_like_simple (object_entries !something);

    let deeply_nested_dict = JsLikeObject [
        ("name", JsLikeString "Alice");
        ("details", JsLikeObject [
            ("age", JsLikeNumeric (OcamlInt 30));
            ("address", (JsLikeObject [
                ("street", JsLikeString "123 Main St");
                ("city", JsLikeString "Wonderland");
                ("coordinates", (JsLikeObject [
                    ("lat", JsLikeNumeric (OcamlFloat 51.5074));
                    ("long", JsLikeNumeric (OcamlFloat (-0.1278)))
                ]))
            ]));
            ("phones", (JsLikeArray [
                JsLikeString "+1234567890";
                JsLikeString "+0987654321"
            ]))
        ])
    ] in
    console_log (json_stringify [deeply_nested_dict; JsLikeBoolean true]);
