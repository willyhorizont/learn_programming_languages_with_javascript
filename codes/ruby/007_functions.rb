# ? function statement or function declaration

def get_rectangle_area_v1(rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v1(7, 5)

# ? function expression with proc function or named proc function
# using return in a proc can lead to unexpected behavior, the last evaluated expression in a block or method is automatically returned.

get_rectangle_area_v2 = Proc.new { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
# call the function example: get_rectangle_area_v2.call(7, 5) or get_rectangle_area_v2.(7, 5)

get_rectangle_area_v3 = proc { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
# call the function example: get_rectangle_area_v3.call(7, 5) or get_rectangle_area_v3.(7, 5)

get_rectangle_area_v4 = Proc.new do |rectangle_width, rectangle_length|
    (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v4.call(7, 5) or get_rectangle_area_v4.(7, 5)

get_rectangle_area_v5 = proc do |rectangle_width, rectangle_length|
    (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v5.call(7, 5) or get_rectangle_area_v5.(7, 5)

## ? function expression with lambda function or named lambda function

get_rectangle_area_v6 = lambda { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }
# call the function example: get_rectangle_area_v6.call(7, 5) or get_rectangle_area_v6.(7, 5)

get_rectangle_area_v7 = ->(rectangle_width, rectangle_length) { (rectangle_width * rectangle_length) }
# call the function example: get_rectangle_area_v7.call(7, 5) or get_rectangle_area_v7.(7, 5)

get_rectangle_area_v8 = lambda do |rectangle_width, rectangle_length|
    return (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v8.call(7, 5) or get_rectangle_area_v8.(7, 5)

get_rectangle_area_v9 = ->(rectangle_width, rectangle_length) do
    return (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v9.call(7, 5) or get_rectangle_area_v9.(7, 5)

# ? anonymous proc function

=begin
    Proc.new { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }

    proc { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }

    Proc.new do |rectangle_width, rectangle_length|
        (rectangle_width * rectangle_length)
    end

    proc do |rectangle_width, rectangle_length|
        (rectangle_width * rectangle_length)
    end
=end

# ? anonymous lambda function

=begin
    lambda { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) }

    ->(rectangle_width, rectangle_length) { (rectangle_width * rectangle_length) }

    lambda do |rectangle_width, rectangle_length|
        return (rectangle_width * rectangle_length)
    end

    ->(rectangle_width, rectangle_length) do
        return (rectangle_width * rectangle_length)
    end
=end

# ? Passing functions as arguments to other functions

def say_hello_v1(callback_function)
    print("hello\n")
    callback_function.call()
end

def say_hello_v2(&callback_function)
    # callback_function is a block
    # & is to convert a block to a proc
    # &callback_function is needed so we can call callback_function function, example: callback_function.() or callback_function.call()
    if (!block_given?)
        print("no block given\n")
        return
    end
    print("hello\n")
    callback_function.call()
end

def say_hello_v3()
    if (!block_given?)
        print("no block given\n")
        return
    end
    print("hello\n")
    yield()
    # yield or yield() is just like a callbackFunction(...arguments)
    # use yield foo, bar, baz or yield(foo, bar, baz) if we need to pass foo, bar, baz to a callback function as arguments
    # use yield or yield() if we don't need to pass anything to a callback function as arguments
end

def say_how_are_you_v1()
    print("how are you?\n")
end

say_how_are_you_v2 = Proc.new { | | print("how are you?\n") }

say_how_are_you_v3 = proc { | | print("how are you?\n") }

say_how_are_you_v4 = Proc.new do | |
    print("how are you?\n")
end

say_how_are_you_v5 = proc do | |
    print("how are you?\n")
end

say_how_are_you_v6 = lambda { | | print("how are you?\n") }

say_how_are_you_v7 = ->() { print("how are you?\n") }

say_how_are_you_v8 = lambda do | |
    print("how are you?\n")
end

say_how_are_you_v9 = ->() do
    print("how are you?\n")
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

say_hello_v1(Proc.new { | | print("how are you?\n") })

say_hello_v1(proc { | | print("how are you?\n") })

say_hello_v1(Proc.new do | |
    print("how are you?\n")
end)

say_hello_v1(proc do | |
    print("how are you?\n")
end)

say_hello_v1(lambda { | | print("how are you?\n") })

say_hello_v1(->() { print("how are you?\n") })

say_hello_v1(lambda do | |
    print("how are you?\n")
end)

say_hello_v1(->() do
    print("how are you?\n")
end)

say_hello_v2 { | | print("how are you?\n") }

say_hello_v2 do | |
    print("how are you?\n")
end

say_hello_v3 { | | print("how are you?\n") }

say_hello_v3 do | |
    print("how are you?\n")
end

# ? Assigning functions to variables or storing them in data structures

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

my_array_of_get_rectangle_area_functions = [
    method(:get_rectangle_area_v1),
    get_rectangle_area_v2,
    Proc.new { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) },
    proc { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) },
    Proc.new do |rectangle_width, rectangle_length|
        (rectangle_width * rectangle_length)
    end,
    proc do |rectangle_width, rectangle_length|
        (rectangle_width * rectangle_length)
    end,
    lambda { |rectangle_width, rectangle_length| (rectangle_width * rectangle_length) },
    ->(rectangle_width, rectangle_length) { (rectangle_width * rectangle_length) },
    lambda do |rectangle_width, rectangle_length|
        return (rectangle_width * rectangle_length)
    end,
    ->(rectangle_width, rectangle_length) do
        return (rectangle_width * rectangle_length)
    end
]

my_array_of_get_rectangle_area_functions[0].call(7, 5)
my_array_of_get_rectangle_area_functions[1].call(7, 5)
my_array_of_get_rectangle_area_functions[2].call(7, 5)
my_array_of_get_rectangle_area_functions[3].call(7, 5)
my_array_of_get_rectangle_area_functions[4].call(7, 5)
my_array_of_get_rectangle_area_functions[5].call(7, 5)
my_array_of_get_rectangle_area_functions[6].call(7, 5)
my_array_of_get_rectangle_area_functions[7].call(7, 5)
my_array_of_get_rectangle_area_functions[8].call(7, 5)
my_array_of_get_rectangle_area_functions[9].call(7, 5)

def check_odd_or_even(a)
    return ((a % 2) == 0)
end

modulus = ->(a, b) { (a % b) }

simple_calculator = {
    "check_odd_or_even" => method(:check_odd_or_even),
    "modulus" => modulus,
    "exponentiation" => Proc.new { |a, b| (a ** b) },
    "multiplication" => proc { |a, b| (a * b) },
    "division" => Proc.new do |a, b|
        (a / b)
    end,
    "addition" => proc do |a, b|
        (a + b)
    end,
    "subtraction" => lambda { |a, b| (a - b) },
    "get_smallest" => ->(a, b) { ((a > b) ? b : a) },
    "get_biggest" => lambda do |a, b|
        return ((a > b) ? a : b)
    end,
    "get_average" => ->(a, b) do
        return ((a * b) / 2)
    end
}

simple_calculator_result1 = simple_calculator["check_odd_or_even"].call(2)
simple_calculator_result2 = simple_calculator["modulus"].call(5, 3)
simple_calculator_result3 = simple_calculator["exponentiation"].call(2, 4)
simple_calculator_result4 = simple_calculator["multiplication"].call(7, 5)
simple_calculator_result5 = simple_calculator["division"].call(81, 9)
simple_calculator_result6 = simple_calculator["addition"].call(9, 3)
simple_calculator_result7 = simple_calculator["subtraction"].call(35, 8)
simple_calculator_result8 = simple_calculator["get_smallest"].call(66, 33)
simple_calculator_result9 = simple_calculator["get_biggest"].call(78, 76)
simple_calculator_result10 = simple_calculator["get_average"].call(3, 5)

# ? Returning functions as values from other functions

def multiply_v1(a)
    multiply_by = Proc.new { |b| (a * b) }
    return multiply_by
end

def multiply_v2(a)
    multiply_by = proc { |b| (a * b) }
    return multiply_by
end

def multiply_v3(a)
    multiply_by = Proc.new do |b|
        (a * b)
    end
    return multiply_by
end

def multiply_v4(a)
    multiply_by = proc do |b|
        (a * b)
    end
    return multiply_by
end

def multiply_v5(a)
    multiply_by = lambda { |b| (a * b) }
    return multiply_by
end

def multiply_v6(a)
    multiply_by = ->(b) { (a * b) }
    return multiply_by
end

def multiply_v7(a)
    multiply_by = lambda do |b|
        return (a * b)
    end
    return multiply_by
end

def multiply_v8(a)
    multiply_by = ->(b) do
        return (a * b)
    end
    return multiply_by
end

multiply_v9 = Proc.new do |a|
    multiply_by = Proc.new { |b| (a * b) }
    return multiply_by
end

multiply_v10 = Proc.new do |a|
    multiply_by = proc { |b| (a * b) }
    return multiply_by
end

multiply_v11 = Proc.new do |a|
    multiply_by = Proc.new do |b|
        (a * b)
    end
    return multiply_by
end

multiply_v12 = Proc.new do |a|
    multiply_by = proc do |b|
        (a * b)
    end
    return multiply_by
end

multiply_v13 = Proc.new do |a|
    multiply_by = lambda { |b| (a * b) }
    return multiply_by
end

multiply_v14 = Proc.new do |a|
    multiply_by = ->(b) { (a * b) }
    return multiply_by
end

multiply_v15 = Proc.new do |a|
    multiply_by = lambda do |b|
        return (a * b)
    end
    return multiply_by
end

multiply_v16 = Proc.new do |a|
    multiply_by = ->(b) do
        return (a * b)
    end
    return multiply_by
end

multiply_v17 = proc do |a|
    multiply_by = Proc.new { |b| (a * b) }
    return multiply_by
end

multiply_v18 = proc do |a|
    multiply_by = proc { |b| (a * b) }
    return multiply_by
end

multiply_v19 = proc do |a|
    multiply_by = Proc.new do |b|
        (a * b)
    end
    return multiply_by
end

multiply_v20 = proc do |a|
    multiply_by = proc do |b|
        (a * b)
    end
    return multiply_by
end

multiply_v21 = proc do |a|
    multiply_by = lambda { |b| (a * b) }
    return multiply_by
end

multiply_v22 = proc do |a|
    multiply_by = ->(b) { (a * b) }
    return multiply_by
end

multiply_v23 = proc do |a|
    multiply_by = lambda do |b|
        return (a * b)
    end
    return multiply_by
end

multiply_v24 = proc do |a|
    multiply_by = ->(b) do
        return (a * b)
    end
    return multiply_by
end

multiply_v25 = lambda do |a|
    multiply_by = Proc.new { |b| (a * b) }
    return multiply_by
end

multiply_v26 = lambda do |a|
    multiply_by = proc { |b| (a * b) }
    return multiply_by
end

multiply_v27 = lambda do |a|
    multiply_by = Proc.new do |b|
        (a * b)
    end
    return multiply_by
end

multiply_v28 = lambda do |a|
    multiply_by = proc do |b|
        (a * b)
    end
    return multiply_by
end

multiply_v29 = lambda do |a|
    multiply_by = lambda { |b| (a * b) }
    return multiply_by
end

multiply_v30 = lambda do |a|
    multiply_by = ->(b) { (a * b) }
    return multiply_by
end

multiply_v31 = lambda do |a|
    multiply_by = lambda do |b|
        return (a * b)
    end
    return multiply_by
end

multiply_v32 = lambda do |a|
    multiply_by = ->(b) do
        return (a * b)
    end
    return multiply_by
end

multiply_v33 = ->(a) do
    multiply_by = Proc.new { |b| (a * b) }
    return multiply_by
end

multiply_v34 = ->(a) do
    multiply_by = proc { |b| (a * b) }
    return multiply_by
end

multiply_v35 = ->(a) do
    multiply_by = Proc.new do |b|
        (a * b)
    end
    return multiply_by
end

multiply_v36 = ->(a) do
    multiply_by = proc do |b|
        (a * b)
    end
    return multiply_by
end

multiply_v37 = ->(a) do
    multiply_by = lambda { |b| (a * b) }
    return multiply_by
end

multiply_v38 = ->(a) do
    multiply_by = ->(b) { (a * b) }
    return multiply_by
end

multiply_v39 = ->(a) do
    multiply_by = lambda do |b|
        return (a * b)
    end
    return multiply_by
end

multiply_v40 = ->(a) do
    multiply_by = ->(b) do
        return (a * b)
    end
    return multiply_by
end

def multiply_v41(a)
    return Proc.new { |b| (a * b) }
end

def multiply_v42(a)
    return proc { |b| (a * b) }
end

def multiply_v43(a)
    return Proc.new do |b|
        (a * b)
    end
end

def multiply_v44(a)
    return proc do |b|
        (a * b)
    end
end

def multiply_v45(a)
    return lambda { |b| (a * b) }
end

def multiply_v46(a)
    return ->(b) { (a * b) }
end

def multiply_v47(a)
    return lambda do |b|
        return (a * b)
    end
end

def multiply_v48(a)
    return ->(b) do
        return (a * b)
    end
end

multiply_v49 = Proc.new do |a|
    return Proc.new { |b| (a * b) }
end

multiply_v50 = Proc.new do |a|
    return proc { |b| (a * b) }
end

multiply_v51 = Proc.new do |a|
    return Proc.new do |b|
        (a * b)
    end
end

multiply_v52 = Proc.new do |a|
    return proc do |b|
        (a * b)
    end
end

multiply_v53 = Proc.new do |a|
    return lambda { |b| (a * b) }
end

multiply_v54 = Proc.new do |a|
    return ->(b) { (a * b) }
end

multiply_v55 = Proc.new do |a|
    return lambda do |b|
        return (a * b)
    end
end

multiply_v56 = Proc.new do |a|
    return ->(b) do
        return (a * b)
    end
end

multiply_v57 = proc do |a|
    return Proc.new { |b| (a * b) }
end

multiply_v58 = proc do |a|
    return proc { |b| (a * b) }
end

multiply_v59 = proc do |a|
    return Proc.new do |b|
        (a * b)
    end
end

multiply_v60 = proc do |a|
    return proc do |b|
        (a * b)
    end
end

multiply_v61 = proc do |a|
    return lambda { |b| (a * b) }
end

multiply_v62 = proc do |a|
    return ->(b) { (a * b) }
end

multiply_v63 = proc do |a|
    return lambda do |b|
        return (a * b)
    end
end

multiply_v64 = proc do |a|
    return ->(b) do
        return (a * b)
    end
end

multiply_v65 = lambda do |a|
    return Proc.new { |b| (a * b) }
end

multiply_v66 = lambda do |a|
    return proc { |b| (a * b) }
end

multiply_v67 = lambda do |a|
    return Proc.new do |b|
        (a * b)
    end
end

multiply_v68 = lambda do |a|
    return proc do |b|
        (a * b)
    end
end

multiply_v69 = lambda do |a|
    return lambda { |b| (a * b) }
end

multiply_v70 = lambda do |a|
    return ->(b) { (a * b) }
end

multiply_v71 = lambda do |a|
    return lambda do |b|
        return (a * b)
    end
end

multiply_v72 = lambda do |a|
    return ->(b) do
        return (a * b)
    end
end

multiply_v73 = ->(a) do
    return Proc.new { |b| (a * b) }
end

multiply_v74 = ->(a) do
    return proc { |b| (a * b) }
end

multiply_v75 = ->(a) do
    return Proc.new do |b|
        (a * b)
    end
end

multiply_v76 = ->(a) do
    return proc do |b|
        (a * b)
    end
end

multiply_v77 = ->(a) do
    return lambda { |b| (a * b) }
end

multiply_v78 = ->(a) do
    return ->(b) { (a * b) }
end

multiply_v79 = ->(a) do
    return lambda do |b|
        return (a * b)
    end
end

multiply_v80 = ->(a) do
    return ->(b) do
        return (a * b)
    end
end

multiply_v81 = Proc.new { |a| Proc.new { |b| (a * b) } }
multiply_v82 = proc { |a| Proc.new { |b| (a * b) } }
multiply_v83 = lambda { |a| Proc.new { |b| (a * b) } }
multiply_v84 = ->(a) { Proc.new { |b| (a * b) } }
multiply_v85 = Proc.new { |a| proc { |b| (a * b) } }
multiply_v86 = proc { |a| proc { |b| (a * b) } }
multiply_v87 = lambda { |a| proc { |b| (a * b) } }
multiply_v88 = ->(a) { proc { |b| (a * b) } }
multiply_v89 = Proc.new { |a| lambda { |b| (a * b) } }
multiply_v90 = proc { |a| lambda { |b| (a * b) } }
multiply_v91 = lambda { |a| lambda { |b| (a * b) } }
multiply_v92 = ->(a) { lambda { |b| (a * b) } }
multiply_v93 = Proc.new { |a| ->(b) { (a * b) } }
multiply_v94 = proc { |a| ->(b) { (a * b) } }
multiply_v95 = lambda { |a| ->(b) { (a * b) } }
multiply_v96 = ->(a) { ->(b) { (a * b) } }

multiply_by2 = multiply_v1(2)
multiply_by2_result = multiply_by2.call(10) # 20

multiply_by3 = multiply_v2(3)
multiply_by3_result = multiply_by3.call(10) # 30

multiply_by4 = multiply_v3(4)
multiply_by4_result = multiply_by4.call(10) # 40

multiply_by5 = multiply_v4(5)
multiply_by5_result = multiply_by5.call(10) # 50

multiply_by6 = multiply_v5(6)
multiply_by6_result = multiply_by6.call(10) # 60

multiply_by7 = multiply_v6(7)
multiply_by7_result = multiply_by7.call(10) # 70

multiply_by8 = multiply_v7(8)
multiply_by8_result = multiply_by8.call(10) # 80

multiply_by9 = multiply_v8(9)
multiply_by9_result = multiply_by9.call(10) # 90

multiply_by10 = multiply_v9.call(10)
multiply_by10_result = multiply_by10.call(10) # 100

multiply_by11 = multiply_v10.call(11)
multiply_by11_result = multiply_by11.call(10) # 110

multiply_by12 = multiply_v11.call(12)
multiply_by12_result = multiply_by12.call(10) # 120

multiply_by13 = multiply_v12.call(13)
multiply_by13_result = multiply_by13.call(10) # 130

multiply_by14 = multiply_v13.call(14)
multiply_by14_result = multiply_by14.call(10) # 140

multiply_by15 = multiply_v14.call(15)
multiply_by15_result = multiply_by15.call(10) # 150

multiply_by16 = multiply_v15.call(16)
multiply_by16_result = multiply_by16.call(10) # 160

multiply_by17 = multiply_v16.call(17)
multiply_by17_result = multiply_by17.call(10) # 170

multiply_by18 = multiply_v17.call(18)
multiply_by18_result = multiply_by18.call(10) # 180

multiply_by19 = multiply_v18.call(19)
multiply_by19_result = multiply_by19.call(10) # 190

multiply_by20 = multiply_v19.call(20)
multiply_by20_result = multiply_by20.call(10) # 200

multiply_by21 = multiply_v20.call(21)
multiply_by21_result = multiply_by21.call(10) # 210

multiply_by22 = multiply_v21.call(22)
multiply_by22_result = multiply_by22.call(10) # 220

multiply_by23 = multiply_v22.call(23)
multiply_by23_result = multiply_by23.call(10) # 230

multiply_by24 = multiply_v23.call(24)
multiply_by24_result = multiply_by24.call(10) # 240

multiply_by25 = multiply_v24.call(25)
multiply_by25_result = multiply_by25.call(10) # 250

multiply_by26 = multiply_v25.call(26)
multiply_by26_result = multiply_by26.call(10) # 260

multiply_by27 = multiply_v26.call(27)
multiply_by27_result = multiply_by27.call(10) # 270

multiply_by28 = multiply_v27.call(28)
multiply_by28_result = multiply_by28.call(10) # 280

multiply_by29 = multiply_v28.call(29)
multiply_by29_result = multiply_by29.call(10) # 290

multiply_by30 = multiply_v29.call(30)
multiply_by30_result = multiply_by30.call(10) # 300

multiply_by31 = multiply_v30.call(31)
multiply_by31_result = multiply_by31.call(10) # 310

multiply_by32 = multiply_v31.call(32)
multiply_by32_result = multiply_by32.call(10) # 320

multiply_by33 = multiply_v32.call(33)
multiply_by33_result = multiply_by33.call(10) # 330

multiply_by34 = multiply_v33.call(34)
multiply_by34_result = multiply_by34.call(10) # 340

multiply_by35 = multiply_v34.call(35)
multiply_by35_result = multiply_by35.call(10) # 350

multiply_by36 = multiply_v35.call(36)
multiply_by36_result = multiply_by36.call(10) # 360

multiply_by37 = multiply_v36.call(37)
multiply_by37_result = multiply_by37.call(10) # 370

multiply_by38 = multiply_v37.call(38)
multiply_by38_result = multiply_by38.call(10) # 380

multiply_by39 = multiply_v38.call(39)
multiply_by39_result = multiply_by39.call(10) # 390

multiply_by40 = multiply_v39.call(40)
multiply_by40_result = multiply_by40.call(10) # 400

multiply_by41 = multiply_v40.call(41)
multiply_by41_result = multiply_by41.call(10) # 410

multiply_by42 = multiply_v41.call(42)
multiply_by42_result = multiply_by42.call(10) # 420

multiply_by43 = multiply_v42.call(43)
multiply_by43_result = multiply_by43.call(10) # 430

multiply_by44 = multiply_v43.call(44)
multiply_by44_result = multiply_by44.call(10) # 440

multiply_by45 = multiply_v44.call(45)
multiply_by45_result = multiply_by45.call(10) # 450

multiply_by46 = multiply_v45.call(46)
multiply_by46_result = multiply_by46.call(10) # 460

multiply_by47 = multiply_v46.call(47)
multiply_by47_result = multiply_by47.call(10) # 470

multiply_by48 = multiply_v47.call(48)
multiply_by48_result = multiply_by48.call(10) # 480

multiply_by49 = multiply_v48.call(49)
multiply_by49_result = multiply_by49.call(10) # 490

multiply_by50 = multiply_v49.call(50)
multiply_by50_result = multiply_by50.call(10) # 500

multiply_by51 = multiply_v50.call(51)
multiply_by51_result = multiply_by51.call(10) # 510

multiply_by52 = multiply_v51.call(52)
multiply_by52_result = multiply_by52.call(10) # 520

multiply_by53 = multiply_v52.call(53)
multiply_by53_result = multiply_by53.call(10) # 530

multiply_by54 = multiply_v53.call(54)
multiply_by54_result = multiply_by54.call(10) # 540

multiply_by55 = multiply_v54.call(55)
multiply_by55_result = multiply_by55.call(10) # 550

multiply_by56 = multiply_v55.call(56)
multiply_by56_result = multiply_by56.call(10) # 560

multiply_by57 = multiply_v56.call(57)
multiply_by57_result = multiply_by57.call(10) # 570

multiply_by58 = multiply_v57.call(58)
multiply_by58_result = multiply_by58.call(10) # 580

multiply_by59 = multiply_v58.call(59)
multiply_by59_result = multiply_by59.call(10) # 590

multiply_by60 = multiply_v59.call(60)
multiply_by60_result = multiply_by60.call(10) # 600

multiply_by61 = multiply_v60.call(61)
multiply_by61_result = multiply_by61.call(10) # 610

multiply_by62 = multiply_v61.call(62)
multiply_by62_result = multiply_by62.call(10) # 620

multiply_by63 = multiply_v62.call(63)
multiply_by63_result = multiply_by63.call(10) # 630

multiply_by64 = multiply_v63.call(64)
multiply_by64_result = multiply_by64.call(10) # 640

multiply_by65 = multiply_v64.call(65)
multiply_by65_result = multiply_by65.call(10) # 650

multiply_by66 = multiply_v65.call(66)
multiply_by66_result = multiply_by66.call(10) # 660

multiply_by67 = multiply_v66.call(67)
multiply_by67_result = multiply_by67.call(10) # 670

multiply_by68 = multiply_v67.call(68)
multiply_by68_result = multiply_by68.call(10) # 680

multiply_by69 = multiply_v68.call(69)
multiply_by69_result = multiply_by69.call(10) # 690

multiply_by70 = multiply_v69.call(70)
multiply_by70_result = multiply_by70.call(10) # 700

multiply_by71 = multiply_v70.call(71)
multiply_by71_result = multiply_by71.call(10) # 710

multiply_by72 = multiply_v71.call(72)
multiply_by72_result = multiply_by72.call(10) # 720

multiply_by73 = multiply_v72.call(73)
multiply_by73_result = multiply_by73.call(10) # 730

multiply_by74 = multiply_v73.call(74)
multiply_by74_result = multiply_by74.call(10) # 740

multiply_by75 = multiply_v74.call(75)
multiply_by75_result = multiply_by75.call(10) # 750

multiply_by76 = multiply_v75.call(76)
multiply_by76_result = multiply_by76.call(10) # 760

multiply_by77 = multiply_v76.call(77)
multiply_by77_result = multiply_by77.call(10) # 770

multiply_by78 = multiply_v77.call(78)
multiply_by78_result = multiply_by78.call(10) # 780

multiply_by79 = multiply_v78.call(79)
multiply_by79_result = multiply_by79.call(10) # 790

multiply_by80 = multiply_v79.call(80)
multiply_by80_result = multiply_by80.call(10) # 800

multiply_by81 = multiply_v80.call(81)
multiply_by81_result = multiply_by81.call(10) # 810

multiply_by82 = multiply_v81.call(82)
multiply_by82_result = multiply_by82.call(10) # 820

multiply_by83 = multiply_v82.call(83)
multiply_by83_result = multiply_by83.call(10) # 830

multiply_by84 = multiply_v83.call(84)
multiply_by84_result = multiply_by84.call(10) # 840

multiply_by85 = multiply_v84.call(85)
multiply_by85_result = multiply_by85.call(10) # 850

multiply_by86 = multiply_v85.call(86)
multiply_by86_result = multiply_by86.call(10) # 860

multiply_by87 = multiply_v86.call(87)
multiply_by87_result = multiply_by87.call(10) # 870

multiply_by88 = multiply_v87.call(88)
multiply_by88_result = multiply_by88.call(10) # 880

multiply_by89 = multiply_v88.call(89)
multiply_by89_result = multiply_by89.call(10) # 890

multiply_by90 = multiply_v89.call(90)
multiply_by90_result = multiply_by90.call(10) # 900

multiply_by91 = multiply_v90.call(91)
multiply_by91_result = multiply_by91.call(10) # 910

multiply_by92 = multiply_v91.call(92)
multiply_by92_result = multiply_by92.call(10) # 920

multiply_by93 = multiply_v92.call(93)
multiply_by93_result = multiply_by93.call(10) # 930

multiply_by94 = multiply_v93.call(94)
multiply_by94_result = multiply_by94.call(10) # 940

multiply_by95 = multiply_v94.call(95)
multiply_by95_result = multiply_by95.call(10) # 950

multiply_by96 = multiply_v95.call(96)
multiply_by96_result = multiply_by96.call(10) # 960

multiply_by97 = multiply_v96.call(97)
multiply_by97_result = multiply_by97.call(10) # 970
