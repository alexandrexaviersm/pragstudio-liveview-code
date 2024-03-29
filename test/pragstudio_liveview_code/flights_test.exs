defmodule PragstudioLiveviewCode.FlightsTest do
  use PragstudioLiveviewCode.DataCase

  alias PragstudioLiveviewCode.Flights

  describe "flights" do
    alias PragstudioLiveviewCode.Flights.Flight

    import PragstudioLiveviewCode.FlightsFixtures

    @invalid_attrs %{arrival_time: nil, departure_time: nil, destination: nil, number: nil, origin: nil}

    test "list_flights/0 returns all flights" do
      flight = flight_fixture()
      assert Flights.list_flights() == [flight]
    end

    test "get_flight!/1 returns the flight with given id" do
      flight = flight_fixture()
      assert Flights.get_flight!(flight.id) == flight
    end

    test "create_flight/1 with valid data creates a flight" do
      valid_attrs = %{arrival_time: "some arrival_time", departure_time: "some departure_time", destination: "some destination", number: "some number", origin: "some origin"}

      assert {:ok, %Flight{} = flight} = Flights.create_flight(valid_attrs)
      assert flight.arrival_time == "some arrival_time"
      assert flight.departure_time == "some departure_time"
      assert flight.destination == "some destination"
      assert flight.number == "some number"
      assert flight.origin == "some origin"
    end

    test "create_flight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_flight(@invalid_attrs)
    end

    test "update_flight/2 with valid data updates the flight" do
      flight = flight_fixture()
      update_attrs = %{arrival_time: "some updated arrival_time", departure_time: "some updated departure_time", destination: "some updated destination", number: "some updated number", origin: "some updated origin"}

      assert {:ok, %Flight{} = flight} = Flights.update_flight(flight, update_attrs)
      assert flight.arrival_time == "some updated arrival_time"
      assert flight.departure_time == "some updated departure_time"
      assert flight.destination == "some updated destination"
      assert flight.number == "some updated number"
      assert flight.origin == "some updated origin"
    end

    test "update_flight/2 with invalid data returns error changeset" do
      flight = flight_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_flight(flight, @invalid_attrs)
      assert flight == Flights.get_flight!(flight.id)
    end

    test "delete_flight/1 deletes the flight" do
      flight = flight_fixture()
      assert {:ok, %Flight{}} = Flights.delete_flight(flight)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_flight!(flight.id) end
    end

    test "change_flight/1 returns a flight changeset" do
      flight = flight_fixture()
      assert %Ecto.Changeset{} = Flights.change_flight(flight)
    end
  end
end
