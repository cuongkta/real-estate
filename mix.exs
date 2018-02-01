defmodule RealEstate.Mixfile do
  use Mix.Project

  def project do
    [
      app: :real_estate,
      version: "0.1.0",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {RealEstate.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
     {:phoenix, "~> 1.3.0", override: true},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.2"},
     {:ecto, "~> 2.2", override: true},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:wallaby, "~> 0.19.1", only: :test},
     {:gettext, "~> 0.11"},
     {:poison, "~> 2.0"},
     {:httpoison, "~> 0.12"},
     {:cowboy, "~> 1.0"},
     {:timex, "~> 3.1"},
     {:nimble_csv, "~> 0.1.0"},
     {:temp, "~> 0.4"},
     {:arc, "~> 0.8.0"},
     {:coherence, "~> 0.4.0"},
     {:phoenix_html_sanitizer, "~> 1.0"},
     {:swoosh, "~> 0.5.0"}, #due to coherence SMTP
     {:gen_smtp, "~> 0.11.0"}, #due to coherence SMTP
     {:credo, "~> 0.7", only: [:dev, :test]},
     {:faker, "~> 0.8", only: [:dev, :test]},
     {:distillery, "~> 1.5", runtime: false},
     {:conform, "~> 2.5"},
     {:appsignal, "~> 1.0"},
     {:comeonin, "~> 3.0"},
     {:guardian, "~> 1.0"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
