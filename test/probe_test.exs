defmodule ProbeTest do
  use ExUnit.Case
  doctest Probe

  test "greets the world" do
    assert Probe.hello() == :world
  end
end
