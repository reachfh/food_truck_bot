defmodule FoodTruckBot.DataSF.MobileFoodFacilityPermit do
  @moduledoc """
  """

  @spec parse_csv(binary()) :: {:ok, list(map())}
  def parse_csv(csv) do
    result =
      csv
      |> NimbleCSV.RFC4180.parse_string()
      |> Enum.map(&parse_record/1)
      |> Enum.map(&filter_empty/1)

    {:ok, result}
  end

  defp parse_record([
         location_id,
         applicant,
         facility_type,
         _cnn,
         location_description,
         address,
         _blocklot,
         _block,
         _lot,
         permit,
         status,
         food_items,
         _x,
         _y,
         latitude,
         longitude,
         _schedule,
         dayshours,
         _noi_sent,
         approved,
         _received,
         _prior_permit,
         expiration_date,
         _location,
         _fire_prevention_districts,
         _police_districts,
         _supervisor_districts,
         _zip_codes,
         _neighborhoods
       ]) do
    %{
      id: String.to_integer(location_id),
      applicant: applicant,
      facility_type: facility_type,
      location_description: location_description,
      address: address,
      permit: permit,
      status: status,
      food_items: food_items,
      latitude: parse_float(latitude),
      longitude: parse_float(longitude),
      dayshours: dayshours,
      approved: parse_datetime(approved),
      expiration_date: parse_datetime(expiration_date)
    }
  end

  def parse_datetime(""), do: nil

  def parse_datetime(value) do
    case Timex.parse(value, "{M}/{D}/{YYYY} {h12}:{m}:{s} {AM}") do
      {:ok, dt} ->
        Timex.to_datetime(dt, "America/Los_Angeles")

      _ ->
        nil
    end
  end

  def parse_float(""), do: nil

  def parse_float(value) do
    case Float.parse(value) do
      {f, _} ->
        f

      _ ->
        nil
    end
  end

  # Remove keys from map where value is empty
  defp filter_empty(m) when is_map(m) do
    Map.filter(m, &has_value/1)
  end

  defp has_value({_key, ""}), do: false
  defp has_value({_key, nil}), do: false
  defp has_value({_key, _value}), do: true
end
