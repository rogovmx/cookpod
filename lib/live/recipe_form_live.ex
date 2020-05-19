defmodule CookpodWeb.RecipeFormLive do
  use Phoenix.LiveView, layout: {CookpodWeb.LayoutView, "live.html"}

  alias Cookpod.Recipes
  alias Cookpod.Recipes.Recipe

  require Logger

  def mount(_params, session, socket) do
    recipe = get_recipe(session)

    assigns = [
      conn: socket,
      action: Map.fetch!(session, "action"),
      csrf_token: Map.fetch!(session, "csrf_token"),
      changeset: Recipes.change_recipe(recipe),
      recipe: recipe
    ]

    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate", %{"recipe" => recipe_params}, socket) do
    changeset =
      socket.assigns.recipe
      |> Recipe.changeset(recipe_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    CookpodWeb.RecipeView.render("form.html", assigns)
  end

  defp get_recipe(%{"id" => id} = _product_params), do: Recipes.get_recipe!(id)
  defp get_recipe(_product_params), do: %Recipe{state: "draft"}
end
