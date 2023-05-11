defmodule FoodTruckBot.Tasks.SyncLocations do
  @moduledoc """
  Refresh location data from SF gov website
  """

  # import Ecto.Query
  require Logger

  alias FoodTruckBot.Repo

  def run() do
    Application.ensure_all_started(:food_truck_bot)

    case FoodTruckBot.DataSF.Client.get_mobile_food_facility_permits() do
      {:ok, []} ->
        Logger.info("No data returned from API, skipping sync")

      {:ok, data} ->
        Repo.delete_all(Location)
        Enum.each(data, &FoodTruckBot.Truck.create_location/1)
    end
  end
end
