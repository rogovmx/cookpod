defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  plug :put_layout, "page.html"

  def index(conn, _params) do
    render(conn, "index.html", current_user: current_user(conn))
  end

  def terms_and_conditions(conn, _params) do
    conn
    |> render("tns.html", current_user: current_user(conn))
  end

  defp current_user(conn) do
    get_session(conn, :current_user)
  end
end
