defmodule PragstudioLiveviewCodeWeb.LicenseLive do
  use PragstudioLiveviewCodeWeb, :live_view

  alias PragstudioLiveviewCode.Licenses

  import Number.Currency

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    expiration_time = Timex.shift(Timex.now(), hours: 1)

    socket =
      assign(socket,
        seats: 3,
        amount: Licenses.calculate(3),
        expiration_time: expiration_time,
        time_remaining: time_remaining(expiration_time)
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Team License</h1>

    <p class="m-4 font-semibold text-indigo-800">
      <%= if @time_remaining > 0 do %>
        <%= format_time(@time_remaining) %> left to save 20%
      <% else %>
        Expired!
      <% end %>
    </p>

    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <img src="images/license.svg">
            <span>
              Your license is currently for
              <strong><%= @seats %></strong> <%= ngettext("seat", "seats", @seats) %>.
            </span>
          </div>

          <form phx-change="update">
            <input type="range" min="1" max="10"
                  name="seats" value={@seats}
                  phx-debounce="250" />
          </form>

          <div class="amount">
            <%= number_to_currency(@amount) %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)

    {:noreply,
     assign(socket,
       seats: seats,
       amount: Licenses.calculate(seats)
     )}
  end

  def handle_info(:tick, socket) do
    expiration_time = socket.assigns.expiration_time
    socket = assign(socket, time_remaining: time_remaining(expiration_time))
    {:noreply, socket}
  end

  defp time_remaining(expiration_time) do
    DateTime.diff(expiration_time, Timex.now())
  end

  defp format_time(time) do
    time
    |> Timex.Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end
end
