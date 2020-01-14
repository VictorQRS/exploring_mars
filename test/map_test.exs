defmodule ProbeMapTest do
  use ExUnit.Case
  doctest ProbeMap

  defp assert_map(actual, expected_x, expected_y) do
    assert actual.x == expected_x
    assert actual.y == expected_y
  end

  test "creates map from boundaries" do
    assert_map(ProbeMap.make_map(1, 2), 1, 2)
  end

  test "creates map from invalid boundaries" do
    assert_map(ProbeMap.make_map(-1, 2), 0, 0)
  end

  test "creates map from string" do
    assert_map(ProbeMap.from_string("1 2"), 1, 2)
  end

  test "creates map from invalid string" do
    assert_map(ProbeMap.from_string("-1 2"), 0, 0)
  end
end
