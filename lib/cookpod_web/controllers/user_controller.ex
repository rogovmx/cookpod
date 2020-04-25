defmodule CookpodWeb.UserController do
  use CookpodWeb, :controller

  alias Cookpod.User
  alias Cookpod.Repo

  def new(conn, _params) do
    changeset = User.new_changeset()
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => attrs}) do
    changeset = User.changeset(%User{}, attrs)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> redirect(to: Routes.session_path(conn, :new))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

end