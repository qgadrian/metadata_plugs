defmodule MetadataPlugs.VersionTest do
  use ExUnit.Case
  use Plug.Test

  doctest MetadataPlugs.Version

  @path "/info"

  @opts MetadataPlugs.Version.init(info_path: @path)

  test "when call the info endpoint the application info is returned" do
    app_version = "23"
    System.put_env("APP_VERSION", app_version)

    conn =
      :get
      |> conn(@path)
      |> MetadataPlugs.Version.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"version\":\"#{app_version}\"}"
  end
end
