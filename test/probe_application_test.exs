defmodule ProbeApplicationTest do
  use ExUnit.Case

  test "run simple" do
    assert ProbeApplication.run("examples/simple.txt") == ["1 3 N", "5 1 E"]
  end

  test "run bad start" do
    assert ProbeApplication.run("examples/bad_start.txt") == ["lost"]
  end

  test "run lost" do
    assert ProbeApplication.run("examples/lost_probe.txt") == ["lost", "lost"]
  end
end
