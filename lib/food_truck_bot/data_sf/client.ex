defmodule FoodTruckBot.DataSF.Client do
  @moduledoc """
  Client to fetch data from https://data.sfgov.org/
  """

  @base_url Application.compile_env(:food_truck_bot, :data_sf_url)

  require Logger

  use Tesla

  plug Tesla.Middleware.BaseUrl, @base_url

  @spec get_mobile_food_facility_permits() ::
          {:ok, list(map())} | {:error, binary() | Tesla.Env.t()}
  def get_mobile_food_facility_permits() do
    case get("/api/views/rqzj-sfat/rows.csv") do
      {:ok, %{status: 200, body: ""}} ->
        {:error, "no data"}

      {:ok, %{status: 200, body: body}} ->
        {:ok, data} = FoodTruckBot.DataSF.MobileFoodFacilityPermit.parse_csv(body)

        {:ok, data}

      {:ok, result} ->
        Logger.error("#{inspect(result)}")
        {:error, result}

      {:error, reason} = result ->
        Logger.error("#{inspect(reason)}")
        result
    end
  end
end
