defmodule FoodTruckBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        # Start the Telemetry supervisor
        FoodTruckBotWeb.Telemetry,
        # Start the Ecto repository
        FoodTruckBot.Repo,
        # Start the PubSub system
        {Phoenix.PubSub, name: FoodTruckBot.PubSub},
        # Start Finch
        {Finch, name: FoodTruckBot.Finch},
        # Start the Endpoint (http/https)
        FoodTruckBotWeb.Endpoint
        # Start a worker by calling: FoodTruckBot.Worker.start_link(arg)
        # {FoodTruckBot.Worker, arg}
      ] ++ sched_jobs()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FoodTruckBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoodTruckBotWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def sched_jobs do
    [
      %{
        # Synchronize locations
        id: "sync_locations",
        start:
          {SchedEx, :run_every, [FoodTruckBot.Tasks.SyncLocations, :run, [], "5 5 0 * * * *"]}
      }
    ]
  end
end
