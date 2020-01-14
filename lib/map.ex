defmodule ProbeMap do
  @moduledoc """
  Provides functionality for the map the probe will be in.
  """

  @doc """
  Makes a map if given its upper and right bounds. If given invalid bounds, it will return a zeroed map.

  ## Parameters

    - max_x: the position in the X-axis
    - max_y: the position in the Y-axis

  ## Examples

      iex> ProbeMap.make_map(5, 5)
      %{ x: 5, y: 5 }

      iex> ProbeMap.make_map(-1, 5)
      %{ x: 0, y: 0 }

  """
  def make_map(max_x, max_y) do
    if max_x > 0 and max_y > 0 do
      %{x: max_x, y: max_y}
    else
      %{x: 0, y: 0}
    end
  end

  @doc """
  Makes a map from a given string. If it is an invalid string, it will return a zeroed map.

  ## Parameters

    - string: string to be parsed into a map

  ## Examples

      iex> ProbeMap.from_string("5 5")
      %{ x: 5, y: 5 }

      iex> ProbeMap.from_string("5 -1")
      %{ x: 0, y: 0 }

  """
  def from_string(string) do
    if String.match?(string, ~r/^\d+ \d+$/) do
      array = string |> String.split()

      make_map(
        Enum.at(array, 0) |> String.to_integer(),
        Enum.at(array, 1) |> String.to_integer()
      )
    else
      make_map(0, 0)
    end
  end
end
