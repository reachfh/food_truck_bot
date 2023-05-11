defmodule FoodTruckBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :food_truck_bot,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      dialyzer: [
        plt_add_apps: [:mix, :ex_unit]
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.lcov": :test,
        quality: :test,
        "quality.ci": :test,
        "assets.deploy": :prod,
        deploy: :prod
      ],
      default_release: :prod,
      releases: releases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {FoodTruckBot.Application, []},
      extra_applications:
        [:logger, :runtime_tools, :gproc, :tls_certificate_check, :ssl, :eex] ++
          extra_applications(Mix.env())
    ]
  end

  defp extra_applications(:dev), do: [:tools]
  defp extra_applications(:test), do: [:tools]
  defp extra_applications(_), do: []

  defp elixirc_paths(:dev), do: ["lib", "test/support"]
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp releases do
    [
      prod: [
        include_executables_for: [:unix]
        # Don't need to tar if we are just going to copy it
        # steps: [:assemble, :tar]
      ]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.2", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.6"},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:excoveralls, "~> 0.14", only: [:dev, :test], runtime: false},
      {:finch, "~> 0.13"},
      {:floki, ">= 0.30.0", only: :test},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:junit_formatter, "~> 3.3", only: [:dev, :test], runtime: false},
      {:logger_formatter_json, "~> 0.7.0"},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:nimble_csv, "~> 1.2"},
      {:observer_cli, "~> 1.7"},
      # opentelemetry_exporter needs to be before the other
      # opentelemetry modules so it will be started first.
      {:opentelemetry_exporter, "~> 1.1"},
      {:opentelemetry, "~> 1.1"},
      {:opentelemetry_api, "~> 1.1"},
      {:opentelemetry_ecto, "~> 1.0"},
      {:opentelemetry_logger_metadata, "~> 0.1.0"},
      {:opentelemetry_phoenix, "~> 1.0"},
      {:phoenix, "~> 1.7.2"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_dashboard, "~> 0.7.2"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.18.16"},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, ">= 0.0.0"},
      {:sobelow, "~> 0.11", only: [:dev, :test], runtime: false},
      {:sched_ex, "~> 1.0"},
      {:swoosh, "~> 1.3"},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_metrics_prometheus, "~> 1.1"},
      # {:telemetry_metrics_statsd, "~> 0.6.2"},
      {:telemetry_poller, "~> 1.0"},
      {:tesla, "~> 1.5"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
      quality: [
        "format --check-formatted",
        # mix deps.clean --unlock --unused
        "deps.unlock --check-unused",
        "credo --all",
        "hex.audit",
        "deps.audit",
        "sobelow --exit",
        "dialyzer --halt-exit-status"
      ],
      "quality.ci": [
        "format --check-formatted",
        "deps.unlock --check-unused",
        "hex.audit",
        "deps.audit",
        "credo --all",
        "sobelow --exit",
        "dialyzer --halt-exit-status"
      ],
      deploy: [
        "release --overwrite",
        "cmd sudo bin/deploy-release",
        "cmd sudo bin/deploy-restart"
      ]
    ]
  end
end
