defmodule Noizu.Google.MCP.AuthTest do
  use ExUnit.Case, async: false

  alias Noizu.Google.MCP.Auth
  alias Noizu.Google.Error

  test "wrap ok passes through" do
    assert {:ok, %{a: 1}} = Auth.wrap({:ok, %{a: 1}})
  end

  test "wrap error formats Google.Error" do
    err = %Error{tag: :config, message: "missing token", body: nil}
    assert {:error, msg} = Auth.wrap({:error, err})
    assert msg =~ "config"
    assert msg =~ "missing token"
  end

  test "client fails without credentials" do
    # Clear common env for this process
    System.delete_env("GOOGLE_ACCESS_TOKEN")
    System.delete_env("GOOGLE_MARKETING_ACCESS_TOKEN")
    System.delete_env("GOOGLE_REFRESH_TOKEN")
    System.delete_env("GOOGLE_MARKETING_REFRESH_TOKEN")
    Application.put_env(:noizu_google, :access_token, nil)
    Application.put_env(:noizu_google, :refresh_token, nil)

    assert {:error, msg} = Auth.client()
    assert is_binary(msg)
  end
end
