defmodule Command do
    @moduledoc """
    Provides functionality for probe commands.
    """
  
    @doc """
    Checks if the argument is a valid command.
  
    ## Parameters
  
      - value: value to be evaluated if it is a command
  
    ## Examples
  
        iex> Command.is_command(:forward)
        true
  
        iex> Command.is_command(nil)
        false
  
    """
    def is_command(value) do
      value == :forward or value == :left or value == :right
    end
  
    @doc """
    Returns a command from a string and nil if its not a valid one.
  
    ## Parameters
  
      - string: string containing a command
  
    ## Examples
  
        iex> Command.from_string("M")
        :forward
  
        iex> Command.from_string(nil)
        nil
  
    """
    def from_string(string) do
      case string do
        "M" -> :forward
        "L" -> :left
        "R" -> :right
        _ -> nil
      end
    end
  end
  