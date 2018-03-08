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
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"status\":\"up\"}"
  end
end
