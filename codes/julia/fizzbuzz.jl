println("\n# FizzBuzz(n) in Julia")

fizzbuzz_v1::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    local any_number::Any = 1
    while (true)
        if (result === "")
            result = "$(any_number)"
            if (any_number >= stop_number) break end
            any_number += 1
            continue
        end
        if (((any_number % 3) === 0) && ((any_number % 5) === 0))
            result = "$(result), FizzBuzz"
            if (any_number >= stop_number) break end
            any_number += 1
            continue
        end
        if ((any_number % 3) === 0)
            result = "$(result), Fizz"
            if (any_number >= stop_number) break end
            any_number += 1
            continue
        end
        if ((any_number % 5) === 0)
            result = "$(result), Buzz"
            if (any_number >= stop_number) break end
            any_number += 1
            continue
        end
        result = "$(result), $(any_number)"
        if (any_number >= stop_number) break end
        any_number += 1
    end
    return result
end)::Any

fizzbuzz_v2::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    local any_number::Any = 1
    while (any_number <= stop_number)
        if (result === "")
            result = "$(any_number)"
            any_number += 1
            continue
        end
        if (((any_number % 3) === 0) && ((any_number % 5) === 0))
            result = "$(result), FizzBuzz"
            any_number += 1
            continue
        end
        if ((any_number % 3) === 0)
            result = "$(result), Fizz"
            any_number += 1
            continue
        end
        if ((any_number % 5) === 0)
            result = "$(result), Buzz"
            any_number += 1
            continue
        end
        result = "$(result), $(any_number)"
        any_number += 1
    end
    return result
end)::Any

fizzbuzz_v3::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    local any_number::Any = 1
    while (true)
        if (result === "")
            result = "$(any_number)"
        elseif (((any_number % 3) === 0) && ((any_number % 5) === 0))
            result = "$(result), FizzBuzz"
        elseif ((any_number % 3) === 0)
            result = "$(result), Fizz"
        elseif ((any_number % 5) === 0)
            result = "$(result), Buzz"
        else
            result = "$(result), $(any_number)"
        end
        if (any_number >= stop_number) break end
        any_number += 1
    end
    return result
end)::Any

fizzbuzz_v4::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    local any_number::Any = 1
    while (any_number <= stop_number)
        if (result === "")
            result = "$(any_number)"
        elseif (((any_number % 3) === 0) && ((any_number % 5) === 0))
            result = "$(result), FizzBuzz"
        elseif ((any_number % 3) === 0)
            result = "$(result), Fizz"
        elseif ((any_number % 5) === 0)
            result = "$(result), Buzz"
        else
            result = "$(result), $(any_number)"
        end
        any_number += 1
    end
    return result
end)::Any

fizzbuzz_v5::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    local any_number::Any = 1
    while (true)
        result = ((result === "")
            ? "$(any_number)"
            : ((((any_number % 3) === 0) && ((any_number % 5) === 0))
                ? "$(result), FizzBuzz"
                : (((any_number % 3) === 0)
                    ? "$(result), Fizz"
                    : (((any_number % 5) === 0)
                        ? "$(result), Buzz"
                        : "$(result), $(any_number)"
                    )
                )   
            )
        )
        if (any_number >= stop_number) break end
        any_number += 1
    end
    return result
end)::Any

fizzbuzz_v6::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    local any_number::Any = 1
    while (any_number <= stop_number)
        result = ((result === "")
            ? "$(any_number)"
            : ((((any_number % 3) === 0) && ((any_number % 5) === 0))
                ? "$(result), FizzBuzz"
                : (((any_number % 3) === 0)
                    ? "$(result), Fizz"
                    : (((any_number % 5) === 0)
                        ? "$(result), Buzz"
                        : "$(result), $(any_number)"
                    )
                )
            )
        )
        any_number += 1
    end
    return result
end)::Any

fizzbuzz_v7::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    local any_number::Any = 1
    while (true)
        result = ((result === "") ? "$(any_number)" : ((((any_number % 3) === 0) && ((any_number % 5) === 0)) ? "$(result), FizzBuzz" : (((any_number % 3) === 0) ? "$(result), Fizz" : (((any_number % 5) === 0) ? "$(result), Buzz" : "$(result), $(any_number)"))))
        if (any_number >= stop_number) break end
        any_number += 1
    end
    return result
end)::Any

fizzbuzz_v8::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    local any_number::Any = 1
    while (any_number <= stop_number)
        result = ((result === "") ? "$(any_number)" : ((((any_number % 3) === 0) && ((any_number % 5) === 0)) ? "$(result), FizzBuzz" : (((any_number % 3) === 0) ? "$(result), Fizz" : (((any_number % 5) === 0) ? "$(result), Buzz" : "$(result), $(any_number)"))))
        any_number += 1
    end
    return result
end)::Any

fizzbuzz_v9::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    for any_number in (1:1:stop_number) # (start:step:stop)
        if (result === "")
            result = "$(any_number)"
            continue
        end
        if (((any_number % 3) === 0) && ((any_number % 5) === 0))
            result = "$(result), FizzBuzz"
            continue
        end
        if ((any_number % 3) === 0)
            result = "$(result), Fizz"
            continue
        end
        if ((any_number % 5) === 0)
            result = "$(result), Buzz"
            continue
        end
        result = "$(result), $(any_number)"
    end
    return result
end)::Any

fizzbuzz_v10::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    for any_number in (1:1:stop_number) # (start:step:stop)
        if (result === "")
            result = "$(any_number)"
        elseif (((any_number % 3) === 0) && ((any_number % 5) === 0))
            result = "$(result), FizzBuzz"
        elseif ((any_number % 3) === 0)
            result = "$(result), Fizz"
        elseif ((any_number % 5) === 0)
            result = "$(result), Buzz"
        else
            result = "$(result), $(any_number)"
        end
    end
    return result
end)::Any

fizzbuzz_v11::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    for any_number in (1:1:stop_number) # (start:step:stop)
        result = ((result === "")
            ? "$(any_number)"
            : ((((any_number % 3) === 0) && ((any_number % 5) === 0))
                ? "$(result), FizzBuzz"
                : (((any_number % 3) === 0)
                    ? "$(result), Fizz"
                    : (((any_number % 5) === 0)
                        ? "$(result), Buzz"
                        : "$(result), $(any_number)"
                    )
                )
            )
        )
    end
    return result
end)::Any

fizzbuzz_v12::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    local result::Any = ""
    for any_number in (1:1:stop_number) # (start:step:stop)
        result = ((result === "") ? "$(any_number)" : ((((any_number % 3) === 0) && ((any_number % 5) === 0)) ? "$(result), FizzBuzz" : (((any_number % 3) === 0) ? "$(result), Fizz" : (((any_number % 5) === 0) ? "$(result), Buzz" : "$(result), $(any_number)"))))
    end
    return result
end)::Any

fizzbuzz_v13::Any = (stop_number::Any) -> (begin
    if (stop_number < 1) throw(ErrorException("Argument should be > 0")) end
    return join([((((any_number % 3) === 0) && ((any_number % 5) === 0)) ? "FizzBuzz" : (((any_number % 3) === 0) ? "Fizz" : (((any_number % 5) === 0) ? "Buzz" : any_number))) for any_number in (1:1:stop_number)], ", ")
end)::Any

println("# using fizzbuzz function \"fizzbuzz_v1\"")
println("FizzBuzz(36): $(fizzbuzz_v1(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v2\"")
println("FizzBuzz(36): $(fizzbuzz_v2(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v3\"")
println("FizzBuzz(36): $(fizzbuzz_v3(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v4\"")
println("FizzBuzz(36): $(fizzbuzz_v4(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v5\"")
println("FizzBuzz(36): $(fizzbuzz_v5(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v6\"")
println("FizzBuzz(36): $(fizzbuzz_v6(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v7\"")
println("FizzBuzz(36): $(fizzbuzz_v7(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v8\"")
println("FizzBuzz(36): $(fizzbuzz_v8(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v9\"")
println("FizzBuzz(36): $(fizzbuzz_v9(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v10\"")
println("FizzBuzz(36): $(fizzbuzz_v10(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v11\"")
println("FizzBuzz(36): $(fizzbuzz_v11(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v12\"")
println("FizzBuzz(36): $(fizzbuzz_v12(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("# using fizzbuzz function \"fizzbuzz_v13\"")
println("FizzBuzz(36): $(fizzbuzz_v13(36))")
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
