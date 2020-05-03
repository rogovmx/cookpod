defmodule CookpodWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use CookpodWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias CookpodWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint CookpodWeb.Endpoint

      import CookpodWeb.AuthHelpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Cookpod.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Cookpod.Repo, {:shared, self()})
    end

    # context = %{conn: Phoenix.ConnTest.build_conn()}
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

    # {:ok, context}
    {:ok, conn: conn}
  end

  defp basic_auth(conn) do
    CookpodWeb.AuthHelpers.basic_auth(conn)
  end

  defp authenticated_user(conn) do
    CookpodWeb.AuthHelpers.login_user(conn)
  end

  # defp basic_auth(context) do
  #   conn =
  #     Map.fetch!(context, :conn)
  #     |> CookpodWeb.AuthHelpers.basic_auth()

  #   %{context | conn: conn}
  # end
end
