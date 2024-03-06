def get_rectangle_area_v1(rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end
get_rectangle_area_v2 = Proc.new { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
get_rectangle_area_v3 = proc { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
get_rectangle_area_v4 = Proc.new do |rectangle_width, rectangle_length|
    (rectangle_width * rectangle_length)
end
get_rectangle_area_v5 = proc do |rectangle_width, rectangle_length|
    (rectangle_width * rectangle_length)
end
get_rectangle_area_v6 = lambda { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
get_rectangle_area_v7 = ->(rectangle_width, rectangle_length) { (rectangle_width * rectangle_length) }
get_rectangle_area_v8 = lambda do |rectangle_width, rectangle_length|
    return (rectangle_width * rectangle_length)
end
get_rectangle_area_v9 = ->(rectangle_width, rectangle_length) do
    return (rectangle_width * rectangle_length)
end
