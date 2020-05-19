defmodule Cookpod.Recipes do
  @moduledoc """
  The Recipes context.
  """
  
  alias Cookpod.Recipes.RecipeStates
  alias Cookpod.Recipes.Ingredient
  alias Cookpod.Recipes.Recipe
  alias Cookpod.Repo

  import Ecto.Query

  def list_name_id do
    Repo.all(from(r in Recipe, select: {r.name, r.id}))
  end

  def get_recipe!(id), do: Repo.get!(Recipe, id)

  def get_recipe(id), do: Repo.get(Recipe, id)

  def list_all, do: Recipe |> Repo.all()

  def list_recipes do
    Recipe
    |> where(state: "published")
    |> Repo.all()
  end

  def list_drafts do
    Recipe
    |> where(state: "draft")
    |> Repo.all()
  end

  def create_recipe(attrs \\ %{}) do
    %Recipe{state: RecipeStates.initial_state()}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  def publish_recipe(recipe), do: RecipeStates.event(recipe, :publish)

  def unpublish_recipe(recipe), do: RecipeStates.event(recipe, :unpublish)

  def delete_recipe(recipe) do
    Repo.delete(recipe)
  end

  def change_recipe(recipe) do
    Recipe.changeset(recipe, %{})
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
