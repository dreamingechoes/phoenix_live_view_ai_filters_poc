defmodule PhoenixLiveViewAiFiltersPoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_live_view_ai_filters_poc,
      version: "0.1.0",
      elixir: "~> 1.16",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PhoenixLiveViewAiFiltersPoc.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # --- Phoenix Framework and Core Dependencies ---
      # Main Phoenix framework
      {:phoenix, "~> 1.7.20"},
      # Ecto integration with Phoenix
      {:phoenix_ecto, "~> 4.4.3"},
      # SQL database integration with Ecto
      {:ecto_sql, "~> 3.11.1"},
      # PostgreSQL driver for Elixir
      {:postgrex, "~> 0.17.4"},

      # --- Phoenix LiveView & UI Components ---
      # HTML rendering and helpers
      {:phoenix_html, "~> 4.0.0"},
      # LiveView for real-time UI updates
      {:phoenix_live_view, "~> 0.20.9"},
      # Admin dashboard for LiveView apps
      {:phoenix_live_dashboard, "~> 0.8.6"},
      # Tailwind-based icons for UI elements
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.1",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},

      # --- Development & Debugging Tools ---
      # Auto-reloading for templates & assets in dev
      {:phoenix_live_reload, "~> 1.4.1", only: :dev},
      # JavaScript bundler
      {:esbuild, "~> 0.7.0", runtime: Mix.env() == :dev},
      # Tailwind CSS integration
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},

      # --- Testing Utilities ---
      # HTML parsing for testing Phoenix components
      {:floki, ">= 0.30.0", only: :test},

      # --- Background Processing & Email ---
      # Email library with multiple adapters
      {:swoosh, "~> 1.15.2"},
      # HTTP client used by Swoosh
      {:finch, "~> 0.16.0"},

      # --- Monitoring, Metrics & Observability ---
      # Telemetry-based app monitoring
      {:telemetry_metrics, "~> 0.6.2"},
      # Periodic system metric polling
      {:telemetry_poller, "~> 1.0.0"},

      # --- Localization & JSON Handling ---
      # i18n and localization support
      {:gettext, "~> 0.24.0"},
      # JSON parser and encoder for Elixir
      {:jason, "~> 1.4.0"},

      # --- Networking & Clustering ---
      # DNS-based clustering for distributed Elixir apps
      {:dns_cluster, "~> 0.1.1"},

      # --- Web Server ---
      # HTTP server optimized for Phoenix 1.7+
      {:bandit, "~> 1.2.0"},

      # --- AI & External APIs ---
      # OpenAI API client for AI-driven applications
      {:openai, "~> 0.6.2"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": [
        "tailwind phoenix_live_view_ai_filters_poc",
        "esbuild phoenix_live_view_ai_filters_poc"
      ],
      "assets.deploy": [
        "tailwind phoenix_live_view_ai_filters_poc --minify",
        "esbuild phoenix_live_view_ai_filters_poc --minify",
        "phx.digest"
      ]
    ]
  end
end
