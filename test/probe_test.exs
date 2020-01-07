defmodule ProbeTest do
  use ExUnit.Case
  doctest Probe

  defp assert_probe(actual, expected_x, expected_y, expected_dir) do
    assert actual.pos_x == expected_x
    assert actual.pos_y == expected_y
    assert actual.direction == expected_dir
  end

  # create a probe
  test "probe needs direction" do
    assert Probe.make_probe(1, 2, :foo) == nil
  end

  test "creates probe state" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(probe, 1, 2, :north)
  end

  # rotates probe
  test "rotate probe left" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:left, probe), 1, 2, :west)
  end

  test "rotate probe right" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:left, probe), 1, 2, :west)
  end

  test "rotate probe with a non-directional command" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:foo, probe), 1, 2, :north)
  end
end
