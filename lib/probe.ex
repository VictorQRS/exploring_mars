defmodule Probe do
  @moduledoc """
  Provides functionality for a probe to work.
  """

  @doc """
  Makes a probe if given its X and Y position, and its direction.

  ## Parameters

    - pos_x: the position in the X-axis
    - pos_y: the position in the Y-axis
    - direction: the direction the probe is facing

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
  Makes a probe from a given string. If it is an invalid string, nil is returned.

  ## Parameters

    - string: string to be parsed into a probe state

  ## Examples

      iex> Probe.from_string("1 2 N")
      %{ pos_x: 1, pos_y: 2, direction: :north }

      iex> Probe.from_string("")
      nil

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
  Transforms the probe state into a string.

  ## Parameters

    - probe: the probe state that will be transformed into a string

  ## Examples

      iex> Probe.to_string(Probe.make_probe(1, 2, :north))
      "1 2 N"

  """
  def to_string(probe) do
    "#{probe.pos_x} #{probe.pos_y} #{Direction.to_string(probe.direction)}"
  end

  @doc """
  Rotate a probe left or right. If the wrong command is given, the probe does not move.

  ## Parameters

    - command: if should go :left or :right
    - probe: the probe state that will be rotated

  ## Examples

      iex> Probe.rotate(:left, Probe.make_probe(1, 2, :north))
      %{ pos_x: 1, pos_y: 2, direction: :west }

  """
  def rotate(command, probe) do
    make_probe(probe.pos_x, probe.pos_y, Direction.rotate(command, probe.direction))
  end

  @doc """
  Moves a probe forward on the direction it is facing.

  ## Parameters

    - probe: the probe state that will move forward

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

  def move(command, probe) do
    case command do
      :forward -> move_forward(probe)
      c when c in [:left, :right] -> rotate(command, probe)
      _ -> probe
    end
  end

  def move_batch(commands, probe) do
    Enum.reduce(commands, probe, fn comm, acc -> move(comm, acc) end)
  end
end
