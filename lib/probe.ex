defmodule Probe do
  @moduledoc """
  Provides functionality for a probe to work.
  """

  @doc """
  Makes a probe if given its status, X and Y position, and its direction. If it is an invalid probe state, it will return a lost probe.

  ## Parameters

    - status: status of the probe
    - pos_x: the position in the X-axis
    - pos_y: the position in the Y-axis
    - direction: the direction the probe is facing

  ## Examples

      iex> Probe.make_probe(:ok, 1, 2, :north)
      %{ pos_x: 1, pos_y: 2, direction: :north, status: :ok }

      iex> Probe.make_probe(:not_ok, 1, 2, :north)
      %{status: :lost, pos_x: -1, pos_y: -1, direction: :unknown}

  """
  def make_probe(status, pos_x, pos_y, direction) do
    if is_probe_safe(status, pos_x, pos_y, direction) do
      %{status: :ok, pos_x: pos_x, pos_y: pos_y, direction: direction}
    else
      make_lost_probe()
    end
  end

  defp is_probe_safe(status, pos_x, pos_y, direction) do
    status == :ok and pos_x >= 0 and pos_y >= 0 and Direction.is_direction(direction)
  end

  @doc """
  Makes a probe if given its X and Y position, and its direction. If it is an invalid probe state, it will return a lost probe.

  ## Parameters

    - pos_x: the position in the X-axis
    - pos_y: the position in the Y-axis
    - direction: the direction the probe is facing

  ## Examples

      iex> Probe.make_probe(1, 2, :north)
      %{ pos_x: 1, pos_y: 2, direction: :north, status: :ok }

  """
  def make_probe(pos_x, pos_y, direction) do
    make_probe(:ok, pos_x, pos_y, direction)
  end

  @doc """
  Makes a lost probe.

  ## Examples

      iex> Probe.make_lost_probe()
      %{status: :lost, pos_x: -1, pos_y: -1, direction: :unknown}

  """
  def make_lost_probe do
    %{status: :lost, pos_x: -1, pos_y: -1, direction: :unknown}
  end

  @doc """
  Makes a probe from a given string. If it is an invalid string, a lost probe is returned.

  ## Parameters

    - string: string to be parsed into a probe state

  ## Examples

      iex> Probe.from_string("1 2 N")
      %{ pos_x: 1, pos_y: 2, direction: :north, status: :ok }

      iex> Probe.from_string("")
      %{status: :lost, pos_x: -1, pos_y: -1, direction: :unknown}

  """
  def from_string(string) do
    if String.match?(string, ~r/^-?\d+ -?\d+ [N|S|W|E]$/) do
      array = string |> String.split()

      make_probe(
        Enum.at(array, 0) |> String.to_integer(),
        Enum.at(array, 1) |> String.to_integer(),
        Enum.at(array, 2) |> Direction.from_string()
      )
    else
      make_lost_probe()
    end
  end

  @doc """
  Transforms the probe state into a string.

  ## Parameters

    - probe: the probe state that will be transformed into a string

  ## Examples

      iex> Probe.to_string(Probe.make_probe(1, 2, :north))
      "1 2 N"

      iex> Probe.to_string(Probe.make_lost_probe())
      "lost"

  """
  def to_string(probe) do
    if probe.status == :ok do
      "#{probe.pos_x} #{probe.pos_y} #{Direction.to_string(probe.direction)}"
    else
      "lost"
    end
  end

  @doc """
  Rotate a probe left or right. If the wrong command is given, the probe does not move.

  ## Parameters

    - command: if should go :left or :right
    - probe: the probe state that will be rotated

  ## Examples

      iex> Probe.rotate(:left, Probe.make_probe(1, 2, :north))
      %{ pos_x: 1, pos_y: 2, direction: :west, status: :ok }

  """
  def rotate(command, probe) do
    make_probe(probe.status, probe.pos_x, probe.pos_y, Direction.rotate(command, probe.direction))
  end

  @doc """
  Moves a probe forward on the direction it is facing.

  ## Parameters

    - probe: the probe state that will move forward

  ## Examples

      iex> Probe.move_forward(Probe.make_probe(1, 2, :north))
      %{ pos_x: 1, pos_y: 3, direction: :north, status: :ok }

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

  @doc """
  Moves a probe according to a command (:forward, :left, :right).

  ## Parameters

    - command: the command given to the probe
    - probe: the probe state

  ## Examples

      iex> Probe.move(:forward, Probe.make_probe(1, 2, :north))
      %{ pos_x: 1, pos_y: 3, direction: :north, status: :ok }

  """
  def move(command, probe) do
    cond do
      probe.status == :lost -> probe
      command == :forward -> move_forward(probe)
      command in [:left, :right] -> rotate(command, probe)
      true -> probe
    end
  end

  @doc """
  Moves a probe according to a command (:forward, :left, :right) and a map.

  ## Parameters

    - command: the command given to the probe
    - probe: the probe state
    - map: upper and left bounds for the coordinates

  ## Examples

      iex> Probe.move_in_map(:forward, Probe.make_probe(1, 2, :north), ProbeMap.make_map(5, 5))
      %{ pos_x: 1, pos_y: 3, direction: :north, status: :ok }

  """
  def move_in_map(command, probe, map) do
    new_probe = move(command, probe)

    if new_probe.pos_x > map.x or new_probe.pos_y > map.y do
      make_lost_probe()
    else
      new_probe
    end
  end

  @doc """
  Moves a probe according to an enumerable containing commands (:forward, :left, :right).

  ## Parameters

    - commands: enumaerable containing commands to be given to the probe.
    - probe: the probe state that will move forward

  ## Examples

      iex> Probe.move_batch([:forward], Probe.make_probe(1, 2, :north))
      %{ pos_x: 1, pos_y: 3, direction: :north, status: :ok }

  """
  def move_batch(commands, probe) do
    Enum.reduce(commands, probe, fn comm, acc -> move(comm, acc) end)
  end

  @doc """
  Moves a probe according to an enumerable containing commands (:forward, :left, :right) and a map.

  ## Parameters

    - commands: enumaerable containing commands to be given to the probe.
    - probe: the probe state that will move forward
    - map: upper and left bounds for the coordinates

  ## Examples

      iex> Probe.move_batch_in_map([:forward], Probe.make_probe(1, 2, :north), ProbeMap.make_map(5, 5))
      %{ pos_x: 1, pos_y: 3, direction: :north, status: :ok }

  """
  def move_batch_in_map(commands, probe, map) do
    Enum.reduce(commands, probe, fn comm, acc -> move_in_map(comm, acc, map) end)
  end
end
