my_fruits_in_fridge = ["apple", "mango", "orange"]

print("array length: ", my_fruits_in_fridge.size(), "\n")

my_fruits_in_fridge.each_with_index do |array_item, array_item_index|
  print(array_item_index, "\n")
end

# array length: 3
# 0
# 1
# 2
