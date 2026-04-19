let get_rectangle_area_v1 (rectangle_width : float) (rectangle_length : float) : float =
    rectangle_width *. rectangle_length

let get_rectangle_area_v2 : float -> float -> float = 
    fun rectangle_width rectangle_length ->
      rectangle_width *. rectangle_length

let get_how_are_you_v1 () : string =
    "how are you?"

let get_how_are_you_v2 : unit -> string =
    fun () ->
      "how are you?"
    
