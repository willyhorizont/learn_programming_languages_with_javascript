i = 1
while true
    if (i == 2)
        i += 1
        if (i > 5)
            break
        end
        next
    end
    print("while loop v1, i is #{i}\n")
    i += 1
    if (i > 5)
        break
    end
end

i = 1
while (i <= 5)
    if (i == 2)
        i += 1
        next
    end
    print("while loop v2, i is #{i}\n")
    i += 1
end
