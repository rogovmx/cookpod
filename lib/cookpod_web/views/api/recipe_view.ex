defmodule CookpodWeb.Api.RecipeView do
  use CookpodWeb, :view

  def render("index.json", %{recipes: recipes}) do
    render_many(recipes, __MODULE__, "recipe.json")
  end

  def render("show.json", %{recipe: recipe}) do
    render_one(recipe, __MODULE__, "recipe.json")
  end

  def render("recipe.json", %{recipe: recipe}) do
    %{
      id: recipe.id,
      name: recipe.name,
      description: recipe.description,
      picture: Cookpod.Recipes.Picture.get_url(recipe)
    }
  end
end
