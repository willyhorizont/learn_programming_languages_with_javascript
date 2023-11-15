# while loop

i = 1
while true
    if (i == 2)
        i += 1
        break if (i > 5)
        next
    end
    print("while loop v1, i is #{i}\n")
    i += 1
    break if (i > 5)
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

# for loop

# start.f(stop,step)
(1.step(5, 1)).each do |i| # we can also replace `(1.step(5, 1))` with `(1..5)`, but beware that ruby can't do `(5..1)`, use (5.step(1, -1)) instead
    next if (i == 2)
    print("for loop ascending, i is #{i}\n")
end

# start.f(stop,step)
(5.step(1, -1)).each do |i|
    next if (i == 2)
    print("for loop descending, i is #{i}\n")
end
