defmodule P9iWeb.LayoutView do
  use P9iWeb, :view

  def js_vendor_static_path(%Plug.Conn{private: private} = _conn, path) do
    private.phoenix_endpoint.static_path("/js/vendor" <> path)
  end
end
