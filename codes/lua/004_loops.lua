function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

-- while loop

i1 = 1
while (true) do
    if (i1 == 2) then
        if (i1 >= 5) then break end
        i1 = i1 + 1
        goto next
    end
    sprint("while loop v1, i1 is ", i1)
    if (i1 >= 5) then break end
    i1 = i1 + 1
    ::next::
end

i2 = 1
while (i2 <= 5) do
    if (i2 == 2) then
        i2 = i2 + 1
        goto next
    end
    sprint("while loop v2, i2 is ", i2)
    i2 = i2 + 1
    ::next::
end

-- for loop

for i3 = 1, 5, 1 do -- start, stop, step
    if (i3 == 2) then goto next end
    sprint("for loop ascending, i3 is ", i3)
    ::next::
end

for i4 = 5, 1, -1 do -- start, stop, step
    if (i4 == 2) then goto next end
    sprint("for loop descending, i4 is ", i4)
    ::next::
end
