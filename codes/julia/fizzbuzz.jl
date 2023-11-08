using Printf
using Statistics

println("\n# FizzBuzz(n) in Julia")

function fizzbuzz_v1(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    number = 1
    while true
        if (result === "")
            result = string(number)
            number += 1
            if (number > stop_number)
                break
            end
            continue
        end
        if (((number % 3) === 0) && ((number % 5) === 0))
            result = string(result, ", FizzBuzz")
            number += 1
            if (number > stop_number)
                break
            end
            continue
        end
        if ((number % 3) === 0)
            result = string(result, ", Fizz")
            number += 1
            if (number > stop_number)
                break
            end
            continue
        end
        if ((number % 5) === 0)
            result = string(result, ", Buzz")
            number += 1
            if (number > stop_number)
                break
            end
            continue
        end
        result = string(result, ", ", number)
        number += 1
        if (number > stop_number)
            break
        end
    end
    return result
end

function fizzbuzz_v2(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    number = 1
    while (number <= stop_number)
        if (result === "")
            result = string(number)
            number += 1
            continue
        end
        if (((number % 3) === 0) && ((number % 5) === 0))
            result = string(result, ", FizzBuzz")
            number += 1
            continue
        end
        if ((number % 3) === 0)
            result = string(result, ", Fizz")
            number += 1
            continue
        end
        if ((number % 5) === 0)
            result = string(result, ", Buzz")
            number += 1
            continue
        end
        result = string(result, ", ", number)
        number += 1
    end
    return result
end

function fizzbuzz_v3(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    number = 1
    while true
        if (result === "")
            result = string(number)
        elseif (((number % 3) === 0) && ((number % 5) === 0))
            result = string(result, ", FizzBuzz")
        elseif ((number % 3) === 0)
            result = string(result, ", Fizz")
        elseif ((number % 5) === 0)
            result = string(result, ", Buzz")
        else
            result = string(result, ", ", number)
        end
        number += 1
        if (number > stop_number)
            break
        end
    end
    return result
end

function fizzbuzz_v4(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    number = 1
    while (number <= stop_number)
        if (result === "")
            result = string(number)
        elseif (((number % 3) === 0) && ((number % 5) === 0))
            result = string(result, ", FizzBuzz")
        elseif ((number % 3) === 0)
            result = string(result, ", Fizz")
        elseif ((number % 5) === 0)
            result = string(result, ", Buzz")
        else
            result = string(result, ", ", number)
        end
        number += 1
    end
    return result
end

function fizzbuzz_v5(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    number = 1
    while true
        result = ((result === "")
            ? string(number)
            : ((((number % 3) === 0) && ((number % 5) === 0))
                ? string(result, ", FizzBuzz")
                : (((number % 3) === 0)
                    ? string(result, ", Fizz")
                    : (((number % 5) === 0)
                        ? string(result, ", Buzz")
                        : string(result, ", ", number)
                    )
                )   
            )
        )
        number += 1
        if (number > stop_number)
            break
        end
    end
    return result
end

function fizzbuzz_v6(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    number = 1
    while (number <= stop_number)
        result = ((result === "")
            ? string(number)
            : ((((number % 3) === 0) && ((number % 5) === 0))
                ? string(result, ", FizzBuzz")
                : (((number % 3) === 0)
                    ? string(result, ", Fizz")
                    : (((number % 5) === 0)
                        ? string(result, ", Buzz")
                        : string(result, ", ", number)
                    )
                )
            )
        )
        number += 1
    end
    return result
end

function fizzbuzz_v7(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    number = 1
    while true
        result = ((result === "") ? string(number) : ((((number % 3) === 0) && ((number % 5) === 0)) ? string(result, ", FizzBuzz") : (((number % 3) === 0) ? string(result, ", Fizz") : (((number % 5) === 0) ? string(result, ", Buzz") : string(result, ", ", number)))))
        number += 1
        if (number > stop_number)
            break
        end
    end
    return result
end

function fizzbuzz_v8(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    number = 1
    while (number <= stop_number)
        result = ((result === "") ? string(number) : ((((number % 3) === 0) && ((number % 5) === 0)) ? string(result, ", FizzBuzz") : (((number % 3) === 0) ? string(result, ", Fizz") : (((number % 5) === 0) ? string(result, ", Buzz") : string(result, ", ", number)))))
        number += 1
    end
    return result
end

function fizzbuzz_v9(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    for number in 1:stop_number
        if (result === "")
            result = string(number)
            continue
        end
        if (((number % 3) === 0) && ((number % 5) === 0))
            result = string(result, ", FizzBuzz")
            continue
        end
        if ((number % 3) === 0)
            result = string(result, ", Fizz")
            continue
        end
        if ((number % 5) === 0)
            result = string(result, ", Buzz")
            continue
        end
        result = string(result, ", ", number)
    end
    return result
end

function fizzbuzz_v10(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    for number in 1:stop_number
        if (result === "")
            result = string(number)
        elseif (((number % 3) === 0) && ((number % 5) === 0))
            result = string(result, ", FizzBuzz")
        elseif ((number % 3) === 0)
            result = string(result, ", Fizz")
        elseif ((number % 5) === 0)
            result = string(result, ", Buzz")
        else
            result = string(result, ", ", number)
        end
    end
    return result
end

function fizzbuzz_v11(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    for number in 1:stop_number
        result = ((result === "")
            ? string(number)
            : ((((number % 3) === 0) && ((number % 5) === 0))
                ? string(result, ", FizzBuzz")
                : (((number % 3) === 0)
                    ? string(result, ", Fizz")
                    : (((number % 5) === 0)
                        ? string(result, ", Buzz")
                        : string(result, ", ", number)
                    )
                )
            )
        )
    end
    return result
end

function fizzbuzz_v12(stop_number::Int)
    if (stop_number < 1) return "argument should be greater than 0" end
    result = ""
    for number in 1:stop_number
        result = ((result === "") ? string(number) : ((((number % 3) === 0) && ((number % 5) === 0)) ? string(result, ", FizzBuzz") : (((number % 3) === 0) ? string(result, ", Fizz") : (((number % 5) === 0) ? string(result, ", Buzz") : string(result, ", ", number)))))
    end
    return result
end

fizzbuzz_v13 = (stop_number::Int) -> ((stop_number < 1) ? "argument should be greater than 0" : join([((((number % 3) === 0) && ((number % 5) === 0)) ? "FizzBuzz" : (((number % 3) === 0) ? "Fizz" : (((number % 5) === 0) ? "Buzz" : number))) for number in 1:stop_number], ", "))

println("# using fizzbuzz function \"fizzbuzz_v1\"")
println("FizzBuzz(36): ", fizzbuzz_v1(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v2\"")
println("FizzBuzz(36): ", fizzbuzz_v2(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v3\"")
println("FizzBuzz(36): ", fizzbuzz_v3(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v4\"")
println("FizzBuzz(36): ", fizzbuzz_v4(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v5\"")
println("FizzBuzz(36): ", fizzbuzz_v5(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v6\"")
println("FizzBuzz(36): ", fizzbuzz_v6(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v7\"")
println("FizzBuzz(36): ", fizzbuzz_v7(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v8\"")
println("FizzBuzz(36): ", fizzbuzz_v8(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v9\"")
println("FizzBuzz(36): ", fizzbuzz_v9(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v10\"")
println("FizzBuzz(36): ", fizzbuzz_v10(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v11\"")
println("FizzBuzz(36): ", fizzbuzz_v11(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v12\"")
println("FizzBuzz(36): ", fizzbuzz_v12(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v13\"")
println("FizzBuzz(36): ", fizzbuzz_v13(36))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
