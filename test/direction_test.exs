defmodule DirectionTest do
  use ExUnit.Case
  doctest Direction

  # Check if it is a direction
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

  # from/to string
  test "N as string gives :north" do
    assert Direction.from_string("N") == :north
  end
  
  test "E as string gives :east" do
    assert Direction.from_string("E") == :east
  end
  
  test "S as string gives :south" do
    assert Direction.from_string("S") == :south
  end
  
  test "W as string gives :west" do
    assert Direction.from_string("W") == :west
  end
  
  test "invalid string gives nil" do
    assert Direction.from_string(nil) == nil
  end

  test ":north to string gives N" do
    assert Direction.to_string(nil) == ""
  end

  test ":south to string gives S" do
    assert Direction.to_string(nil) == ""
  end

  test ":west to string gives W" do
    assert Direction.to_string(nil) == ""
  end

  test ":east to string gives E" do
    assert Direction.to_string(nil) == ""
  end

  test "non-direction to string gives empty string" do
    assert Direction.to_string(nil) == ""
  end

  # Rotate right
  test "rotating right from north gives east" do
    assert Direction.rotate_right(:north) == :east
  end

  test "rotating right from east gives south" do
    assert Direction.rotate_right(:east) == :south
  end

  test "rotating right from south gives west" do
    assert Direction.rotate_right(:south) == :west
  end

  test "rotating right from west gives north" do
    assert Direction.rotate_right(:west) == :north
  end

  test "rotating right from a non-direction gives nil" do
    assert Direction.rotate_right(nil) == nil
  end

  # Rotate left
  test "rotating left from north gives west" do
    assert Direction.rotate_left(:north) == :west
  end

  test "rotating left from west gives south" do
    assert Direction.rotate_left(:west) == :south
  end

  test "rotating left from south gives east" do
    assert Direction.rotate_left(:south) == :east
  end

  test "rotating left from east gives north" do
    assert Direction.rotate_left(:east) == :north
  end

  test "rotating left from a non-direction gives nil" do
    assert Direction.rotate_left(nil) == nil
  end

  # rotating
  test "rotating left" do
    assert Direction.rotate(:left, :north) == :west
  end

  test "rotating right" do
    assert Direction.rotate(:right, :north) == :east
  end

  test "rotating non-direction" do
    assert Direction.rotate(nil, :north) == nil
  end
end
