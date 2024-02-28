defmodule App do
    def pretty_json_stringify(anything \\ nil, indent \\ "    ") do
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
            if ((iteration_index + 1) !== Map.size(anything_inner)) do
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
end
