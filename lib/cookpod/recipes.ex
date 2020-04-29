defmodule Cookpod.Recipes do
  @moduledoc """
  The Recipes context.
  """

  alias Cookpod.Recipes.RecipeQueries
  alias Cookpod.Recipes.RecipeStates

  def list_recipes, do: RecipeQueries.list_recipes()

  def list_drafts, do: RecipeQueries.list_drafts()

  def get_recipe!(id), do: RecipeQueries.get!(id)

  def create_recipe(attrs \\ %{}) do
    RecipeQueries.create(attrs)
  end

  def update_recipe(recipe, attrs) do
    RecipeQueries.update(recipe, attrs)
  end

  def publish_recipe(recipe), do: RecipeStates.event(recipe, :publish)

  def unpublish_recipe(recipe), do: RecipeStates.event(recipe, :unpublish)

  def delete_recipe(recipe) do
    RecipeQueries.delete(recipe)
  end

  def change_recipe(recipe) do
    RecipeQueries.change(recipe)
  end
end
