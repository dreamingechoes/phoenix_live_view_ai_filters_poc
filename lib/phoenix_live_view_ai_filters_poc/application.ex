defmodule PhoenixLiveViewAiFiltersPoc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixLiveViewAiFiltersPocWeb.Telemetry,
      PhoenixLiveViewAiFiltersPoc.Repo,
      {DNSCluster,
       query:
         Application.get_env(:phoenix_live_view_ai_filters_poc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixLiveViewAiFiltersPoc.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixLiveViewAiFiltersPoc.Finch},
      # Start a worker by calling: PhoenixLiveViewAiFiltersPoc.Worker.start_link(arg)
      # {PhoenixLiveViewAiFiltersPoc.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixLiveViewAiFiltersPocWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixLiveViewAiFiltersPoc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixLiveViewAiFiltersPocWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
