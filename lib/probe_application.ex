defmodule ProbeApplication do
  def run(filename) do
    [mapPart | probes_part] = get_lines(filename)

    move_probes(ProbeMap.from_string(mapPart), probes_part)
    |> Enum.map(fn new_position -> Probe.to_string(new_position) end)
  end

  defp get_lines(filename) do
    File.read!(filename) |> String.split("\n")
  end

  defp move_probes(map, probes_part) do
    probes_part
    |> Enum.chunk_every(2)
    |> Enum.map(fn pair ->
      Probe.move_batch_in_map(
        Enum.at(pair, 1) |> String.graphemes() |> Enum.map(&Command.from_string/1),
        Enum.at(pair, 0) |> Probe.from_string(),
        map
      )
    end)
  end
end
