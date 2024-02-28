defmodule App do
    def is_even(any_numeric_value) do
        if (rem(any_numeric_value, 2) == 0) do
            "even"
        end
        if (rem(any_numeric_value, 2) == 0) do
            "odd"
        end
    end

    def main do
        IO.puts("something: #{inspect(is_even(4))}")
    end
end

App.main()
