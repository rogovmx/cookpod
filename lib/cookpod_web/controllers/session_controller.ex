defmodule CookpodWeb.SessionController do
  use CookpodWeb, :controller

  alias Cookpod.User
  alias Cookpod.Repo

  def show(conn, _params) do
    current_user = get_session(conn, :current_user)
    render(conn, :show, current_user: current_user)
    # text(conn, conn.assigns[:from_any_plug])
    # json(conn, %{status: :ok})
  end

  def new(conn, _params) do
    changeset = User.new_changeset()
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    user = Repo.get_by(User, email: email)

    case Argon2.check_pass(user, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, email)
        |> redirect(to: Routes.session_path(conn, :show))

      {:error, msg} ->
        # render(conn, :new, errors: msg)
        text(conn, msg)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
