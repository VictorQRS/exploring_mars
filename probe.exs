defmodule ProbeExec do
    use Application
  
    def start(_type, __args) do
      Task.start(fn ->
        filename = System.argv() |> Enum.at(0)
        if filename do
          ProbeApplication.run(filename) |> Enum.each(fn new_position -> IO.puts new_position end)
        else
          IO.puts "Did you insert the probe file?"
        end
      end)
    end
  end