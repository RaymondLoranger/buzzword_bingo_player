defmodule Buzzword.Bingo.Player.MixProject do
  use Mix.Project

  def project do
    [
      app: :buzzword_bingo_player,
      version: "0.1.16",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:jason, "~> 1.0"},
      {:poison, "~> 5.0"}
    ]
  end
end
