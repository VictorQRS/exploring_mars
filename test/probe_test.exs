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

  test "creates probe state from string" do
    probe = Probe.from_string("11 -22 N")
    assert_probe(probe, 11, -22, :north)
  end

  test "creates probe state from invalid string" do
    assert Probe.from_string("") == nil
  end

  # to string
  test "probe state to string" do
    probe = Probe.make_probe(1, 2, :north)
    assert Probe.to_string(probe) == "1 2 N"
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

  # moves probe forward
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

  # move probe
  test "moving probe left rotates it to the left" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move(:left, probe), 1, 2, :south)
  end

  test "moving probe right rotates it to the right" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move(:right, probe), 1, 2, :north)
  end

  test "moving probe forward moves it forward" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move(:forward, probe), 0, 2, :west)
  end

  test "use a wrong command to move the probe does nothing" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move(:foo, probe), 1, 2, :west)
  end

  test "move probe in batch" do
    probe = Probe.make_probe(1, 2, :west)
    batch = [:forward, :left, :forward, :left, :forward, :left, :forward, :left]
    assert_probe(Probe.move_batch(batch, probe), 1, 2, :west)
  end
end
