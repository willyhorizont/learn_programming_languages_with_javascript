defmodule App do
    def main do
        something = [1, 2, 3]
        IO.puts("something: #{inspect(something)}")

        Enum.with_index(something) |> Enum.each(fn {array_item, array_item_index} ->
            IO.puts("index: #{array_item_index}, value: #{array_item}")
        end)

        something = %{foo: "bar", baz: "qux"}

        Enum.with_index(Map.to_list(something)) |> Enum.each(fn {{object_key, object_value}, entry_index} ->
            IO.puts("entry_index: #{entry_index}, object_key: #{inspect(object_key)}, object_Value: #{inspect(object_value)}")
        end)
    end
end

App.main()
