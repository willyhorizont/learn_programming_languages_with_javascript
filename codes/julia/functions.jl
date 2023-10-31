# ? function statement or function declaration

function get_rectangle_area_v1(rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end

function get_rectangle_area_v2(rectangle_width, rectangle_length)
    rectangle_width * rectangle_length
end

function get_rectangle_area_v3(rectangle_width, rectangle_length) return rectangle_width * rectangle_length end

function get_rectangle_area_v4(rectangle_width, rectangle_length) rectangle_width * rectangle_length end

get_rectangle_area_v5(rectangle_width, rectangle_length) = return rectangle_width * rectangle_length

get_rectangle_area_v6(rectangle_width, rectangle_length) = rectangle_width * rectangle_length

# ? function expression

get_rectangle_area_v7 = function (rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end

get_rectangle_area_v8 = function (rectangle_width, rectangle_length)
    rectangle_width * rectangle_length
end

get_rectangle_area_v9 = function (rectangle_width, rectangle_length) return rectangle_width * rectangle_length end

get_rectangle_area_v10 = function (rectangle_width, rectangle_length) rectangle_width * rectangle_length end

# ? anonymous function

function (rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end

function (rectangle_width, rectangle_length)
    rectangle_width * rectangle_length
end

function (rectangle_width, rectangle_length) return rectangle_width * rectangle_length end

function (rectangle_width, rectangle_length) rectangle_width * rectangle_length end

# ? named function expression 🤮

get_rectangle_area_v11 = function doSomething(rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end

get_rectangle_area_v12 = function doSomething(rectangle_width, rectangle_length)
    rectangle_width * rectangle_length
end

get_rectangle_area_v13 = function doSomething(rectangle_width, rectangle_length) return rectangle_width * rectangle_length end

get_rectangle_area_v14 = function doSomething(rectangle_width, rectangle_length) rectangle_width * rectangle_length end

# ? arrow function or named arrow function

get_rectangle_area_v15 = (rectangle_width, rectangle_length) ->
    begin
        return rectangle_width * rectangle_length
    end

get_rectangle_area_v16 = (rectangle_width, rectangle_length) ->
    begin
        rectangle_width * rectangle_length
    end

get_rectangle_area_v17 = (rectangle_width, rectangle_length) -> return rectangle_width * rectangle_length

get_rectangle_area_v18 = (rectangle_width, rectangle_length) -> rectangle_width * rectangle_length

# ? anonymous arrow function

(rectangle_width, rectangle_length) ->
    begin
        return rectangle_width * rectangle_length
    end

(rectangle_width, rectangle_length) ->
    begin
        rectangle_width * rectangle_length
    end

(rectangle_width, rectangle_length) -> return rectangle_width * rectangle_length

(rectangle_width, rectangle_length) -> rectangle_width * rectangle_length
