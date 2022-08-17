defmodule PragstudioLiveviewCode.FlightsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PragstudioLiveviewCode.Flights` context.
  """

  @doc """
  Generate a flight.
  """
  def flight_fixture(attrs \\ %{}) do
    {:ok, flight} =
      attrs
      |> Enum.into(%{
        arrival_time: "some arrival_time",
        departure_time: "some departure_time",
        destination: "some destination",
        number: "some number",
        origin: "some origin"
      })
      |> PragstudioLiveviewCode.Flights.create_flight()

    flight
  end
end
