defmodule CookpodWeb.SessionController do
  use CookpodWeb, :controller

  alias Cookpod.User
  alias Cookpod.Repo

  def show(conn, _params) do
    current_user = get_session(conn, :current_user)
    render(conn, :show, current_user: current_user)
  end

  def new(conn, _params) do
    changeset = User.new_changeset()
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => attrs}) do
    user = Repo.get_by(User, email: attrs["email"])

    case Argon2.check_pass(user, attrs["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.email)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, msg} ->
        conn
        |> put_status(422)
        |> put_flash(:error, msg)
        |> render(:new)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
