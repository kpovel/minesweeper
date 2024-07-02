defmodule GameTest do
  use ExUnit.Case

  test "mark visited" do
    map = [
      [%{cell: :clear, visited: false}, %{cell: :mine, visited: false}],
      [%{cell: :clear, visited: false}, %{cell: :clear, visited: false}]
    ]

    updated_map = [
      [%{cell: :clear, visited: true}, %{cell: :mine, visited: false}],
      [%{cell: :clear, visited: false}, %{cell: :clear, visited: false}]
    ]

    assert Game.mark_visited(map, 0, 0) == updated_map
  end

  test "is win" do
    map = [
      [%{cell: :clear, visited: false}, %{cell: :mine, visited: false}],
      [%{cell: :clear, visited: false}, %{cell: :clear, visited: false}]
    ]

    assert Game.is_win(map) == false
    map = Game.mark_visited(map, 0, 0)
    assert Game.is_win(map) == false

    map = [
      [%{cell: :clear, visited: true}, %{cell: :mine, visited: false}],
      [%{cell: :clear, visited: true}, %{cell: :clear, visited: true}]
    ]

    assert Game.is_win(map)
  end
end
