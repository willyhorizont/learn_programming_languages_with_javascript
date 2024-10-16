# while loop

(() -> begin
    local i::Any = 1
    while (true)
        if (i === 2)
            if (i >= 5) break end
            i += 1
            continue
        end
        println("while loop v1, i is $(i)")
        if (i >= 5) break end
        i += 1
    end
end)()

(() -> begin
    local i::Any = 1
    while (i <= 5)
        if (i === 2)
            i += 1
            continue
        end
        println("while loop v2, i is $(i)")
        i += 1
    end
end)()

# for loop

for i in (1:1:10) # (start:step:stop)
    if (i > 5) break end
    if (i === 2) continue end
    println("for loop ascending, i is $(i)")
end

for i in (10:-1:1) # (start:step:stop)
    if (i <= 5) break end
    if (i === 9) continue end
    println("for loop descending, i is $(i)")
end
