# ? function statement or function declaration

def get_rectangle_area_v1(rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v1(7, 5)

# ? function expression with proc function or named proc function
# using return in a proc can lead to unexpected behavior, the last evaluated expression in a block or method is automatically returned.

get_rectangle_area_v2 = Proc.new { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }
# call the function example: get_rectangle_area_v2.call(7, 5) or get_rectangle_area_v2.(7, 5)

get_rectangle_area_v3 = proc { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }
# call the function example: get_rectangle_area_v3.call(7, 5) or get_rectangle_area_v3.(7, 5)

get_rectangle_area_v4 = Proc.new do |rectangle_width, rectangle_length|
    rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v4.call(7, 5) or get_rectangle_area_v4.(7, 5)

get_rectangle_area_v5 = proc do |rectangle_width, rectangle_length|
    rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v5.call(7, 5) or get_rectangle_area_v5.(7, 5)

## ? function expression with lambda function or named lambda function

get_rectangle_area_v6 = lambda { |rectangle_width, rectangle_length| rectangle_width * rectangle_length }
# call the function example: get_rectangle_area_v6.call(7, 5) or get_rectangle_area_v6.(7, 5)

get_rectangle_area_v7 = ->(rectangle_width, rectangle_length) { rectangle_width * rectangle_length }
# call the function example: get_rectangle_area_v7.call(7, 5) or get_rectangle_area_v7.(7, 5)

get_rectangle_area_v8 = lambda do |rectangle_width, rectangle_length|
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v8.call(7, 5) or get_rectangle_area_v8.(7, 5)

get_rectangle_area_v9 = ->(rectangle_width, rectangle_length) do
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v9.call(7, 5) or get_rectangle_area_v9.(7, 5)

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

# ? Passing functions as arguments to other functions

def say_hello_v1(callback_function)
    print("hello\n")
    callback_function.()
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
    callback_function.()
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

say_how_are_you_v2 = Proc.new { print("how are you?\n") }

say_how_are_you_v3 = proc { print("how are you?\n") }

say_how_are_you_v4 = Proc.new do
    print("how are you?\n")
end

say_how_are_you_v5 = proc do
    print("how are you?\n")
end

say_how_are_you_v6 = lambda { print("how are you?\n") }

say_how_are_you_v7 = -> { print("how are you?\n") }

say_how_are_you_v8 = lambda do
    print("how are you?\n")
end

say_how_are_you_v9 = -> do
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

say_hello_v1(Proc.new { print("how are you?\n") })

say_hello_v1(proc { print("how are you?\n") })

say_hello_v1(Proc.new do
    print("how are you?\n")
end)

say_hello_v1(proc do
    print("how are you?\n")
end)

say_hello_v1(lambda { print("how are you?\n") })

say_hello_v1(-> { print("how are you?\n") })

say_hello_v1(lambda do
    print("how are you?\n")
end)

say_hello_v1(-> do
    print("how are you?\n")
end)

say_hello_v2 { print("how are you?\n") }

say_hello_v2 do
    print("how are you?\n")
end

say_hello_v3 { print("how are you?\n") }

say_hello_v3 do
    print("how are you?\n")
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

my_array_of_get_rectangle_area_functions = [
    method(:get_rectangle_area_v1),
    get_rectangle_area_v2,
    Proc.new { |rectangle_width, rectangle_length| rectangle_width * rectangle_length },
    proc { |rectangle_width, rectangle_length| rectangle_width * rectangle_length },
    Proc.new do |rectangle_width, rectangle_length|
        rectangle_width * rectangle_length
    end,
    proc do |rectangle_width, rectangle_length|
        rectangle_width * rectangle_length
    end,
    lambda { |rectangle_width, rectangle_length| rectangle_width * rectangle_length },
    ->(rectangle_width, rectangle_length) { rectangle_width * rectangle_length },
    lambda do |rectangle_width, rectangle_length|
        return rectangle_width * rectangle_length
    end,
    ->(rectangle_width, rectangle_length) do
        return rectangle_width * rectangle_length
    end
]

my_array_of_get_rectangle_area_functions[0].(7, 5)
my_array_of_get_rectangle_area_functions[1].(7, 5)
my_array_of_get_rectangle_area_functions[2].(7, 5)
my_array_of_get_rectangle_area_functions[3].(7, 5)
my_array_of_get_rectangle_area_functions[4].(7, 5)
my_array_of_get_rectangle_area_functions[5].(7, 5)
my_array_of_get_rectangle_area_functions[6].(7, 5)
my_array_of_get_rectangle_area_functions[7].(7, 5)
my_array_of_get_rectangle_area_functions[8].(7, 5)
my_array_of_get_rectangle_area_functions[9].(7, 5)

def check_odd_or_even(a)
    return (a % 2) == 0
end

modulus = ->(a, b) { a % b }

simple_calculator = {
    "check_odd_or_even" => method(:check_odd_or_even),
    "modulus" => modulus,
    "exponentiation" => Proc.new { |a, b| a ** b },
    "multiplication" => proc { |a, b| a * b },
    "division" => Proc.new do |a, b|
        a / b
    end,
    "addition" => proc do |a, b|
        a + b
    end,
    "subtraction" => lambda { |a, b| a - b },
    "get_smallest" => ->(a, b) { ((a > b) ? b : a) },
    "get_biggest" => lambda do |a, b|
        return ((a > b) ? a : b)
    end,
    "get_average" => ->(a, b) do
        return (a * b) / 2
    end
}

simple_calculator_result1 = simple_calculator["check_odd_or_even"].(2)
simple_calculator_result2 = simple_calculator["modulus"].(5, 3)
simple_calculator_result3 = simple_calculator["exponentiation"].(2, 4)
simple_calculator_result4 = simple_calculator["multiplication"].(7, 5)
simple_calculator_result5 = simple_calculator["division"].(81, 9)
simple_calculator_result6 = simple_calculator["addition"].(9, 3)
simple_calculator_result7 = simple_calculator["subtraction"].(35, 8)
simple_calculator_result8 = simple_calculator["get_smallest"].(66, 33)
simple_calculator_result9 = simple_calculator["get_biggest"].(78, 76)
simple_calculator_result10 = simple_calculator["get_average"].(3, 5)

# ? Returning functions as values from other functions

def multiply_v1(a)
    multiply_by = Proc.new { |b| a * b }
    return multiply_by
end

def multiply_v2(a)
    multiply_by = proc { |b| a * b }
    return multiply_by
end

def multiply_v3(a)
    multiply_by = Proc.new do |b|
        a * b
    end
    return multiply_by
end

def multiply_v4(a)
    multiply_by = proc do |b|
        a * b
    end
    return multiply_by
end

def multiply_v5(a)
    multiply_by = lambda { |b| a * b }
    return multiply_by
end

def multiply_v6(a)
    multiply_by = ->(b) { a * b }
    return multiply_by
end

def multiply_v7(a)
    multiply_by = lambda do |b|
        return a * b
    end
    return multiply_by
end

def multiply_v8(a)
    multiply_by = ->(b) do
        return a * b
    end
    return multiply_by
end

multiply_v9 = Proc.new do |a|
    multiply_by = Proc.new { |b| a * b }
    return multiply_by
end

multiply_v10 = Proc.new do |a|
    multiply_by = proc { |b| a * b }
    return multiply_by
end

multiply_v11 = Proc.new do |a|
    multiply_by = Proc.new do |b|
        a * b
    end
    return multiply_by
end

multiply_v12 = Proc.new do |a|
    multiply_by = proc do |b|
        a * b
    end
    return multiply_by
end

multiply_v13 = Proc.new do |a|
    multiply_by = lambda { |b| a * b }
    return multiply_by
end

multiply_v14 = Proc.new do |a|
    multiply_by = ->(b) { a * b }
    return multiply_by
end

multiply_v15 = Proc.new do |a|
    multiply_by = lambda do |b|
        return a * b
    end
    return multiply_by
end

multiply_v16 = Proc.new do |a|
    multiply_by = ->(b) do
        return a * b
    end
    return multiply_by
end

multiply_v17 = proc do |a|
    multiply_by = Proc.new { |b| a * b }
    return multiply_by
end

multiply_v18 = proc do |a|
    multiply_by = proc { |b| a * b }
    return multiply_by
end

multiply_v19 = proc do |a|
    multiply_by = Proc.new do |b|
        a * b
    end
    return multiply_by
end

multiply_v20 = proc do |a|
    multiply_by = proc do |b|
        a * b
    end
    return multiply_by
end

multiply_v21 = proc do |a|
    multiply_by = lambda { |b| a * b }
    return multiply_by
end

multiply_v22 = proc do |a|
    multiply_by = ->(b) { a * b }
    return multiply_by
end

multiply_v23 = proc do |a|
    multiply_by = lambda do |b|
        return a * b
    end
    return multiply_by
end

multiply_v24 = proc do |a|
    multiply_by = ->(b) do
        return a * b
    end
    return multiply_by
end

multiply_v25 = lambda do |a|
    multiply_by = Proc.new { |b| a * b }
    return multiply_by
end

multiply_v26 = lambda do |a|
    multiply_by = proc { |b| a * b }
    return multiply_by
end

multiply_v27 = lambda do |a|
    multiply_by = Proc.new do |b|
        a * b
    end
    return multiply_by
end

multiply_v28 = lambda do |a|
    multiply_by = proc do |b|
        a * b
    end
    return multiply_by
end

multiply_v29 = lambda do |a|
    multiply_by = lambda { |b| a * b }
    return multiply_by
end

multiply_v30 = lambda do |a|
    multiply_by = ->(b) { a * b }
    return multiply_by
end

multiply_v31 = lambda do |a|
    multiply_by = lambda do |b|
        return a * b
    end
    return multiply_by
end

multiply_v32 = lambda do |a|
    multiply_by = ->(b) do
        return a * b
    end
    return multiply_by
end

multiply_v33 = ->(a) do
    multiply_by = Proc.new { |b| a * b }
    return multiply_by
end

multiply_v34 = ->(a) do
    multiply_by = proc { |b| a * b }
    return multiply_by
end

multiply_v35 = ->(a) do
    multiply_by = Proc.new do |b|
        a * b
    end
    return multiply_by
end

multiply_v36 = ->(a) do
    multiply_by = proc do |b|
        a * b
    end
    return multiply_by
end

multiply_v37 = ->(a) do
    multiply_by = lambda { |b| a * b }
    return multiply_by
end

multiply_v38 = ->(a) do
    multiply_by = ->(b) { a * b }
    return multiply_by
end

multiply_v39 = ->(a) do
    multiply_by = lambda do |b|
        return a * b
    end
    return multiply_by
end

multiply_v40 = ->(a) do
    multiply_by = ->(b) do
        return a * b
    end
    return multiply_by
end

def multiply_v41(a)
    return Proc.new { |b| a * b }
end

def multiply_v42(a)
    return proc { |b| a * b }
end

def multiply_v43(a)
    return Proc.new do |b|
        a * b
    end
end

def multiply_v44(a)
    return proc do |b|
        a * b
    end
end

def multiply_v45(a)
    return lambda { |b| a * b }
end

def multiply_v46(a)
    return ->(b) { a * b }
end

def multiply_v47(a)
    return lambda do |b|
        return a * b
    end
end

def multiply_v48(a)
    return ->(b) do
        return a * b
    end
end

multiply_v49 = Proc.new do |a|
    return Proc.new { |b| a * b }
end

multiply_v50 = Proc.new do |a|
    return proc { |b| a * b }
end

multiply_v51 = Proc.new do |a|
    return Proc.new do |b|
        a * b
    end
end

multiply_v52 = Proc.new do |a|
    return proc do |b|
        a * b
    end
end

multiply_v53 = Proc.new do |a|
    return lambda { |b| a * b }
end

multiply_v54 = Proc.new do |a|
    return ->(b) { a * b }
end

multiply_v55 = Proc.new do |a|
    return lambda do |b|
        return a * b
    end
end

multiply_v56 = Proc.new do |a|
    return ->(b) do
        return a * b
    end
end

multiply_v57 = proc do |a|
    return Proc.new { |b| a * b }
end

multiply_v58 = proc do |a|
    return proc { |b| a * b }
end

multiply_v59 = proc do |a|
    return Proc.new do |b|
        a * b
    end
end

multiply_v60 = proc do |a|
    return proc do |b|
        a * b
    end
end

multiply_v61 = proc do |a|
    return lambda { |b| a * b }
end

multiply_v62 = proc do |a|
    return ->(b) { a * b }
end

multiply_v63 = proc do |a|
    return lambda do |b|
        return a * b
    end
end

multiply_v64 = proc do |a|
    return ->(b) do
        return a * b
    end
end

multiply_v65 = lambda do |a|
    return Proc.new { |b| a * b }
end

multiply_v66 = lambda do |a|
    return proc { |b| a * b }
end

multiply_v67 = lambda do |a|
    return Proc.new do |b|
        a * b
    end
end

multiply_v68 = lambda do |a|
    return proc do |b|
        a * b
    end
end

multiply_v69 = lambda do |a|
    return lambda { |b| a * b }
end

multiply_v70 = lambda do |a|
    return ->(b) { a * b }
end

multiply_v71 = lambda do |a|
    return lambda do |b|
        return a * b
    end
end

multiply_v72 = lambda do |a|
    return ->(b) do
        return a * b
    end
end

multiply_v73 = ->(a) do
    return Proc.new { |b| a * b }
end

multiply_v74 = ->(a) do
    return proc { |b| a * b }
end

multiply_v75 = ->(a) do
    return Proc.new do |b|
        a * b
    end
end

multiply_v76 = ->(a) do
    return proc do |b|
        a * b
    end
end

multiply_v77 = ->(a) do
    return lambda { |b| a * b }
end

multiply_v78 = ->(a) do
    return ->(b) { a * b }
end

multiply_v79 = ->(a) do
    return lambda do |b|
        return a * b
    end
end

multiply_v80 = ->(a) do
    return ->(b) do
        return a * b
    end
end

multiply_v81 = Proc.new { |a| Proc.new { |b| a * b } }
multiply_v82 = proc { |a| Proc.new { |b| a * b } }
multiply_v83 = lambda { |a| Proc.new { |b| a * b } }
multiply_v84 = ->(a) { Proc.new { |b| a * b } }
multiply_v85 = Proc.new { |a| proc { |b| a * b } }
multiply_v86 = proc { |a| proc { |b| a * b } }
multiply_v87 = lambda { |a| proc { |b| a * b } }
multiply_v88 = ->(a) { proc { |b| a * b } }
multiply_v89 = Proc.new { |a| lambda { |b| a * b } }
multiply_v90 = proc { |a| lambda { |b| a * b } }
multiply_v91 = lambda { |a| lambda { |b| a * b } }
multiply_v92 = ->(a) { lambda { |b| a * b } }
multiply_v93 = Proc.new { |a| ->(b) { a * b } }
multiply_v94 = proc { |a| ->(b) { a * b } }
multiply_v95 = lambda { |a| ->(b) { a * b } }
multiply_v96 = ->(a) { ->(b) { a * b } }

multiply_by_2 = multiply_v1(2)
multiply_by_2_result = multiply_by_2.(10) # 20

multiply_by_3 = multiply_v2(3)
multiply_by_3_result = multiply_by_3.(10) # 30

multiply_by_4 = multiply_v3(4)
multiply_by_4_result = multiply_by_4.(10) # 40

multiply_by_5 = multiply_v4(5)
multiply_by_5_result = multiply_by_5.(10) # 50

multiply_by_6 = multiply_v5(6)
multiply_by_6_result = multiply_by_6.(10) # 60

multiply_by_7 = multiply_v6(7)
multiply_by_7_result = multiply_by_7.(10) # 70

multiply_by_8 = multiply_v7(8)
multiply_by_8_result = multiply_by_8.(10) # 80

multiply_by_9 = multiply_v8(9)
multiply_by_9_result = multiply_by_9.(10) # 90

multiply_by_10 = multiply_v9.(10)
multiply_by_10_result = multiply_by_10.(10) # 100

multiply_by_11 = multiply_v10.(11)
multiply_by_11_result = multiply_by_11.(10) # 110

multiply_by_12 = multiply_v11.(12)
multiply_by_12_result = multiply_by_12.(10) # 120

multiply_by_13 = multiply_v12.(13)
multiply_by_13_result = multiply_by_13.(10) # 130

multiply_by_14 = multiply_v13.(14)
multiply_by_14_result = multiply_by_14.(10) # 140

multiply_by_15 = multiply_v14.(15)
multiply_by_15_result = multiply_by_15.(10) # 150

multiply_by_16 = multiply_v15.(16)
multiply_by_16_result = multiply_by_16.(10) # 160

multiply_by_17 = multiply_v16.(17)
multiply_by_17_result = multiply_by_17.(10) # 170

multiply_by_18 = multiply_v17.(18)
multiply_by_18_result = multiply_by_18.(10) # 180

multiply_by_19 = multiply_v18.(19)
multiply_by_19_result = multiply_by_19.(10) # 190

multiply_by_20 = multiply_v19.(20)
multiply_by_20_result = multiply_by_20.(10) # 200

multiply_by_21 = multiply_v20.(21)
multiply_by_21_result = multiply_by_21.(10) # 210

multiply_by_22 = multiply_v21.(22)
multiply_by_22_result = multiply_by_22.(10) # 220

multiply_by_23 = multiply_v22.(23)
multiply_by_23_result = multiply_by_23.(10) # 230

multiply_by_24 = multiply_v23.(24)
multiply_by_24_result = multiply_by_24.(10) # 240

multiply_by_25 = multiply_v24.(25)
multiply_by_25_result = multiply_by_25.(10) # 250

multiply_by_26 = multiply_v25.(26)
multiply_by_26_result = multiply_by_26.(10) # 260

multiply_by_27 = multiply_v26.(27)
multiply_by_27_result = multiply_by_27.(10) # 270

multiply_by_28 = multiply_v27.(28)
multiply_by_28_result = multiply_by_28.(10) # 280

multiply_by_29 = multiply_v28.(29)
multiply_by_29_result = multiply_by_29.(10) # 290

multiply_by_30 = multiply_v29.(30)
multiply_by_30_result = multiply_by_30.(10) # 300

multiply_by_31 = multiply_v30.(31)
multiply_by_31_result = multiply_by_31.(10) # 310

multiply_by_32 = multiply_v31.(32)
multiply_by_32_result = multiply_by_32.(10) # 320

multiply_by_33 = multiply_v32.(33)
multiply_by_33_result = multiply_by_33.(10) # 330

multiply_by_34 = multiply_v33.(34)
multiply_by_34_result = multiply_by_34.(10) # 340

multiply_by_35 = multiply_v34.(35)
multiply_by_35_result = multiply_by_35.(10) # 350

multiply_by_36 = multiply_v35.(36)
multiply_by_36_result = multiply_by_36.(10) # 360

multiply_by_37 = multiply_v36.(37)
multiply_by_37_result = multiply_by_37.(10) # 370

multiply_by_38 = multiply_v37.(38)
multiply_by_38_result = multiply_by_38.(10) # 380

multiply_by_39 = multiply_v38.(39)
multiply_by_39_result = multiply_by_39.(10) # 390

multiply_by_40 = multiply_v39.(40)
multiply_by_40_result = multiply_by_40.(10) # 400

multiply_by_41 = multiply_v40.(41)
multiply_by_41_result = multiply_by_41.(10) # 410

multiply_by_42 = multiply_v41.(42)
multiply_by_42_result = multiply_by_42.(10) # 420

multiply_by_43 = multiply_v42.(43)
multiply_by_43_result = multiply_by_43.(10) # 430

multiply_by_44 = multiply_v43.(44)
multiply_by_44_result = multiply_by_44.(10) # 440

multiply_by_45 = multiply_v44.(45)
multiply_by_45_result = multiply_by_45.(10) # 450

multiply_by_46 = multiply_v45.(46)
multiply_by_46_result = multiply_by_46.(10) # 460

multiply_by_47 = multiply_v46.(47)
multiply_by_47_result = multiply_by_47.(10) # 470

multiply_by_48 = multiply_v47.(48)
multiply_by_48_result = multiply_by_48.(10) # 480

multiply_by_49 = multiply_v48.(49)
multiply_by_49_result = multiply_by_49.(10) # 490

multiply_by_50 = multiply_v49.(50)
multiply_by_50_result = multiply_by_50.(10) # 500

multiply_by_51 = multiply_v50.(51)
multiply_by_51_result = multiply_by_51.(10) # 510

multiply_by_52 = multiply_v51.(52)
multiply_by_52_result = multiply_by_52.(10) # 520

multiply_by_53 = multiply_v52.(53)
multiply_by_53_result = multiply_by_53.(10) # 530

multiply_by_54 = multiply_v53.(54)
multiply_by_54_result = multiply_by_54.(10) # 540

multiply_by_55 = multiply_v54.(55)
multiply_by_55_result = multiply_by_55.(10) # 550

multiply_by_56 = multiply_v55.(56)
multiply_by_56_result = multiply_by_56.(10) # 560

multiply_by_57 = multiply_v56.(57)
multiply_by_57_result = multiply_by_57.(10) # 570

multiply_by_58 = multiply_v57.(58)
multiply_by_58_result = multiply_by_58.(10) # 580

multiply_by_59 = multiply_v58.(59)
multiply_by_59_result = multiply_by_59.(10) # 590

multiply_by_60 = multiply_v59.(60)
multiply_by_60_result = multiply_by_60.(10) # 600

multiply_by_61 = multiply_v60.(61)
multiply_by_61_result = multiply_by_61.(10) # 610

multiply_by_62 = multiply_v61.(62)
multiply_by_62_result = multiply_by_62.(10) # 620

multiply_by_63 = multiply_v62.(63)
multiply_by_63_result = multiply_by_63.(10) # 630

multiply_by_64 = multiply_v63.(64)
multiply_by_64_result = multiply_by_64.(10) # 640

multiply_by_65 = multiply_v64.(65)
multiply_by_65_result = multiply_by_65.(10) # 650

multiply_by_66 = multiply_v65.(66)
multiply_by_66_result = multiply_by_66.(10) # 660

multiply_by_67 = multiply_v66.(67)
multiply_by_67_result = multiply_by_67.(10) # 670

multiply_by_68 = multiply_v67.(68)
multiply_by_68_result = multiply_by_68.(10) # 680

multiply_by_69 = multiply_v68.(69)
multiply_by_69_result = multiply_by_69.(10) # 690

multiply_by_70 = multiply_v69.(70)
multiply_by_70_result = multiply_by_70.(10) # 700

multiply_by_71 = multiply_v70.(71)
multiply_by_71_result = multiply_by_71.(10) # 710

multiply_by_72 = multiply_v71.(72)
multiply_by_72_result = multiply_by_72.(10) # 720

multiply_by_73 = multiply_v72.(73)
multiply_by_73_result = multiply_by_73.(10) # 730

multiply_by_74 = multiply_v73.(74)
multiply_by_74_result = multiply_by_74.(10) # 740

multiply_by_75 = multiply_v74.(75)
multiply_by_75_result = multiply_by_75.(10) # 750

multiply_by_76 = multiply_v75.(76)
multiply_by_76_result = multiply_by_76.(10) # 760

multiply_by_77 = multiply_v76.(77)
multiply_by_77_result = multiply_by_77.(10) # 770

multiply_by_78 = multiply_v77.(78)
multiply_by_78_result = multiply_by_78.(10) # 780

multiply_by_79 = multiply_v78.(79)
multiply_by_79_result = multiply_by_79.(10) # 790

multiply_by_80 = multiply_v79.(80)
multiply_by_80_result = multiply_by_80.(10) # 800

multiply_by_81 = multiply_v80.(81)
multiply_by_81_result = multiply_by_81.(10) # 810

multiply_by_82 = multiply_v81.(82)
multiply_by_82_result = multiply_by_82.(10) # 820

multiply_by_83 = multiply_v82.(83)
multiply_by_83_result = multiply_by_83.(10) # 830

multiply_by_84 = multiply_v83.(84)
multiply_by_84_result = multiply_by_84.(10) # 840

multiply_by_85 = multiply_v84.(85)
multiply_by_85_result = multiply_by_85.(10) # 850

multiply_by_86 = multiply_v85.(86)
multiply_by_86_result = multiply_by_86.(10) # 860

multiply_by_87 = multiply_v86.(87)
multiply_by_87_result = multiply_by_87.(10) # 870

multiply_by_88 = multiply_v87.(88)
multiply_by_88_result = multiply_by_88.(10) # 880

multiply_by_89 = multiply_v88.(89)
multiply_by_89_result = multiply_by_89.(10) # 890

multiply_by_90 = multiply_v89.(90)
multiply_by_90_result = multiply_by_90.(10) # 900

multiply_by_91 = multiply_v90.(91)
multiply_by_91_result = multiply_by_91.(10) # 910

multiply_by_92 = multiply_v91.(92)
multiply_by_92_result = multiply_by_92.(10) # 920

multiply_by_93 = multiply_v92.(93)
multiply_by_93_result = multiply_by_93.(10) # 930

multiply_by_94 = multiply_v93.(94)
multiply_by_94_result = multiply_by_94.(10) # 940

multiply_by_95 = multiply_v94.(95)
multiply_by_95_result = multiply_by_95.(10) # 950

multiply_by_96 = multiply_v95.(96)
multiply_by_96_result = multiply_by_96.(10) # 960

multiply_by_97 = multiply_v96.(97)
multiply_by_97_result = multiply_by_97.(10) # 970
