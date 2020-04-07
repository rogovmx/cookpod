defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def terms_and_conditions(conn, _params) do
  	conn 
  	|> render("tns.html", h1: 'hello')
	end
end
