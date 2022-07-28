defmodule PragstudioLiveviewCodeWeb.LicenseLive do
  use PragstudioLiveviewCodeWeb, :live_view

  alias PragstudioLiveviewCode.Licenses

  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 2, amount: Licenses.calculate(2))

    {:ok, socket}
  end
end
