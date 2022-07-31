defmodule PragstudioLiveviewCodeWeb.PageController do
  use PragstudioLiveviewCodeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
