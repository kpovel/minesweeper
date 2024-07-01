defmodule MineMap do
  use ExUnit.Case, async: true

  @doc """
    Returns a mine map
  """
  def build(rows, cols, mines)
      when is_integer(rows)
      when is_integer(cols)
      when is_integer(mines) do
    assert(rows * cols / 2 > mines, "At least half of the cells should not be mines")

    generate_map(rows, cols, mines)
  end

  defp generate_map(rows, cols, mines) do
    default_map = List.duplicate(:clear, rows * cols)
    map = flat_map(rows, cols, mines, default_map)

    map =
      Enum.map(0..(rows - 1), fn i ->
        Enum.slice(map, cols * i, cols)
      end)

    assert Enum.count(map) == rows

    Enum.each(map, fn r ->
      assert Enum.count(r) == cols
    end)

    map_mines =
      Enum.map(map, fn col -> Enum.count(col, fn c -> c == :mine end) end)
      |> Enum.sum()

    assert map_mines == mines

    map
  end

  defp flat_map(rows, cols, remind_mines, map) do
    assert remind_mines > 0
    {row, col} = {Enum.random(0..(rows - 1)), Enum.random(0..(cols - 1))}
    target_index = cols * row + col

    case Enum.at(map, target_index) do
      :mine ->
        flat_map(rows, cols, remind_mines, map)

      :clear ->
        map = List.replace_at(map, target_index, :mine)

        case remind_mines do
          1 -> map
          remind -> flat_map(rows, cols, remind - 1, map)
        end
    end
  end
end

defmodule MineMap.Format do
  alias IEx.Helpers

  def print_map(map) do
    Helpers.clear()
    cols = hd(map) |> Enum.count()
    print_header(cols)
    print_body(map)
  end

  defp print_body(map) do
    cols = hd(map) |> Enum.count()

    row_space = Integer.to_string(cols) |> String.length()
    row_space = row_space + 2

    Enum.with_index(map, fn row, i ->
      row_number = "#{[65 + i]} "
      IO.write(row_number)
      leading_space = div(row_space + 1, 2)
      trailing_space = leading_space + 1

      Enum.map(row, fn cell ->
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
