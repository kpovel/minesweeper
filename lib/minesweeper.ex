defmodule Minesweeper do
  @moduledoc """
  Documentation for `Minesweeper`.
  """

  def start(_type, _args) do
    {rows, cols} = {8, 10}
    MineMap.build(rows, cols, 10) |> Game.launch()

    Supervisor.start_link([], strategy: :one_for_one)
  end
end
