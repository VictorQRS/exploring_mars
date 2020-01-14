defmodule Mix.Tasks.Probe do
  use Mix.Task

  def run(filename) do
    if filename do
      ProbeApplication.run(filename) |> Enum.each(fn new_position -> IO.puts(new_position) end)
    else
      IO.puts("Did you insert the probe file?")
    end
  end
end
