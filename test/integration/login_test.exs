defmodule CookpodWeb.LoginTest do
  use CookpodWeb.IntegrationCase, async: true

  @moduletag basic_auth: true

  setup %{conn: conn} do
    user = insert(:user)

    %{conn: conn, user: user}
  end

  test "Login valid user", %{conn: conn, user: user} do
    get(conn, Routes.page_path(conn, :index))
    |> follow_link("Log in")
    |> follow_form(%{
      user: %{
        email: user.email,
        password: "test1"
      }
    })
    |> assert_response(
      status: 200,
      path: Routes.page_path(conn, :index),
      html: "You are logged in as #{user.email}"
    )
  end

  test "Login invalid user", %{conn: conn, user: user} do
    get(conn, Routes.page_path(conn, :index))
    |> follow_link("Log in")
    |> follow_form(%{
      user: %{
        email: user.email,
        password: "test_invalid"
      }
    })
    |> assert_response(
      status: 422,
      path: Routes.session_path(conn, :create),
      html: "invalid password"
    )
  end
end
