defmodule NameCount.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      NameCount.Repo,
      # Start the Telemetry supervisor
      NameCountWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: NameCount.PubSub},
      # Start the Endpoint (http/https)
      NameCountWeb.Endpoint
      # Start a worker by calling: NameCount.Worker.start_link(arg)
      # {NameCount.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NameCount.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NameCountWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
