defmodule MineMap do
  use ExUnit.Case, async: true

  @doc """
    Returns a mine map
  """
  def build(rows, cols, mines)
      when is_integer(rows)
      when is_integer(cols)
      when is_integer(mines) do
    assert rows * cols > mines

    default_map = List.duplicate(:clear, rows * cols)
    map = generate_map(rows, cols, mines, default_map)
    assert Enum.count(map, fn el -> el == :mine end) == mines
    map
  end

  def generate_map(rows, cols, remind_mines, map) do
    assert remind_mines > 0
    {row, col} = {Enum.random(0..(rows - 1)), Enum.random(0..(cols - 1))}
    target_index = row * col + col

    case Enum.at(map, target_index) do
      :mine ->
        generate_map(rows, cols, remind_mines, map)

      :clear ->
        map = List.replace_at(map, row * col + col, :mine)

        case remind_mines do
          1 -> map
          remind -> generate_map(rows, cols, remind - 1, map)
        end
    end
  end
end
