defmodule Game do
  alias IEx.Helpers
  use ExUnit.Case

  def launch(map) do
    map =
      Enum.map(map, fn r ->
        Enum.map(r, fn cell ->
          %{cell: cell, visited: false}
        end)
      end)

    play(map)
  end

  defp play(map) do
    print_map(map)
    {row, col} = read_move(Enum.count(map), hd(map) |> Enum.count())
    mark_visited(map, row, col) |> play()
  end

  defp read_move(rows, cols) do
    IO.write("Your move: ")
    [_, row, col, _] = IO.read(:stdio, :line) |> String.trim() |> String.split("")
    row = String.upcase(row) |> :binary.first()
    row = row - 65
    col = String.to_integer(col) - 1

    case {row, col} do
      {row, _} when row < 0 ->
        IO.puts("invalid move")
        read_move(rows, cols)

      {row, _} when row > rows ->
        IO.puts("invalid move")
        read_move(rows, cols)

      {_, col} when col < 0 ->
        IO.puts("invalid move")
        read_move(rows, cols)

      {_, col} when col > cols ->
        IO.puts("invalid move")
        read_move(rows, cols)

      {row, col} ->
        {row, col}
    end
  end

  defp print_map(map) do
    Helpers.clear()
    cols = hd(map) |> Enum.count()
    print_header(cols)
    print_body(map)
  end

  defp print_header(cols) do
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

  defp print_body(map) do
    cols = hd(map) |> Enum.count()

    row_space = Integer.to_string(cols) |> String.length()
    row_space = row_space + 2

    Enum.with_index(map, fn row, row_idx ->
      row_number = "#{[65 + row_idx]} "
      IO.write(row_number)
      leading_space = div(row_space + 1, 2)
      trailing_space = leading_space + 1

      Enum.with_index(row)
      |> Enum.map(fn {%{cell: cell, visited: visited}, col_idx} ->
        case visited do
          true ->
            case cell do
              :mine ->
                "*"

              :clear ->
                Enum.map(map, fn r ->
                  Enum.map(r, fn %{cell: cell, visited: _} -> cell end)
                end)
                |> MineMap.near_mines(row_idx, col_idx)
                |> Integer.to_string()
            end

          false ->
            " "
        end
        |> String.pad_leading(leading_space)
        |> String.pad_trailing(trailing_space)
      end)
      |> Enum.map(fn l -> l <> "|" end)
      |> IO.puts()
    end)
  end

  def mark_visited(map, row, col) do
    target_row = Enum.at(map, row)
    updated_element = Enum.at(target_row, col) |> Map.put(:visited, true)
    updated_row = List.replace_at(target_row, col, updated_element)

    List.replace_at(map, row, updated_row)
  end
end
