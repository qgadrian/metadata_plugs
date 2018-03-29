defmodule MetadataPlugs.Health do
  @moduledoc """
  Plug module that provides a health endpoint
  """

  @behaviour Plug
  import Plug.Conn

  @path "/health"

  @typedoc """
  - `:path` -- (Optional) The health endpoint path (default: `/health`).
  """
  @type opts :: [path: String.t()]

  @impl true
  @spec init(keyword()) :: keyword()
  def init(opts) do
    default_opts = [
      path: @path
    ]

    Keyword.merge(default_opts, opts)
  end

  @doc """
  Resolves a info request
  """
  @impl true
  @spec call(Plug.Conn.t(), keyword) :: Plug.Conn.t()
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
    |> send_resp(200, Poison.encode!(health_response()))
  end

  @spec health_response() :: map()
  defp health_response do
    %{status: "up"}
  end
end
