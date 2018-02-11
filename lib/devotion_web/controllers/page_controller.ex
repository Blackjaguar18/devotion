defmodule DevotionWeb.PageController do
  use DevotionWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
