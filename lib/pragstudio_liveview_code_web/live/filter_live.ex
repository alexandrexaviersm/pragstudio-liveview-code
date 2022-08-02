defmodule PragstudioLiveviewCodeWeb.FilterLive do
  use PragstudioLiveviewCodeWeb, :live_view

  alias PragstudioLiveviewCode.Boats

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        boats: Boats.list_boats(),
        type: "",
        price: []
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Daily Boat Rentals</h1>
    <div id="filter">
      <div class="boats">
      <%= for boat <- @boats do %>
        <div class="card">
          <img src={boat.image}>
          <div class="content">
            <div class="model">
              <%= boat.model %>
            </div>
            <div class="details">
              <span class="price">
                <%= boat.price %>
              </span>
              <span class="type">
                <%= boat.type %>
              </span>
            </div>
          </div>
        </div>
      <% end %>
      </div>
    </div>
    """
  end
end
