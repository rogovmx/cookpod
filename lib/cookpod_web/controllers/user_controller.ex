defmodule CookpodWeb.UserController do
  use CookpodWeb, :controller

  alias Cookpod.User
  alias Cookpod.Users

  def new(conn, _params) do
    changeset = User.new_changeset()
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => attrs}) do
    case Users.create_user(attrs) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.email)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:new, changeset: changeset)
    end
  end
end
