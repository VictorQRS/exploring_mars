defmodule ProbeExec do
    use Application
  
    def start(_type, __args) do
      Task.start(fn ->
        filename = System.argv() |> Enum.at(0)
        if filename do
          [_ | probes_part] = get_lines(filename)
          move_probes(probes_part) |> Enum.each(fn new_position -> IO.puts Probe.to_string(new_position) end)
        else
          IO.puts "Did you insert the probe file?"
        end
      end)
    end
  
    defp get_lines(filename) do
      File.read!(filename) |> String.split("\n")
    end
  
    defp move_probes(probes_part) do
      probes_part
      |> Enum.chunk_every(2)
      |> Enum.map(fn pair ->
        Probe.move_batch(
          Enum.at(pair, 1) |> String.graphemes |> Enum.map(&Command.from_string/1),
          Enum.at(pair, 0) |> Probe.from_string()
        )
      end)
    end
  end