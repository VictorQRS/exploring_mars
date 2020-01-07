defmodule Direction do
  @moduledoc """
  Provides functionality for probe directions.
  """

  @doc """
  Checks if the argument is a valid direction.

  ## Parameters

    - value: value to be evaluated if it is a direction

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
  Returns a direction from a string and nil if its not a valid one.

  ## Parameters

    - string: string containing a direction

  ## Examples

      iex> Direction.from_string("N")
      :north

      iex> Direction.from_string(nil)
      nil

  """
  def from_string(string) do
    case string do
      "N" -> :north
      "S" -> :south
      "W" -> :west
      "E" -> :east
      _ -> nil
    end
  end

  @doc """
  Transforms a direction into a string. If it is not a valid direction, an empty string shall be returned.

  ## Parameters

    - direction: value to be converted to string

  ## Examples

      iex> Direction.to_string(:north)
      "N"

      iex> Direction.to_string(nil)
      ""

  """
  def to_string(direction) do
    case direction do
      :north -> "N"
      :south -> "S"
      :west -> "W"
      :east -> "E"
      _ -> ""
    end
  end

  @doc """
  Rotates 90 degrees to the left or right. If it is not given a correct, it will not move.

  ## Parameters

    - command: if should rotate :left or :right
    - current_direction: direction to be rotated from

  ## Examples

      iex> Direction.rotate(:left, :north)
      :west

      iex> Direction.rotate(:right, :north)
      :east

      iex> Direction.rotate(nil, :north)
      :north

  """
  def rotate(command, current_direction) do
    case command do
      :left -> rotate_left(current_direction)
      :right -> rotate_right(current_direction)
      _ -> current_direction
    end
  end

  @doc """
  Rotates 90 degrees to the left. If it is not given a correct direction, nil is returned.

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
  Rotates 90 degrees to the right. If it is not given a correct direction, nil is returned.

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
