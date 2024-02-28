defmodule App do
    def main do
        indent_level = 0
        can_drive = true

        indent_level = if can_drive do
            IO.puts("can_drive == true")
            indent_level + 1
        else
            indent_level
        end

        IO.puts("indent_level: #{inspect(indent_level)}")
    end
end

App.main()
