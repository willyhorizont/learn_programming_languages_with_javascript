my_fruits_in_fridge = {"apple", "mango", "orange"}

print("array length: " .. #my_fruits_in_fridge)

for array_item_index, array_item in ipairs(my_fruits_in_fridge) do
    print(array_item_index)
end

-- array length: 3
-- 1
-- 2
-- 3