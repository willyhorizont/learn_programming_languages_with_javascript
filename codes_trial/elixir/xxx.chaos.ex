~S"""

var1 = 123
var2 = "#{var3}"  # exception!

"""
IO.puts("Hello, World!")
something = %{foo: "bar"}
Enum.each(something, fn {key, value} -> IO.puts("Key: #{key}, Value: #{value}") end)

something = [1, 2, 3]
IO.puts("something: #{inspect(something)}")
IO.puts("length(something): #{length(something)}")

array_item_index = 1
my_list = [1, 2, 3]

if ((array_item_index + 1) !== length(my_list)) do
  IO.puts("not last")
end
