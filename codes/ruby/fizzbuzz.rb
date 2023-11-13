print("\n# FizzBuzz(n) in Ruby")

def fizzbuzz_v1(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    number = 1
    while true
        if (result == "")
            result = "#{number}"
            number += 1
            break if (number > stop_number)
            next
        end
        if (((number % 3) === 0) && ((number % 5) === 0))
            result = "#{result}, FizzBuzz"
            number += 1
            break if (number > stop_number)
            next
        end
        if ((number % 3) === 0)
            result = "#{result}, Fizz"
            number += 1
            break if (number > stop_number)
            next
        end
        if ((number % 5) === 0)
            result = "#{result}, Buzz"
            number += 1
            break if (number > stop_number)
            next
        end
        result = "#{result}, #{number}"
        number += 1
        break if (number > stop_number)
    end
    return result
end

def fizzbuzz_v2(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    number = 1
    while (number <= stop_number)
        if (result == "")
            result = "#{number}"
            number += 1
            next
        end
        if (((number % 3) === 0) && ((number % 5) === 0))
            result = "#{result}, FizzBuzz"
            number += 1
            next
        end
        if ((number % 3) === 0)
            result = "#{result}, Fizz"
            number += 1
            next
        end
        if ((number % 5) === 0)
            result = "#{result}, Buzz"
            number += 1
            next
        end
        result = "#{result}, #{number}"
        number += 1
    end
    return result
end

def fizzbuzz_v3(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    number = 1
    while true
        if (result == "")
            result = "#{number}"
        elsif (((number % 3) === 0) && ((number % 5) === 0))
            result = "#{result}, FizzBuzz"
        elsif ((number % 3) === 0)
            result = "#{result}, Fizz"
        elsif ((number % 5) === 0)
            result = "#{result}, Buzz"
        else
            result = "#{result}, #{number}"
        end
        number += 1
        break if (number > stop_number)
    end
    return result
end

def fizzbuzz_v4(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    number = 1
    while (number <= stop_number)
        if (result == "")
            result = "#{number}"
        elsif (((number % 3) === 0) && ((number % 5) === 0))
            result = "#{result}, FizzBuzz"
        elsif ((number % 3) === 0)
            result = "#{result}, Fizz"
        elsif ((number % 5) === 0)
            result = "#{result}, Buzz"
        else
            result = "#{result}, #{number}"
        end
        number += 1
    end
    return result
end

def fizzbuzz_v5(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    number = 1
    while true
        result = ((result == "") ? "#{number}" : ((((number % 3) === 0) && ((number % 5) === 0)) ? "#{result}, FizzBuzz" : (((number % 3) === 0) ? "#{result}, Fizz" : (((number % 5) === 0) ? "#{result}, Buzz" : "#{result}, #{number}"))))
        number += 1
        break if (number > stop_number)
    end
    return result
end

def fizzbuzz_v6(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    number = 1
    while (number <= stop_number)
        result = ((result == "") ? "#{number}" : ((((number % 3) === 0) && ((number % 5) === 0)) ? "#{result}, FizzBuzz" : (((number % 3) === 0) ? "#{result}, Fizz" : (((number % 5) === 0) ? "#{result}, Buzz" : "#{result}, #{number}"))))
        number += 1
    end
    return result
end

def fizzbuzz_v7(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    (1.step(stop_number, 1)).each do |number|
        if (result == "")
            result = "#{number}"
            next
        end
        if (((number % 3) === 0) && ((number % 5) === 0))
            result = "#{result}, FizzBuzz"
            next
        end
        if ((number % 3) === 0)
            result = "#{result}, Fizz"
            next
        end
        if ((number % 5) === 0)
            result = "#{result}, Buzz"
            next
        end
        result = "#{result}, #{number}"
    end
    return result
end

def fizzbuzz_v7(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    (1.step(stop_number, 1)).each do |number|
        if (result == "")
            result = "#{number}"
        elsif (((number % 3) === 0) && ((number % 5) === 0))
            result = "#{result}, FizzBuzz"
        elsif ((number % 3) === 0)
            result = "#{result}, Fizz"
        elsif ((number % 5) === 0)
            result = "#{result}, Buzz"
        else
            result = "#{result}, #{number}"
        end
    end
    return result
end

def fizzbuzz_v8(stop_number)
    return "argument should be a number" if (stop_number.is_a?(Numeric) == false)
    return "argument should be greater than 0" if (stop_number < 1)
    result = ""
    (1.step(stop_number, 1)).each do |number|
        result = ((result == "") ? "#{number}" : ((((number % 3) === 0) && ((number % 5) === 0)) ? "#{result}, FizzBuzz" : (((number % 3) === 0) ? "#{result}, Fizz" : (((number % 5) === 0) ? "#{result}, Buzz" : "#{result}, #{number}"))))
    end
    return result
end

fizzbuzz_v9 = ->(stop_number) { ((stop_number.is_a?(Numeric) == false) ? "argument should be a number" : ((stop_number < 1) ? "argument should be greater than 0" : (1.step(stop_number, 1)).reduce("") { |current_result, number| ((current_result == "") ? "#{number}" : ((((number % 3) === 0) && ((number % 5) === 0)) ? "#{current_result}, FizzBuzz" : (((number % 3) === 0) ? "#{current_result}, Fizz" : (((number % 5) === 0) ? "#{current_result}, Buzz" : "#{current_result}, #{number}")))) })) }

print("\n# using fizzbuzz function \"fizzbuzz_v1\"")
print("\nFizzBuzz(36): ", fizzbuzz_v1(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("\n# using fizzbuzz function \"fizzbuzz_v2\"")
print("\nFizzBuzz(36): ", fizzbuzz_v2(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("\n# using fizzbuzz function \"fizzbuzz_v3\"")
print("\nFizzBuzz(36): ", fizzbuzz_v3(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("\n# using fizzbuzz function \"fizzbuzz_v4\"")
print("\nFizzBuzz(36): ", fizzbuzz_v4(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("\n# using fizzbuzz function \"fizzbuzz_v5\"")
print("\nFizzBuzz(36): ", fizzbuzz_v5(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("\n# using fizzbuzz function \"fizzbuzz_v6\"")
print("\nFizzBuzz(36): ", fizzbuzz_v6(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("\n# using fizzbuzz function \"fizzbuzz_v7\"")
print("\nFizzBuzz(36): ", fizzbuzz_v7(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("\n# using fizzbuzz function \"fizzbuzz_v8\"")
print("\nFizzBuzz(36): ", fizzbuzz_v8(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("\n# using fizzbuzz function \"fizzbuzz_v9\"")
print("\nFizzBuzz(36): ", fizzbuzz_v9.(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
