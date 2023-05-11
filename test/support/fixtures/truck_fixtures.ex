defmodule FoodTruckBot.TruckFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTruckBot.Truck` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        address: "some address",
        applicant: "some applicant",
        approved: ~U[2023-05-10 18:11:00Z],
        days: "some days",
        expiration_date: ~U[2023-05-10 18:11:00Z],
        facliity_type: "some facliity_type",
        food_items: "some food_items",
        latitude: 120.5,
        location_description: "some location_description",
        longitude: 120.5,
        permit: "some permit",
        status: "some status"
      })
      |> FoodTruckBot.Truck.create_location()

    location
  end
end
