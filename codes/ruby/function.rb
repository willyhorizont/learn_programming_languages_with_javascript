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

=begin
    Proc.new { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

    proc { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

    Proc.new do |rectangle_width, rectangle_length|
        rectangle_width * rectangle_length
    end

    proc do |rectangle_width, rectangle_length|
        rectangle_width * rectangle_length
    end
=end

# ? anonymous lambda function

=begin
    lambda { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

    ->(rectangle_width, rectangle_length) { rectangle_width * rectangle_length }

    lambda do |rectangle_width, rectangle_length|
        return rectangle_width * rectangle_length
    end

    ->(rectangle_width, rectangle_length) do
        return rectangle_width * rectangle_length
    end
=end

=begin
    ? In Ruby, a function is a first-class citizen, which means it supports:
    ? • Passing functions as arguments to other functions
    ? • Assigning functions to variables or storing them in data structures
    ? • Returning functions as values from other functions (closure)
=end

# ? Passing functions as arguments to other functions

def say_hello_v1(do_something)
    puts("hello")
    do_something.()
end

def say_hello_v2(&do_something)
    # do_something is a block
    # & is to convert a block to a proc
    # &do_something is needed so we can call do_something function, example: do_something.() or do_something.call()
    if (!block_given?)
        puts("no block given")
        return
    end
    puts("hello")
    do_something.()
end

def say_hello_v3()
    if (!block_given?)
        puts("no block given")
        return
    end
    puts("hello")
    yield()
    # yield or yield() is just like a callbackFunction(...arguments)
    # use yield foo, bar, baz or yield(foo, bar, baz) if we need to pass foo, bar, baz to a callback function as arguments
    # use yield or yield() if we don't need to pass anything to a callback function as arguments
end

def say_how_are_you_v1()
    puts("how are you?")
end

say_how_are_you_v2 = Proc.new { puts("how are you?") }

say_how_are_you_v3 = proc { puts("how are you?") }

say_how_are_you_v4 = Proc.new do
    puts("how are you?")
end

say_how_are_you_v5 = proc do
    puts("how are you?")
end

say_how_are_you_v6 = lambda { puts("how are you?") }

say_how_are_you_v7 = -> { puts("how are you?") }

say_how_are_you_v8 = lambda do
    puts("how are you?")
end

say_how_are_you_v9 = -> do
    puts("how are you?")
end

say_hello_v1(method(:say_how_are_you_v1))

say_hello_v1(say_how_are_you_v2)

say_hello_v1(say_how_are_you_v3)

say_hello_v1(say_how_are_you_v4)

say_hello_v1(say_how_are_you_v5)

say_hello_v1(say_how_are_you_v6)

say_hello_v1(say_how_are_you_v7)

say_hello_v1(say_how_are_you_v8)

say_hello_v1(say_how_are_you_v9)

say_hello_v1(Proc.new { puts("how are you?") })

say_hello_v1(proc { puts("how are you?") })

say_hello_v1(Proc.new do
    puts("how are you?")
end)

say_hello_v1(proc do
    puts("how are you?")
end)

say_hello_v1(lambda { puts("how are you?") })

say_hello_v1(-> { puts("how are you?") })

say_hello_v1(lambda do
    puts("how are you?")
end)

say_hello_v1(-> do
    puts("how are you?")
end)

say_hello_v2 { puts("how are you?") }

say_hello_v2 do
    puts("how are you?")
end

say_hello_v3 { puts("how are you?") }

say_hello_v3 do
    puts("how are you?")
end

# ? Assigning functions to variables or storing them in data structures

get_rectangle_area_v2 = Proc.new { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

get_rectangle_area_v3 = proc { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

get_rectangle_area_v4 = Proc.new do |rectangle_width, rectangle_length|
    rectangle_width * rectangle_length
end

get_rectangle_area_v5 = proc do |rectangle_width, rectangle_length|
    rectangle_width * rectangle_length
end

get_rectangle_area_v6 = lambda { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }

get_rectangle_area_v7 = ->(rectangle_width, rectangle_length) { rectangle_width * rectangle_length }

get_rectangle_area_v8 = lambda do |rectangle_width, rectangle_length|
    return rectangle_width * rectangle_length
end

get_rectangle_area_v9 = ->(rectangle_width, rectangle_length) do
    return rectangle_width * rectangle_length
end
