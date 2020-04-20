defmodule CookpodWeb.SessionControllerTest do
  use CookpodWeb.ConnCase

  import Plug.Conn
  import Plug.Test

	@username 'admin'
	@password 'pass'

	defp using_basic_auth(conn, username, password) do
	  header_content = "Basic " <> Base.encode64("#{username}:#{password}")
	  conn |> put_req_header("authorization", header_content)
	end

  test "GET /sessions", %{conn: conn} do
    conn = conn
    |> using_basic_auth(@username, @password)
    |> get("/sessions")
    assert html_response(conn, 200) =~ "You are not logged in"
  end

  test "GET /sessions authenticated", %{conn: conn} do
    conn = conn
    |> using_basic_auth(@username, @password)
    |> init_test_session(%{current_user: "test-user"})
    |> get(Routes.session_path(conn, :show))
    assert html_response(conn, 200) =~ "You are logged in"
  end

  test "GET /sessions/new", %{conn: conn} do
  	conn = conn
    |> using_basic_auth(@username, @password)
    |> get("/sessions/new")
    assert html_response(conn, 200) =~ "New session"
  end


  @data %{name: "Mike", password: "abc123"}


  test "login and logout", %{conn: conn} do
  	conn = conn
  	|> using_basic_auth(@username, @password)
    login = post(conn, Routes.session_path(conn, :create, %{user: @data}))
    assert html_response(login, 302) =~ "redirected"

    session_user = get_session(login, :current_user)
    assert session_user == "Mike"

	  del = delete(login, Routes.session_path(login, :delete))
	  assert html_response(del, 302) =~ "redirected"

	  refute get_session(del, :current_user)

  end

end
