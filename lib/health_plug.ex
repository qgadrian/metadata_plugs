defmodule MetadataPlugs.Health do
  @moduledoc """
  This plug  provides a health endpoint.

  The purpose of this endpoint is send a heartbeat response when the server is
  up.


  ## Options

  The plug listens by default the `/health` endpoint. See `t:opts/0` for more
  info.

  ## Request

  The configured endpoint should be called via an `HTTP/GET` request.

  When this endpoint is called, the server responds with an `HTTP 200 OK`
  containing the following body:

  ```json
  {"status": "up"}
  ```
  """

  @behaviour Plug
  import Plug.Conn

  @path "/health"

  @typedoc """
  Plug options:

  * `path`: The health endpoint path, defaults to `/health`.
  """
  @type opts :: [path: String.t()]

  @impl true
  @spec init(Plug.opts()) :: Plug.opts()
  def init(opts) do
    default_opts = [
      path: @path
    ]

    Keyword.merge(default_opts, opts)
  end

  @doc """
  Resolves a health request.
  """
  @impl true
  @spec call(Plug.Conn.t(), Plug.opts()) :: Plug.Conn.t()
  def call(conn, opts) do
    if conn.request_path == opts[:path] and conn.method == "GET" do
      send_health(conn)
    else
      conn
    end
  end

  @spec send_health(Plug.Conn.t()) :: Plug.Conn.t()
  defp send_health(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(health_response()))
  end

  @spec health_response() :: map()
  defp health_response do
    %{status: "up"}
  end
end
