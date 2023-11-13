# while loop

i = 1
while true
    global i
    if (i === 2)
        i += 1
        if (i > 5)
            break
        end
        continue
    end
    println("while loop v1, i is ", i)
    i += 1
    if (i > 5)
        break
    end
end

i = 1
while (i <= 5)
    global i
    if (i === 2)
        i += 1
        continue
    end
    println("while loop v2, i is ", i)
    i += 1
end

# for loop

for i in 1:1:5
    if (i === 2)
        continue
    end
    println("for loop, i is ", i)
end
