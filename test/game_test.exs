defmodule GameTest do
  use ExUnit.Case

  test "mark visited" do
    map = [
      [%{cell: :empty, visited: false}, %{cell: :mine, visited: false}],
      [%{cell: :empty, visited: false}, %{cell: :empty, visited: false}]
    ]

    updated_map = [
      [%{cell: :empty, visited: true}, %{cell: :mine, visited: false}],
      [%{cell: :empty, visited: false}, %{cell: :empty, visited: false}]
    ]

    assert Game.mark_visited(map, 0, 0) == updated_map
  end
end
