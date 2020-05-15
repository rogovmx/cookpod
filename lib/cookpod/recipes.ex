defmodule Cookpod.Recipes do
  @moduledoc """
  The Recipes context.
  """

  alias Cookpod.Recipes.RecipeQueries
  alias Cookpod.Recipes.RecipeStates
  alias Cookpod.Recipes.Ingredient
  alias Cookpod.Repo

  import Ecto.Query

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

  def total_recipe_calories(recipe) do
    query =
      from ingredient in Ingredient,
        join: product in assoc(ingredient, :product),
        where: ingredient.recipe_id == ^recipe.id,
        select: fragment("SUM (amount * (fats * 9 + carbs * 4 + proteins * 4)) / 100")

    Repo.one(query)
  end
end
