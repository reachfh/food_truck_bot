defmodule FoodTruckBot.Repo do
  use Ecto.Repo,
    otp_app: :food_truck_bot,
    adapter: Ecto.Adapters.Postgres
end
