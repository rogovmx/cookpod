defmodule Cookpod.Recipes.RecipeQueries do
  @moduledoc false

  import Ecto.Query

  alias Cookpod.Repo
  alias Cookpod.Recipes.Recipe

  def list_recipes do
    Recipe
    |> Repo.all()
  end

  def get!(id), do: Repo.get!(Recipe, id)

  def create(attrs) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  def change(%Recipe{} = recipe) do
    Recipe.changeset(recipe, %{})
  end
end