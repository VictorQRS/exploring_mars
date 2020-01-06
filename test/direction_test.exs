defmodule DirectionTest do
  use ExUnit.Case
  doctest Direction

  test ":north is a direction" do
    assert Direction.is_direction(:north)
  end

  test ":east is a direction" do
    assert Direction.is_direction(:east)
  end

  test ":south is a direction" do
    assert Direction.is_direction(:south)
  end

  test ":west is a direction" do
    assert Direction.is_direction(:west)
  end

  test ":foo is not a direction" do
    refute Direction.is_direction(:foo)
  end

  test "nil is not a direction" do
    refute Direction.is_direction(nil)
  end
end
