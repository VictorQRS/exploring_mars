defmodule CommandTest do
    use ExUnit.Case
    doctest Command
  
    # Check if it is a command
    test ":forward is a command" do
      assert Command.is_command(:forward)
    end
  
    test ":left is a command" do
      assert Command.is_command(:left)
    end
  
    test ":right is a command" do
      assert Command.is_command(:right)
    end
  
    test ":foo is not a command" do
      refute Command.is_command(:foo)
    end
  
    test "nil is not a command" do
      refute Command.is_command(nil)
    end
  
    # from/to string
    test "M as string gives :forward" do
      assert Command.from_string("M") == :forward
    end
  
    test "R as string gives :right" do
      assert Command.from_string("R") == :right
    end
  
    test "L as string gives :left" do
      assert Command.from_string("L") == :left
    end
  
    test "invalid string gives nil" do
      assert Command.from_string(nil) == nil
    end
  end
  