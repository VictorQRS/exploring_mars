defmodule Probe.MixProject do
  use Mix.Project

  def project do
    [
      app: :exploring_mars,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {App, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

defmodule App do
  use Application

  def start(_type, _args) do
    Task.start(fn ->
      [_ | probes_part] = get_lines("test.txt")
      move_probes(probes_part) |> Enum.each(fn new_position -> IO.puts Probe.to_string(new_position) end)
    end)
  end

  defp get_lines(filename) do
    File.read!(filename) |> String.split("\n")
  end

  def move_probes(probes_part) do
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
