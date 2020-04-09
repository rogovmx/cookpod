defmodule CookpodWeb.SessionControllerTest do
  use CookpodWeb.ConnCase

  import Plug.Conn

  test "GET /sessions", %{conn: conn} do
    conn = get(conn, "/sessions")
    assert html_response(conn, 200) =~ "You are not logged in"
  end

  test "GET /sessions/new", %{conn: conn} do
    conn = get(conn, "/sessions/new")
    assert html_response(conn, 200) =~ "New session"
  end


  @data %{name: "Mike", password: "abc123"}


  test "login and logout", %{conn: conn} do
    login = post(conn, Routes.session_path(conn, :create, %{user: @data}))
    assert html_response(login, 302) =~ "redirected"

    session_user = get_session(login, :current_user)
    assert session_user == "Mike"

	  del = delete(login, Routes.session_path(login, :delete))
	  assert html_response(del, 302) =~ "redirected"

	  refute get_session(del, :current_user)

  end

end
