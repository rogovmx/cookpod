defmodule CookpodWeb.RegistrationTest do
  use CookpodWeb.IntegrationCase, async: true

  @moduletag basic_auth: true

  test "register with valid params", %{conn: conn} do
    get(conn, Routes.user_path(conn, :new))
    |> follow_form(%{
      user: %{
        email: "test@test.tst",
        password: "test1",
        password_confirmation: "test1"
      }
    })
    |> assert_response(
      status: 200,
      path: Routes.page_path(conn, :index),
      html: "You are logged in as test@test.tst"
    )
  end

  test "register with invalid params", %{conn: conn} do
    get(conn, Routes.user_path(conn, :new))
    |> follow_form(%{
      user: %{
        email: "test",
        password: "test1",
        password_confirmation: "test1"
      }
    })
    |> assert_response(
      status: 422,
      path: Routes.user_path(conn, :create),
      html: "Registration"
    )
  end
end
