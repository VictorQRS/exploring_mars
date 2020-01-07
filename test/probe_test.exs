defmodule ProbeTest do
  use ExUnit.Case
  doctest Probe

  test "probe needs direction" do
    assert Probe.make_probe(1, 2, :foo) == nil
  end

  test "creates probe state" do
    probe = Probe.make_probe(1, 2, :north)
    assert probe.pos_x == 1
    assert probe.pos_y == 2
    assert probe.direction == :north
  end
end
