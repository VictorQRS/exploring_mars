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

  @doc """
  Rotates 90 degrees to the left or right.

  ## Parameters

    - current_direction: direction to be rotated from

  ## Examples

      iex> Direction.rotate(:left, :north)
      :west

      iex> Direction.rotate(:right, :north)
      :east

      iex> Direction.rotate_left(nil)
      nil

  """
  def rotate(command, current_direction) do
    case command do
      :left -> rotate_left(current_direction)
      :right -> rotate_right(current_direction)
      _ -> nil
    end
  end

  @doc """
  Rotates 90 degrees to the left.

  ## Parameters

    - current_direction: direction to be rotated from

  ## Examples

      iex> Direction.rotate_left(:north)
      :west

      iex> Direction.rotate_left(nil)
      nil

  """
  def rotate_left(current_direction) do
    case current_direction do
      :north -> :west
      :south -> :east
      :west -> :south
      :east -> :north
      _ -> nil
    end
  end

  @doc """
  Rotates 90 degrees to the right.

  ## Parameters

    - current_direction: direction to be rotated from

  ## Examples

      iex> Direction.rotate_right(:north)
      :east

      iex> Direction.rotate_right(nil)
      nil

  """
  def rotate_right(current_direction) do
    case current_direction do
      :north -> :east
      :south -> :west
      :west -> :north
      :east -> :south
      _ -> nil
    end
  end
end
