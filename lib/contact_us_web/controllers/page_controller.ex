defmodule ContactUsWeb.PageController do
  use ContactUsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
