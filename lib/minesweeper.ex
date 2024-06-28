defmodule Minesweeper do
  @moduledoc """
  Documentation for `Minesweeper`.
  """

  def start(_type, _args) do
    _map = MineMap.build(8, 10, 10)

    Supervisor.start_link([], strategy: :one_for_one)
  end
end
