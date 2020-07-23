defmodule MetadataPlugs.InfoTest do
  use ExUnit.Case
  use Plug.Test

  doctest MetadataPlugs.Info

  @path "/info"
  @env_vars ["APP_VERSION", "TEST_VAR"]

  @opts MetadataPlugs.Info.init(info_path: @path, env_vars: @env_vars)

  test "Given a list of env variables when call the info endpoint then value of the variables is returned" do
    Enum.each(@env_vars, &System.put_env(&1, "#{&1}_value"))

    expected_env_vars_response =
      @env_vars
      |> Enum.reduce(%{}, fn env_var, acc -> Map.put(acc, env_var, "#{env_var}_value") end)
      |> Jason.encode!()

    conn =
      :get
      |> conn(@path)
      |> MetadataPlugs.Info.call(@opts)

    assert conn.state == :set
    assert conn.halted
    assert conn.status == 200
    assert conn.resp_body == expected_env_vars_response
  end

  test "when the conn does not match with the plug then the conn is returned" do
    another_conn = conn(:get, "/whatever")

    conn = MetadataPlugs.Info.call(another_conn, @opts)

    assert(conn == another_conn)
  end
end
