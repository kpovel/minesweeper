defmodule Game do
  use ExUnit.Case

  def launch(map) do
    map =
      Enum.map(map, fn r ->
        Enum.map(r, fn cell ->
          %{cell: cell, visited: false}
        end)
      end)

    # mark_visited(map, 2, 2)
  end

  defp game(map) do
    # read stdin
  end

  def mark_visited(map, row, col) do
    target_row = Enum.at(map, row)
    updated_element = Enum.at(target_row, col) |> Map.put(:visited, true)
    updated_row = List.replace_at(target_row, col, updated_element)

    List.replace_at(map, row, updated_row)
  end
end
