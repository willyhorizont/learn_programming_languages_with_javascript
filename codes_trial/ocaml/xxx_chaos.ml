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

let json_stringify something =
    match something with
    | JsLikeNull -> "null"
    | JsLikeString something_as_string -> "\"" ^ something_as_string ^ "\""
    | JsLikeBoolean something_as_boolean -> if something_as_boolean then "true" else "false"
    | JsLikeNumeric (OcamlInt something_as_numeric) -> string_of_int something_as_numeric
    | JsLikeNumeric (OcamlFloat something_as_numeric) -> string_of_float something_as_numeric
    | JsLikeArray _ -> "[...]"
    | JsLikeObject _ -> "{...}"
    | JsLikeFunction _ -> "<function>"

let print_js_like_simple something = print_endline (json_stringify something)

(*
let something : js_like_type ref = ref JsLikeNull;;
let another_thing : js_like_type ref = ref JsLikeNull;;
*)

let () =
    (* callback_function_inner [array_item; JsLikeNumeric (OcamlInt array_item_index); JsLikeArray any_array_inside]; *)
    (* ignore (callback_function_inner [array_item; JsLikeNumeric (OcamlInt array_item_index); JsLikeArray any_array_inside]); *)
    (* let _ = callback_function_inner [array_item; JsLikeNumeric (OcamlInt array_item_index); JsLikeArray any_array_inside] in *)
    let something : js_like_type ref = ref JsLikeNull in
    let another_thing : js_like_type ref = ref JsLikeNull in
    something := JsLikeString "foo";
    print_js_like_simple !something;
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
    
    another_thing := JsLikeString "another one";
    print_js_like_simple !another_thing;
    
    (* print_js_like_simple !(ref (JsLikeString "hi")); *)
    print_js_like_simple (JsLikeString "bye");