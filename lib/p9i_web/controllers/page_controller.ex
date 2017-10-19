defmodule P9iWeb.PageController do
  use P9iWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
