defmodule MetadataPlugs.Version do
  @behaviour Plug
  import Plug.Conn

  @path "/info"
  @version_env_name "APP_VERSION"

  @typedoc """
  - `:path` -- (Optional) Info endpoint path (default: `/info`).
  - `:version_env_name` -- (Optional) Environment variable to get the app version from (default: `APP_VERSION`).
  """
  @type opts :: [
          path: String.t(),
          version_env_name: String.t()
        ]

  @spec init(opts :: opts) :: map
  def init(opts) do
    default_opts = [
      path: @path,
      version_env_name: @version_env_name
    ]

    Keyword.merge(default_opts, opts)
  end

  @doc """
  Resolves a health request
  """
  @spec call(Plug.Conn.t(), map) :: Plug.Conn.t()
  def call(conn, opts) do
    if conn.request_path == opts[:path] and conn.method == "GET" do
      send_info(conn)
    else
      conn
    end
  end

  @spec send_info(Plug.Conn.t()) :: Plug.Conn.t()
  defp send_info(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(info_response()))
  end

  @spec info_response() :: Map.t()
  defp info_response() do
    %{version: System.get_env(@version_env_name) || ""}
  end
end
