defmodule CookpodWeb.PageControllerTest do
  use CookpodWeb.ConnCase

  @username 'user'
	@password 'secret'

	defp using_basic_auth(conn, username, password) do
	  header_content = "Basic " <> Base.encode64("#{username}:#{password}")
	  conn |> put_req_header("authorization", header_content)
	end

  test "GET /", %{conn: conn} do
  	conn = conn
    |> using_basic_auth(@username, @password)
    |> get("/")

    assert html_response(conn, 200) =~ "Phoenix"
  end
end
