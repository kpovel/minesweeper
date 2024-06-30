defmodule MineMap do
  use ExUnit.Case, async: true

  @doc """
    Returns a mine map
  """
  def build(rows, cols, mines)
      when is_integer(rows)
      when is_integer(cols)
      when is_integer(mines) do
    assert((rows * cols) / 2 > mines, "At least half of the cells should not be mines")

    default_map = List.duplicate(:clear, rows * cols)
    map = generate_map(rows, cols, mines, default_map)
    assert Enum.count(map, fn el -> el == :mine end) == mines
    map
  end

  def generate_map(rows, cols, remind_mines, map) do
    assert remind_mines > 0
    {row, col} = {Enum.random(0..(rows - 1)), Enum.random(0..(cols - 1))}
    target_index = cols * row + col

    case Enum.at(map, target_index) do
      :mine ->
        generate_map(rows, cols, remind_mines, map)

      :clear ->
        map = List.replace_at(map, target_index, :mine)

        case remind_mines do
          1 -> map
          remind -> generate_map(rows, cols, remind - 1, map)
        end
    end
  end
end

defmodule MineMap.Format do
  alias IEx.Helpers

  def print_map(map, rows, cols) do
    Helpers.clear()
    print_header(cols)
    print_body(map, rows, cols)
  end

  defp print_body(map, rows, cols) do
    row_space = Integer.to_string(cols) |> String.length()
    row_space = row_space + 2

    Enum.each(0..(rows - 1), fn i ->
      row_number = "#{[65 + i]} "
      IO.write(row_number)

      leading_space = div(row_space + 1, 2)
      trailing_space = leading_space + 1

      Enum.slice(map, i * cols, cols)
      |> Enum.map(fn cell ->
        case cell do
          :mine -> "X"
          :clear -> " "
        end
        |> String.pad_leading(leading_space)
        |> String.pad_trailing(trailing_space)
      end)
      |> Enum.map(fn l -> l <> "|" end)
      |> IO.puts()
    end)
  end

  defp print_header(cols) when is_number(cols) do
    row_space = Integer.to_string(cols) |> String.length()
    row_space = row_space + 2

    col_hint =
      Enum.map(1..cols, fn col ->
        num_len = Integer.to_string(col) |> String.length()
        leading_space = div(row_space - num_len + 2, 2)
        trailing_space = leading_space + 1

        header =
          String.pad_leading("#{col}", leading_space) |> String.pad_trailing(trailing_space)

        header <> "|"
      end)

    IO.puts("  #{col_hint}")
  end
end
