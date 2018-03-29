defmodule MetadataPlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :metadata_plugs,
      version: "0.2.3",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      name: "metadata_plugs",
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Adrián Quintás"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/qgadrian/metadata_plugs"}
    ]
  end

  defp description do
    "Collection of Elixir plugs to provide metadata information"
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:cowboy, "~> 1.1"},
      {:plug, "~> 1.5"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.8", only: :test},
      {:poison, "~> 3.1"}
    ]
  end
end
