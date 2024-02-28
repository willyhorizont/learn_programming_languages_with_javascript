defmodule App do
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
        Enum.with_index(anything_inner) |> Enum.each(fn {array_item, array_item_index} ->
            result = "#{result}#{pretty_json_stringify_inner(array_item, indent_inner, new_indent_level)}"
            if ((array_item_index + 1) !== length(anything_inner)) do
                result = "#{result},\n#{String.duplicate(indent_inner, new_indent_level)}"
            end
        end)
        new_indent_level = new_indent_level - 1
        "#{result}\n#{String.duplicate(indent_inner, new_indent_level)}]"
    end

    defp pretty_json_stringify_inner(anything_inner, indent_inner, indent_level) when is_map(anything_inner) and map_size(anything_inner) > 0 do
        new_indent_level = indent_level + 1
        result = "{\n#{String.duplicate(indent_inner, new_indent_level)}"
        Enum.with_index(Map.to_list(anything_inner)) |> Enum.each(fn {{object_key, object_value}, entry_index} ->
            result = "#{result}\"#{object_key}\": #{pretty_json_stringify_inner(object_value, indent_inner, new_indent_level)}"
            if ((entry_index + 1) !== map_size(anything_inner)) do
                result = "#{result},\n#{String.duplicate(indent_inner, new_indent_level)}"
            end
        end)
        new_indent_level = new_indent_level - 1
        "#{result}\n#{String.duplicate(indent_inner, new_indent_level)}}"
    end

    def pretty_json_stringify(anything \\ nil, indent \\ "    ") do
        pretty_json_stringify_inner(anything, indent, 0)
    end

    def main do
        ~S"""
        1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type
        ```javascript
        let something = 123;
        console.log("something: ", something);
        something = "foo";
        console.log("something: ", something);
        something = true;
        console.log("something: ", something);
        something = null;
        console.log("something: ", something);
        something = [1, 2, 3];
        console.log("something: ", something);
        something = { "foo": "bar" };
        console.log("something: ", something);
        ```
        """
        something = 123
        IO.puts("something: #{pretty_json_stringify(something)}")
        something = "foo"
        IO.puts("something: #{pretty_json_stringify(something)}")
        something = true
        IO.puts("something: #{pretty_json_stringify(something)}")
        something = nil
        IO.puts("something: #{pretty_json_stringify(something)}")
        something = [1, 2, 3]
        IO.puts("something: #{pretty_json_stringify(something)}")
        something = %{foo: "bar"}
        IO.puts("something: #{pretty_json_stringify(something)}")
    end
end

App.main()
