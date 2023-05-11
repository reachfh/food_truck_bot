defmodule FoodTruckBot.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :applicant, :string
      add :facliity_type, :string
      add :location_description, :string
      add :address, :string
      add :permit, :string
      add :status, :string
      add :food_items, :text
      add :latitude, :float
      add :longitude, :float
      add :days, :string
      add :approved, :utc_datetime
      add :expiration_date, :utc_datetime

      timestamps()
    end
  end
end
