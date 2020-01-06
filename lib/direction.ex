defmodule Direction do
  @moduledoc """
  Provides functionality for probe directions.
  """

  @doc """
  Checks if the argument is a valid direction.

  ## Parameters

    - direction: value to be evaluated if it is a direction

  ## Examples

      iex> Direction.is_direction(:north)
      true

      iex> Direction.is_direction(nil)
      false

  """
  def is_direction(value) do
    value == :north or value == :east or value == :south or value == :west
  end
end
