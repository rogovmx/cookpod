defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  plug :put_layout, "page.html"

  def index(conn, _params) do
    render(conn, :index, current_user: current_user(conn))
  end

  def terms_and_conditions(conn, _params) do
    conn
    |> render(:tns, current_user: current_user(conn))
  end

  defp current_user(conn) do
    get_session(conn, :current_user)
  end

  def hard_work(conn, _params) do
    id = gen_id()

    Task.async(fn ->
      Process.sleep(5000)
      CookpodWeb.Endpoint.broadcast!("demo:#{id}", "done", %{})
    end)

    render(conn, :hard_work, id: id, current_user: current_user(conn))
  end

  defp gen_id() do
    7
    |> :crypto.strong_rand_bytes()
    |> Base.encode16()
    |> String.downcase()
  end
end
