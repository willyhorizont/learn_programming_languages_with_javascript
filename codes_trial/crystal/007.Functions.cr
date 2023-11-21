# ? function statement or function declaration

def get_rectangle_area_v1(rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v1(3, 4)

# ? function expression with proc function or named proc function
# using return in a proc can lead to unexpected behavior, the last evaluated expression in a block or method is automatically returned.

get_rectangle_area_v2 = Proc.new { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }
# call the function example: get_rectangle_area_v2.call(3, 4) or get_rectangle_area_v2.(3, 4)

get_rectangle_area_v3 = proc { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }
# call the function example: get_rectangle_area_v3.call(3, 4) or get_rectangle_area_v3.(3, 4)

get_rectangle_area_v4 = Proc.new do |rectangle_width, rectangle_length|
    rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v4.call(3, 4) or get_rectangle_area_v4.(3, 4)

get_rectangle_area_v5 = proc do |rectangle_width, rectangle_length|
    rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v5.call(3, 4) or get_rectangle_area_v5.(3, 4)

## ? function expression with lambda function or named lambda function

get_rectangle_area_v6 = lambda { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }
# call the function example: get_rectangle_area_v6.call(3, 4) or get_rectangle_area_v6.(3, 4)

get_rectangle_area_v7 = ->(rectangle_width, rectangle_length) { rectangle_width * rectangle_length }
# call the function example: get_rectangle_area_v7.call(3, 4) or get_rectangle_area_v7.(3, 4)

get_rectangle_area_v8 = lambda do |rectangle_width, rectangle_length|
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v8.call(3, 4) or get_rectangle_area_v8.(3, 4)

get_rectangle_area_v9 = ->(rectangle_width, rectangle_length) do
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v9.call(3, 4) or get_rectangle_area_v9.(3, 4)

# ? anonymous proc function

# Proc.new { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

# proc { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

# Proc.new do |rectangle_width, rectangle_length|
#     rectangle_width * rectangle_length
# end

# proc do |rectangle_width, rectangle_length|
#     rectangle_width * rectangle_length
# end

# ? anonymous lambda function

# lambda { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

# ->(rectangle_width, rectangle_length) { rectangle_width * rectangle_length }

# lambda do |rectangle_width, rectangle_length|
#     return rectangle_width * rectangle_length
# end

# ->(rectangle_width, rectangle_length) do
#     return rectangle_width * rectangle_length
# end
