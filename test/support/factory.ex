defmodule Cookpod.Factory do
  use ExMachina.Ecto, repo: Cookpod.Repo

  def user_factory do
    %Cookpod.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: 'test1',
      password_confirmation: 'test1',
      password_hash: Argon2.hash_pwd_salt("test1")
    }
  end

  def recipe_factory do
    %Cookpod.Recipes.Recipe{
      name: sequence(:name, &"recipe #{&1}"),
      description: "some description"
    }
  end

  def published_recipe_factory do
    %Cookpod.Recipes.Recipe{
      name: sequence(:name, &"recipe #{&1}"),
      description: "some description",
      state: "published"
    }
  end
end
