defmodule PragstudioLiveviewCodeWeb.FlightsLive do
  use PragstudioLiveviewCodeWeb, :live_view

  alias PragstudioLiveviewCode.Flights

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        flight: "",
        flights: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Find a Flight</h1>
    <div id="search">

      <form phx-submit="flight-search">
        <input type="text" name="flight" value={@flight}
                placeholder="Flight number or airport"
                autofocus autocomplete="off"
                readonly={@loading} />

        <button type="submit">
          <img src="images/search.svg">
        </button>
      </form>

      <%= if @loading do %>
        <div class="loader">Loading...</div>
      <% end %>

      <div class="flights">
        <ul>
          <%= for flight <- @flights do %>
            <li>
              <div class="first-line">
                <div class="number">
                  Flight #<%= flight.number %>
                </div>
                <div class="origin-destination">
                  <img src="images/location.svg">
                  <%= flight.origin %> to
                  <%= flight.destination %>
                </div>
              </div>
              <div class="second-line">
                <div class="departs">
                  Departs: <%= format_time(flight.departure_time) %>
                </div>
                <div class="arrives">
                  Arrives: <%= format_time(flight.arrival_time) %>
                </div>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  defp format_time(time) do
    Timex.format!(time, "%b %d at %H:%M", :strftime)
  end

  def handle_event("flight-search", %{"flight" => flight}, socket) do
    send(self(), {:run_flight_search, flight})

    socket =
      assign(socket,
        flight: flight,
        flights: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_flight_search, flight},  socket) do
    socket =
      case Flights.search_by_number(flight) do
        [] ->
          socket
          |> put_flash(:info, "No flights matching \"#{flight}\"")
          |> assign(stores: [], loading: false)

        flights ->
          socket
          |> clear_flash()
          |> assign(flights: flights, loading: false )
      end

    {:noreply, socket}
  end
end
