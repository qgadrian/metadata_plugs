defmodule MetadataPlugs.HealthTest do
  use ExUnit.Case
  use Plug.Test

  doctest MetadataPlugs.Health

  @opts MetadataPlugs.Health.init([])

  test "when call the health endpoint the up status is returned" do
    conn =
      :get
      |> conn("/health")
      |> MetadataPlugs.Health.call(@opts)

    # Assert the response and status
    assert conn.state == :set
    assert conn.halted
    assert conn.status == 200
    assert conn.resp_body == "{\"status\":\"up\"}"
  end

  test "when the conn does not match with the plug then the conn is returned" do
    another_conn = conn(:get, "/whatever")

    conn = MetadataPlugs.Health.call(another_conn, @opts)

    assert(conn == another_conn)
  end
end
