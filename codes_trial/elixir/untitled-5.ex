defmodule App do
    def main do
        indent_level = 0
        can_drive = true
        if can_drive == true do
            IO.puts("can_drive == true")
            indent_level = indent_level + 1
        end
        IO.puts("indent_level: #{inspect(indent_level)}")
    end
end

App.main()
