defmodule CookpodWeb.RecipeView do
  use CookpodWeb, :view

  alias Cookpod.Recipes

  def picture_url(recipe, version \\ :original) do
    case recipe.picture do
      nil -> ""
      _ -> Recipes.Picture.url({recipe.picture.file_name, recipe}, version)
    end
  end

  def published?(recipe) do
    recipe.state == "published"
  end

  def recipe_name(id) do
    recipe = Recipes.get_recipe(id)

    case recipe do
      nil -> ""
      _ -> recipe.name
    end
  end
end
