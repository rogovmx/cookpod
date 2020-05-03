defmodule CookpodWeb.AuthHelpers do
  @moduledoc false

  import Plug.Conn, only: [put_session: 3, put_req_header: 3]

  import Cookpod.Factory

  def basic_auth(conn) do
    header_content = "Basic " <> Base.encode64("admin:pass")
    conn |> put_req_header("authorization", header_content)
  end

  def login_user(conn) do
    user = insert(:user)

    conn
    |> Plug.Test.init_test_session(%{})
    |> put_session(:current_user, user.email)
  end
end
