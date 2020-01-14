defmodule ProbeTest do
  use ExUnit.Case
  doctest Probe

  defp assert_probe(actual, status, expected_x, expected_y, expected_dir) do
    assert actual.status == status
    assert actual.pos_x == expected_x
    assert actual.pos_y == expected_y
    assert actual.direction == expected_dir
  end

  defp assert_lost_probe(actual) do
    assert actual.status == :lost
    assert actual.pos_x == -1
    assert actual.pos_y == -1
    assert actual.direction == :unknown
  end

  # create a probe
  test "probe needs direction" do
    assert_lost_probe(Probe.make_probe(1, 2, :foo))
  end

  test "map starts at 0 in x-axis" do
    assert_lost_probe(Probe.make_probe(-1, 2, :foo))
  end

  test "map starts at 0 in y-axis" do
    assert_lost_probe(Probe.make_probe(1, -2, :foo))
  end

  test "creates probe state" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(probe, :ok, 1, 2, :north)
  end

  test "creates probe state (more complete)" do
    probe = Probe.make_probe(:ok, 1, 2, :north)
    assert_probe(probe, :ok, 1, 2, :north)
  end

  test "creates lost probe if status is invalid" do
    probe = Probe.make_probe(:goo, 1, 2, :north)
    assert_lost_probe(probe)
  end

  test "creates probe state from string" do
    probe = Probe.from_string("11 2 N")
    assert_probe(probe, :ok, 11, 2, :north)
  end

  test "creates probe state from invalid string" do
    assert_lost_probe(Probe.from_string(""))
  end

  test "creates lost probe" do
    assert_lost_probe(Probe.make_lost_probe())
  end

  # to string
  test "probe state to string" do
    probe = Probe.make_probe(1, 2, :north)
    assert Probe.to_string(probe) == "1 2 N"
  end

  test "lost probe state to string" do
    probe = Probe.make_lost_probe()
    assert Probe.to_string(probe) == "lost"
  end

  # rotates probe
  test "rotating probe left rotates to the left" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:left, probe), :ok, 1, 2, :west)
  end

  test "rotating probe right rotates to the right" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:left, probe), :ok, 1, 2, :west)
  end

  test "rotating probe with a non-directional command does nothing" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.rotate(:foo, probe), :ok, 1, 2, :north)
  end

  # moves probe forward
  test "moving probe north increments Y" do
    probe = Probe.make_probe(1, 2, :north)
    assert_probe(Probe.move_forward(probe), :ok, 1, 3, :north)
  end

  test "moving probe east increments X" do
    probe = Probe.make_probe(1, 2, :east)
    assert_probe(Probe.move_forward(probe), :ok, 2, 2, :east)
  end

  test "moving probe south decrements Y" do
    probe = Probe.make_probe(1, 2, :south)
    assert_probe(Probe.move_forward(probe), :ok, 1, 1, :south)
  end

  test "moving probe west decrements X" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move_forward(probe), :ok, 0, 2, :west)
  end

  # move probe
  test "moving probe left rotates it to the left" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move(:left, probe), :ok, 1, 2, :south)
  end

  test "moving probe right rotates it to the right" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move(:right, probe), :ok, 1, 2, :north)
  end

  test "moving probe forward moves it forward" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move(:forward, probe), :ok, 0, 2, :west)
  end

  test "use a wrong command to move the probe does nothing" do
    probe = Probe.make_probe(1, 2, :west)
    assert_probe(Probe.move(:foo, probe), :ok, 1, 2, :west)
  end

  test "moving a lost probe, the probe remains lost" do
    probe = Probe.make_lost_probe()
    assert_lost_probe(Probe.move(:forward, probe))
  end

  test "move probe in batch" do
    probe = Probe.make_probe(1, 2, :west)
    batch = [:forward, :left, :forward, :left, :forward, :left, :forward, :left]
    assert_probe(Probe.move_batch(batch, probe), :ok, 1, 2, :west)
  end

  test "move lost probe in batch" do
    probe = Probe.make_lost_probe()
    batch = [:forward, :left, :forward, :left, :forward, :left, :forward, :left]
    assert_lost_probe(Probe.move_batch(batch, probe))
  end
end
