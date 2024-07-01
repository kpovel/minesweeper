defmodule Minesweeper do
  @moduledoc """
  Documentation for `Minesweeper`.
  """

  def start(_type, _args) do
    {rows, cols} = {8, 10}
    map = MineMap.build(rows, cols, 10)
    # map |> MineMap.Format.print_map()
    Game.launch(map)

    Supervisor.start_link([], strategy: :one_for_one)
  end
end
