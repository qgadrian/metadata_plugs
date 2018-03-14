defmodule MetadataPlugs.Info do
  @moduledoc """
  Plug module that provides the value of a configured list of environment variables
  """

  @behaviour Plug
  import Plug.Conn

  @path "/info"

  @typedoc """
  - `:env_vars` -- String list of environment variables names to get the value from (default: []).
  - `:path` -- (Optional) Info endpoint path (default: `/info`).
  """

  @type opts :: [
          path: String.t(),
          env_vars: list(String.t())
        ]

  @spec init(opts :: opts) :: map
  def init(opts) do
    default_opts = [
      path: @path,
      env_vars: []
    ]

    Keyword.merge(default_opts, opts)
  end

  @doc """
  Resolves a health request
  """
  @spec call(Plug.Conn.t(), map) :: Plug.Conn.t()
  def call(conn, opts) do
    if conn.request_path == opts[:path] and conn.method == "GET" do
      send_info(conn, opts[:env_vars])
    else
      conn
    end
  end

  @spec send_info(Plug.Conn.t(), list(String.t())) :: Plug.Conn.t()
  defp send_info(conn, env_vars) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, info_response(env_vars))
  end

  @spec info_response(list(String.t())) :: Map.t()
  defp info_response(env_vars) do
    env_vars
    |> Enum.reduce(%{}, fn env_var, acc ->
      env_var_value = System.get_env(env_var) || ""
      Map.put(acc, env_var, env_var_value)
    end)
    |> Poison.encode!()
  end
end
