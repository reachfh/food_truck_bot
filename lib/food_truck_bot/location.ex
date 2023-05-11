defmodule FoodTruckBot.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :address, :string
    field :applicant, :string
    field :approved, :utc_datetime
    field :days, :string
    field :expiration_date, :utc_datetime
    field :facliity_type, :string
    field :food_items, :string
    field :latitude, :float
    field :location_description, :string
    field :longitude, :float
    field :permit, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:applicant, :facliity_type, :location_description, :address, :permit, :status, :food_items, :latitude, :longitude, :days, :approved, :expiration_date])
    |> validate_required([:applicant, :facliity_type, :location_description, :address, :permit, :status, :food_items, :latitude, :longitude, :days, :approved, :expiration_date])
  end
end
