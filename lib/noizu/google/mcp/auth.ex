defmodule Noizu.Google.MCP.Auth do
  @moduledoc """
  Resolve a `Noizu.Google.Client` from process env / application config
  and map SDK results to MCP tool return values.
  """

  alias Noizu.Google.Client
  alias Noizu.Google.Error

  @doc """
  Build a client with a usable access token from env / app config.
  """
  @spec client() :: {:ok, Client.t()} | {:error, String.t()}
  def client do
    base =
      Client.new(
        access_token: env("GOOGLE_ACCESS_TOKEN") || env("GOOGLE_MARKETING_ACCESS_TOKEN"),
        refresh_token: env("GOOGLE_REFRESH_TOKEN") || env("GOOGLE_MARKETING_REFRESH_TOKEN"),
        client_id: env("GOOGLE_CLIENT_ID") || env("GOOGLE_MARKETING_CLIENT_ID"),
        client_secret: env("GOOGLE_CLIENT_SECRET") || env("GOOGLE_MARKETING_CLIENT_SECRET")
      )

    case Client.ensure_access_token(base) do
      {:ok, client} -> {:ok, client}
      {:error, %Error{} = err} -> {:error, format_error(err)}
    end
  end

  @doc "Map Google SDK result to MCP tool result."
  @spec wrap(term()) :: {:ok, term()} | {:error, String.t()}
  def wrap({:ok, value}), do: {:ok, value}

  def wrap({:error, %Error{} = err}), do: {:error, format_error(err)}
  def wrap({:error, reason}), do: {:error, inspect(reason)}

  def format_error(%Error{tag: tag, message: message, body: body}) do
    base = "[#{tag}] #{message || "error"}"

    case body do
      nil -> base
      b -> base <> " " <> inspect(b)
    end
  end

  defp env(name) do
    case System.get_env(name) do
      nil -> nil
      "" -> nil
      v -> v
    end
  end
end
