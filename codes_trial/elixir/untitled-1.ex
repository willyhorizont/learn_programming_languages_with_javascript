defmodule App do
    def pretty_json_stringify(anything \\ nil, indent \\ "    ") do
        defp pretty_json_stringify_inner(nil, _, _), do: "undefined"
        defp pretty_json_stringify_inner("null", _, _), do: "null"
        defp pretty_json_stringify_inner("undefined", _, _), do: "undefined"
        defp pretty_json_stringify_inner(anything_inner, _, _) when is_binary(anything_inner), do: "\"#{anything_inner}\""
        defp pretty_json_stringify_inner(anything_inner, _, _) when is_number(anything_inner) or is_boolean(anything_inner), do: "#{anything_inner}"
        defp pretty_json_stringify_inner(anything_inner, _, _) when is_list(anything_inner) and length(anything_inner) === 0, do: "[]"
        defp pretty_json_stringify_inner(anything_inner, _, _) when is_map(anything_inner) and map_size(anything_inner) === 0, do: "{}"

        defp pretty_json_stringify_inner(anything_inner, indent_inner, indent_level) when is_list(anything_inner) and length(anything_inner) > 0 do
            new_indent_level = indent_level + 1
            result = "[\n#{String.duplicate(indent_inner, new_indent_level)}"
            Enum.each(anything_inner, fn array_item ->
                result = "#{result}#{pretty_json_stringify_inner(array_item, indent_inner, new_indent_level)}"
                if array_item != Enum.last(anything_inner) do
                    result = "#{result},\n#{String.duplicate(indent_inner, new_indent_level)}"
                end
            end)
            new_indent_level = new_indent_level - 1
            "#{result}\n#{String.duplicate(indent_inner, new_indent_level)}]"
        end

        defp pretty_json_stringify_inner(anything_inner, indent_inner, indent_level) when is_map(anything_inner) and map_size(anything_inner) > 0 do
            new_indent_level = indent_level + 1
            result = "{\n#{String.duplicate(indent_inner, new_indent_level)}"
            Enum.each(anything_inner, fn {object_key, object_value} ->
                result = "#{result}\"#{object_key}\": #{pretty_json_stringify_inner(object_value, indent_inner, new_indent_level)}"
                if {object_key, object_value} != Enum.last(anything_inner) do
                    result = "#{result},\n#{String.duplicate(indent_inner, new_indent_level)}"
                end
            end)
            new_indent_level = new_indent_level - 1
            "#{result}\n#{String.duplicate(indent_inner, new_indent_level)}}"
        end

        pretty_json_stringify_inner(anything, indent, 0)
    end

    def pretty_json_stringify_2(anything \\ nil, indent \\ "    ") do
        indent_level = 0

        defp pretty_json_stringify_inner(nil, _), do: "undefined"
        defp pretty_json_stringify_inner("null", _), do: "null"
        defp pretty_json_stringify_inner("undefined", _), do: "undefined"
        defp pretty_json_stringify_inner(anything_inner, _) when is_binary(anything_inner), do: "\"#{anything_inner}\""
        defp pretty_json_stringify_inner(anything_inner, _) when is_number(anything_inner) or is_boolean(anything_inner), do: "#{anything_inner}"
        defp pretty_json_stringify_inner(anything_inner, _) when is_list(anything_inner) and length(anything_inner) === 0, do: "[]"
        defp pretty_json_stringify_inner(anything_inner, _) when is_map(anything_inner) and map_size(anything_inner) === 0, do: "{}"

        defp pretty_json_stringify_inner(anything_inner, indent_inner) when is_list(anything_inner) and length(anything_inner) > 0 do
            indent_level = indent_level + 1
            result = "[\n#{String.duplicate(indent_inner, indent_level)}"
            Enum.each(anything_inner, fn array_item ->
                result = "#{result}#{pretty_json_stringify_inner(array_item, indent_inner)}"
                if array_item != Enum.last(anything_inner) do
                    result = "#{result},\n#{String.duplicate(indent_inner, indent_level)}"
                end
            end)
            indent_level = indent_level - 1
            "#{result}\n#{String.duplicate(indent_inner, indent_level)}]"
        end

        defp pretty_json_stringify_inner(anything_inner, indent_inner) when is_map(anything_inner) and map_size(anything_inner) > 0 do
            indent_level = indent_level + 1
            result = "{\n#{String.duplicate(indent_inner, indent_level)}"
            Enum.each(anything_inner, fn {object_key, object_value} ->
                result = "#{result}\"#{object_key}\": #{pretty_json_stringify_inner(object_value, indent_inner)}"
                if {object_key, object_value} != Enum.last(anything_inner) do
                    result = "#{result},\n#{String.duplicate(indent_inner, indent_level)}"
                end
            end)
            indent_level = indent_level - 1
            "#{result}\n#{String.duplicate(indent_inner, indent_level)}}"
        end

        pretty_json_stringify_inner(anything, indent)
    end

    def pretty_json_stringify_3(anything \\ nil, indent \\ "    ") do
        indent_level = 0
        pretty_json_stringify_inner = fn {anything_inner, indent_inner} ->
            if is_nil(anything_inner) do
                "undefined"
            end
            if anything_inner == "null" do
                "null"
            end
            if anything_inner == "undefined" do
                "undefined"
            end
            if is_binary(anything_inner) do
                "\"#{anything_inner}\""
            end
            if is_number(anything_inner) || is_boolean(anything_inner) do
                to_string(anything_inner)
            end
            if is_list(anything_inner) do
                indent_level = indent_level + 1
                result = "[\n#{String.duplicate(indent_inner, indent_level)}"
                Enum.each(anything_inner, fn array_item, array_item_index ->
                    result = "#{result}#{pretty_json_stringify_inner.(array_item, indent_inner)}"
                    if ((array_item_index + 1) !== length(anything_inner)) do
                        result = "#{result},\n#{String.duplicate(indent_inner, indent_level)}"
                    end
                end)
                indent_level = indent_level - 1
                result = "#{result}\n#{String.duplicate(indent_inner, indent_level)}]"
                result
            end
            if is_map(anything_inner) do
                indent_level = indent_level + 1
                result = "{\n#{String.duplicate(indent_inner, indent_level)}"
                iteration_index = 0
                Enum.each(anything_inner, fn {object_key, object_value} ->
                    result = "#{result}\"#{object_key}\": #{pretty_json_stringify_inner.(object_value, indent_inner)}"
                    if ((iteration_index + 1) !== map_size(anything_inner)) do
                        result = "#{result},\n#{String.duplicate(indent_inner, indent_level)}"
                    end
                    iteration_index = iteration_index + 1
                end)
                indent_level = indent_level - 1
                result = "#{result}\n#{String.duplicate(indent_inner, indent_level)}}"
                result
            end
            "undefined"
        end
        pretty_json_stringify_inner.(anything, indent)
    end

    def main do
        ~S"""
        1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type
        ```javascript
        let something = "foo";
        console.log("something:", something);
        something = 123;
        console.log("something:", something);
        something = true;
        console.log("something:", something);
        something = null;
        console.log("something:", something);
        something = [1, 2, 3];
        console.log("something:", something);
        something = { "foo": "bar" };
        console.log("something:", something);
        ```
        """
        something = 123
        IO.puts("something: #{inspect(something)}")
        something = "foo"
        IO.puts("something: #{inspect(something)}")
        something = true
        IO.puts("something: #{inspect(something)}")
        something = nil
        IO.puts("something: #{inspect(something)}")
        something = [1, 2, 3]
        IO.puts("something: #{inspect(something)}")
        something = %{foo: "bar"}
        IO.puts("something: #{inspect(something)}")
    end
end

App.main()
