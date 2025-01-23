defmodule MetadataPlug.MixProject do
  use Mix.Project

  @version "0.3.2"

  def project do
    [
      app: :metadata_plugs,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

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

  defp deps do
    [
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},
      {:plug, "~> 1.8"},
      {:dialyxir, "~> 1.4.5", only: [:dev], runtime: false},
      {:jason, "~> 1.1"}
    ]
  end

  defp docs() do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extra_section: "README",
      formatters: ["html", "epub"],
      extras: [
        "README.md"
      ]
    ]
  end
end
