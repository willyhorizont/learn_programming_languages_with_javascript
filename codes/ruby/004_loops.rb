# while loop

i = 1
while (true)
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

# (start..step)
for i in (1..5) do
    next if (i == 2)
    print("for loop v1 ascending, i is #{i}\n")
end

# (start..step)
for i in (1..5).to_a.reverse do
    next if (i == 2)
    print("for loop v1 descending, i is #{i}\n")
end

# (start.f(stop))
for i in (1.upto(5)) do
    next if (i == 2)
    print("for loop v2 ascending, i is #{i}\n")
end

# (start.f(stop))
for i in (5.downto(1)) do
    next if (i == 2)
    print("for loop v2 descending, i is #{i}\n")
end

# start.f(stop, step)
for i in (1.step(5, 1)) do
    next if (i == 2)
    print("for loop v3 ascending, i is #{i}\n")
end

# start.f(stop, step)
for i in (5.step(1, -1)) do
    next if (i == 2)
    print("for loop v3 descending, i is #{i}\n")
end

# foreach loop

# (start..stop)
(1..5).each do |i|
    next if (i == 2)
    print("foreach loop v1 ascending, i is #{i}\n")
end

# (start..stop)
(1..5).to_a.reverse.each do |i|
    next if (i == 2)
    print("foreach loop v1 descending v1, i is #{i}\n")
end

# (start..stop)
(1..5).reverse_each do |i|
    next if (i == 2)
    print("foreach loop v1 descending v2, i is #{i}\n")
end

# (start.f(stop))
(1.upto(5)).each do |i|
    next if (i == 2)
    print("foreach loop v2 ascending, i is #{i}\n")
end

# (start.f(stop))
(5.downto(1)).each do |i|
    next if (i == 2)
    print("foreach loop v2 descending, i is #{i}\n")
end

# start.f(stop, step)
(1.step(5, 1)).each do |i|
    next if (i == 2)
    print("foreach loop v3 ascending, i is #{i}\n")
end

# start.f(stop, step)
(5.step(1, -1)).each do |i|
    next if (i == 2)
    print("foreach loop v3 descending, i is #{i}\n")
end
