defmodule Supermarket.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SupermarketWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:supermarket, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Supermarket.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Supermarket.Finch},
      # Start a worker by calling: Supermarket.Worker.start_link(arg)
      # {Supermarket.Worker, arg},
      # Start to serve requests, typically the last entry
      SupermarketWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Supermarket.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SupermarketWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
