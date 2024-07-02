#    1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |10 |
# A  X | X |   |   |   |   |   |   |   | X |
# B    | X |   |   |   | X |   | X |   |   |
# C    |   | X | X |   | X |   | X |   | X |
# D  X | X | X |   |   |   | X | X |   |   |
# E  X | X |   | X | X |   |   | X | X | X |
# F  X |   |   |   |   | X | X |   | X | X |
# G  X |   |   | X | X |   |   |   | X | X |
# H  X | X | X | X | X | X |   | X |   |   |

defmodule MinesweeperTest do
  use ExUnit.Case
  doctest Minesweeper

  @mine_map [
    [:mine, :mine, :clear, :clear, :clear, :clear, :clear, :clear, :clear, :mine],
    [:clear, :mine, :clear, :clear, :clear, :mine, :clear, :mine, :clear, :clear],
    [:clear, :clear, :mine, :mine, :clear, :mine, :clear, :mine, :clear, :mine],
    [:mine, :mine, :mine, :clear, :clear, :clear, :mine, :mine, :clear, :clear],
    [:mine, :mine, :clear, :mine, :mine, :clear, :clear, :mine, :mine, :mine],
    [:mine, :clear, :clear, :clear, :clear, :mine, :mine, :clear, :mine, :mine],
    [:mine, :clear, :clear, :mine, :mine, :clear, :clear, :clear, :mine, :mine],
    [:mine, :mine, :mine, :mine, :mine, :mine, :clear, :mine, :clear, :clear]
  ]

  test "is mine" do
    assert MineMap.is_mine(@mine_map, 0, 0)
    assert MineMap.is_mine(@mine_map, 0, 1)
    assert !MineMap.is_mine(@mine_map, 1, 0)
    assert MineMap.is_mine(@mine_map, 1, 1)
  end

  test "near mines" do
    assert MineMap.near_mines(@mine_map, 0, 0) == 2
    assert MineMap.near_mines(@mine_map, 0, 9) == 0
    assert MineMap.near_mines(@mine_map, 7, 0) == 2
    assert MineMap.near_mines(@mine_map, 7, 9) == 2

    assert MineMap.near_mines(@mine_map, 7, 1) == 3
    assert MineMap.near_mines(@mine_map, 4, 2) == 4
  end
end
