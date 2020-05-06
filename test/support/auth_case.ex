defmodule CookpodWeb.AuthCase do
  @moduledoc """
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      alias CookpodWeb.Router.Helpers, as: Routes

      @endpoint CookpodWeb.Endpoint

      import CookpodWeb.AuthHelpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Cookpod.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Cookpod.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn()

    conn =
      case tags[:basic_auth] do
        true -> basic_auth(conn)
        _ -> conn
      end

    conn =
      case tags[:authenticated_user] do
        true -> authenticated_user(conn)
        _ -> conn
      end

    {:ok, conn: conn}
  end

  defp basic_auth(conn) do
    CookpodWeb.AuthHelpers.basic_auth(conn)
  end

  defp authenticated_user(conn) do
    CookpodWeb.AuthHelpers.login_user(conn)
  end
end
