defmodule FoodTruckBot.TruckTest do
  use FoodTruckBot.DataCase

  alias FoodTruckBot.Truck

  describe "locations" do
    alias FoodTruckBot.Truck.Location

    import FoodTruckBot.TruckFixtures

    @invalid_attrs %{
      address: nil,
      applicant: nil,
      approved: nil,
      days: nil,
      expiration_date: nil,
      facliity_type: nil,
      food_items: nil,
      latitude: nil,
      location_description: nil,
      longitude: nil,
      permit: nil,
      status: nil
    }

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Truck.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Truck.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{
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
      }

      assert {:ok, %Location{} = location} = Truck.create_location(valid_attrs)
      assert location.address == "some address"
      assert location.applicant == "some applicant"
      assert location.approved == ~U[2023-05-10 18:11:00Z]
      assert location.days == "some days"
      assert location.expiration_date == ~U[2023-05-10 18:11:00Z]
      assert location.facliity_type == "some facliity_type"
      assert location.food_items == "some food_items"
      assert location.latitude == 120.5
      assert location.location_description == "some location_description"
      assert location.longitude == 120.5
      assert location.permit == "some permit"
      assert location.status == "some status"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Truck.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()

      update_attrs = %{
        address: "some updated address",
        applicant: "some updated applicant",
        approved: ~U[2023-05-11 18:11:00Z],
        days: "some updated days",
        expiration_date: ~U[2023-05-11 18:11:00Z],
        facliity_type: "some updated facliity_type",
        food_items: "some updated food_items",
        latitude: 456.7,
        location_description: "some updated location_description",
        longitude: 456.7,
        permit: "some updated permit",
        status: "some updated status"
      }

      assert {:ok, %Location{} = location} = Truck.update_location(location, update_attrs)
      assert location.address == "some updated address"
      assert location.applicant == "some updated applicant"
      assert location.approved == ~U[2023-05-11 18:11:00Z]
      assert location.days == "some updated days"
      assert location.expiration_date == ~U[2023-05-11 18:11:00Z]
      assert location.facliity_type == "some updated facliity_type"
      assert location.food_items == "some updated food_items"
      assert location.latitude == 456.7
      assert location.location_description == "some updated location_description"
      assert location.longitude == 456.7
      assert location.permit == "some updated permit"
      assert location.status == "some updated status"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Truck.update_location(location, @invalid_attrs)
      assert location == Truck.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Truck.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Truck.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Truck.change_location(location)
    end
  end
end
