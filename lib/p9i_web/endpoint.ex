defmodule P9iWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :p9i

  socket "/socket", P9iWeb.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :p9i, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Load phoenix_html library from "phoenix_html" dependency
  plug Plug.Static,
    at: "/js/vendor", from: "deps/phoenix_html/priv/static", gzip: false,
    only: ~w(phoenix_html.js)

  # Load JavaScript library from "node_modules" directory.
  plug Plug.Static,
    at: "/js/vendor", from: "node_modules", gzip: false,
    only: ~w()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_p9i_key",
    signing_salt: "Nx/0VHjl"

  plug P9iWeb.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      port = System.get_env("PORT") || raise "expected the PORT environment variable to be set"
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
