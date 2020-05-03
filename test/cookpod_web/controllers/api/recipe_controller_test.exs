defmodule CoocpodWeb.Api.RecipeControllerTest do
  use CookpodWeb.ConnCase
  use PhoenixSwagger.SchemaTest, "priv/static/swagger.json"

  import Cookpod.Factory

  describe "recipes" do
    test "GET /api/v1/recipes", %{conn: conn, swagger_schema: schema} do
      recipe = insert(:published_recipe)

      conn
      |> get(Routes.api_recipe_path(conn, :index))
      |> validate_resp_schema(schema, "Recipes")
      |> json_response(200)
    end
  end

  describe "show recipe" do
    test "GET /api/v1/recipes/:id", %{conn: conn, swagger_schema: schema} do
      recipe = insert(:published_recipe)

      conn
      |> get(Routes.api_recipe_path(conn, :show, recipe))
      |> validate_resp_schema(schema, "Recipe")
      |> json_response(200)
    end
  end
end
