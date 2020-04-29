defmodule Cookpod.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 4)
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_format(:email, ~r/@/)
    |> validate_length(:email, min: 5)
    |> unique_constraint(:email)
    |> encript_password()
  end

  def new_changeset() do
    changeset(%Cookpod.User{}, %{})
  end

  def encript_password(changeset) do
    case Map.fetch(changeset.changes, :password) do
      {:ok, pasword} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pasword))

      :error ->
        changeset
    end
  end
end
