defmodule Probe do
  @moduledoc """
  Provides functionality for a probe to work.
  """

  @doc """
  Makes a probe if given its X and Y position, and its direction.

  ## Examples

      iex> Probe.make_probe(1, 2, :north)
      %{ pos_x: 1, pos_y: 2, direction: :north }

  """
  def make_probe(pos_x, pos_y, direction) do
    if Direction.is_direction(direction) do
      %{pos_x: pos_x, pos_y: pos_y, direction: direction}
    else
      nil
    end
  end
end
