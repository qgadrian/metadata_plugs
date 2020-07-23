defmodule MetadataPlugs.Info do
  @moduledoc """
  This plug provides the value of environment variables.

  ## Options

  The plug listens by default the `/info` endpoint. See `t:opts/0` for more
  info.

  ## Request

  The configured endpoint should be called via an `HTTP/GET` request.

  When this endpoint is called, the server responds with an `HTTP 200 OK`
  containing the value of all the configured environment variables. For example:

  ```json
  {"environment": "production", "version": 20190105}
  ```
  """

  @behaviour Plug
  import Plug.Conn

  @path "/info"

  @typedoc """
  Plug options:

  * `env_vars`: String list of environment variables names to get the value
  from, defaults to `[]`.
  * `path`: The health endpoint path, defaults to `/info`.
  """

  @type opts :: [
          path: String.t(),
          env_vars: list(String.t())
        ]

  @impl true
  @spec init(Plug.opts()) :: Plug.opts()
  def init(opts) do
    default_opts = [
      path: @path,
      env_vars: []
    ]

    Keyword.merge(default_opts, opts)
  end

  @doc """
  Resolves an info request.
  """
  @impl true
  @spec call(Plug.Conn.t(), Plug.opts()) :: Plug.Conn.t()
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
    |> resp(200, info_response(env_vars))
    |> halt()
  end

  @spec info_response(list(String.t())) :: String.t()
  defp info_response(env_vars) do
    env_vars
    |> Enum.reduce(%{}, fn env_var, acc ->
      env_var_value = System.get_env(env_var) || ""
      Map.put(acc, env_var, env_var_value)
    end)
    |> Jason.encode!()
  end
end
