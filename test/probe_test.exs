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
  test "rotating probe left rotates to the left" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:left, probe), 1, 2, :west)
  end

  test "rotating probe right rotates to the right" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:left, probe), 1, 2, :west)
  end

  test "rotating probe with a non-directional command does nothing" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:foo, probe), 1, 2, :north)
  end

  #moves probe forward
  test "moving probe north increments Y" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.move_forward(probe), 1, 3, :north)
  end

  test "moving probe east increments X" do
    probe = Probe.make_probe(1, 2, :east)
    assert_probe(Probe.move_forward(probe), 2, 2, :east)
  end

  test "moving probe south decrements Y" do
    probe = Probe.make_probe(1, 2, :south)
    assert_probe(Probe.move_forward(probe), 1, 1, :south)
  end

  test "moving probe west decrements X" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move_forward(probe), 0, 2, :west)
  end
end
