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

  @doc """
  Makes a probe if given its X and Y position, and its direction.

  ## Examples

      iex> Probe.make_probe(1, 2, :north)
      %{ pos_x: 1, pos_y: 2, direction: :north }

  """
  def from_string(string) do
    if String.match?(string, ~r/^-?\d+ -?\d+ [N|S|W|E]$/) do
      array = string |> String.split()
      make_probe(
          Enum.at(array, 0) |> String.to_integer(),
          Enum.at(array, 1) |> String.to_integer(),
          Enum.at(array, 2) |> Direction.from_string
      )
    else
      nil
    end
  end

  @doc """
  Makes a probe if given its X and Y position, and its direction.

  ## Examples

      iex> Probe.make_probe(1, 2, :north)
      %{ pos_x: 1, pos_y: 2, direction: :north }

  """
  def to_string(probe) do
    "#{probe.pos_x} #{probe.pos_y} #{Direction.to_string(probe.direction)}"
  end

  @doc """
  Rotate a probe left or right.

  ## Examples

      iex> Probe.rotate(:left, Probe.make_probe(1, 2, :north))
      %{ pos_x: 1, pos_y: 2, direction: :west }

  """
  def rotate(command, probe) do
    new_direction = Direction.rotate(command, probe.direction)

    if new_direction == nil do
      probe
    else
      make_probe(probe.pos_x, probe.pos_y, new_direction)
    end
  end

  @doc """
  Moves a probe forward on the direction it is facing.

  ## Examples

      iex> Probe.move_forward(Probe.make_probe(1, 2, :north))
      %{ pos_x: 1, pos_y: 3, direction: :north }

  """
  def move_forward(probe) do
    case probe.direction do
      :north -> make_probe(probe.pos_x, probe.pos_y + 1, probe.direction)
      :south -> make_probe(probe.pos_x, probe.pos_y - 1, probe.direction)
      :west -> make_probe(probe.pos_x - 1, probe.pos_y, probe.direction)
      :east -> make_probe(probe.pos_x + 1, probe.pos_y, probe.direction)
      _ -> probe
    end
  end
end
