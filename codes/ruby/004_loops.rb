# while loop

i = 1
while (true)
    if (i == 2)
        break if (i >= 5)
        i += 1
        next
    end
    print("while loop v1, i is #{i}\n")
    break if (i >= 5)
    i += 1
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

for i in (1..5) do # (start..step)
    next if (i == 2)
    print("for loop v1 ascending, i is #{i}\n")
end

for i in (1..5).to_a.reverse do # (start..step)
    next if (i == 2)
    print("for loop v1 descending, i is #{i}\n")
end

for i in (1.upto(5)) do # (start.f(stop))
    next if (i == 2)
    print("for loop v2 ascending, i is #{i}\n")
end

for i in (5.downto(1)) do # (start.f(stop))
    next if (i == 2)
    print("for loop v2 descending, i is #{i}\n")
end

for i in (1.step(5, 1)) do # start.f(stop, step)
    next if (i == 2)
    print("for loop v3 ascending, i is #{i}\n")
end

for i in (5.step(1, -1)) do # start.f(stop, step)
    next if (i == 2)
    print("for loop v3 descending, i is #{i}\n")
end

# foreach loop

(1..5).each do |i| # (start..stop)
    next if (i == 2)
    print("foreach loop v1 ascending, i is #{i}\n")
end

(1..5).to_a.reverse.each do |i| # (start..stop)
    next if (i == 2)
    print("foreach loop v1 descending v1, i is #{i}\n")
end

(1..5).reverse_each do |i| # (start..stop)
    next if (i == 2)
    print("foreach loop v1 descending v2, i is #{i}\n")
end

(1.upto(5)).each do |i| # (start.f(stop))
    next if (i == 2)
    print("foreach loop v2 ascending, i is #{i}\n")
end

(5.downto(1)).each do |i| # (start.f(stop))
    next if (i == 2)
    print("foreach loop v2 descending, i is #{i}\n")
end

(1.step(5, 1)).each do |i| # start.f(stop, step)
    next if (i == 2)
    print("foreach loop v3 ascending, i is #{i}\n")
end

(5.step(1, -1)).each do |i| # start.f(stop, step)
    next if (i == 2)
    print("foreach loop v3 descending, i is #{i}\n")
end
