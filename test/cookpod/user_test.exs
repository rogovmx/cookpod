defmodule Cookpod.UserTest do
  use Cookpod.DataCase

  alias Cookpod.Users
  alias Cookpod.User

  describe "users" do
    test "get_user! returns the user with given id" do
      user = insert(:user)
      result_user = Users.get_user!(user.id)
      assert result_user.id == user.id
    end

    test "get_user_by returns the user with given attrs" do
      user = insert(:user)
      result_user = Users.get_user_by(email: user.email)
      assert result_user.id == user.id
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs =
        params_for(:user, %{
          password_confirmation: "test1",
          password: "test1",
          email: "test@test.tst"
        })

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      invalid_attrs = params_for(:user, %{password_confirmation: "test"})
      assert {:error, %Ecto.Changeset{}} = Users.create_user(invalid_attrs)
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
