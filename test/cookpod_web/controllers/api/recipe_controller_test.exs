defmodule CoocpodWeb.Api.RecipeControllerTest do
	use CookpodWeb.ConnCase
	use PhoenixSwagger.SchemaTest, "priv/static/swagger.json"

	alias Cookpod.Recipes

	@create_attrs %{description: "some description", name: "some name", state: "published", picture: "test.jpg"}

  def fixture(:recipe) do
    {:ok, recipe} = Recipes.create_recipe(@create_attrs)
    recipe
  end

	describe "recipes" do
		setup [:create_recipe]

		test "GET /api/v1/recipes", %{conn: conn, swagger_schema: schema} do
			# conn = get(conn, Routes.api_recipe_path(conn, :index))
			# %{"many" => [recipe]} = json_response(conn, 200)
			# assert recipe["name"] == "some name"
			conn
			|> get(Routes.api_recipe_path(conn, :index))
			|> validate_resp_schema(schema, "Recipes")
			|> json_response(200)
		end
	end	

	describe "show recipe" do
		setup [:create_recipe]

		test "GET /api/v1/recipes/:id", %{recipe: recipe, conn: conn, swagger_schema: schema} do
			conn
			|> get(Routes.api_recipe_path(conn, :show, recipe))
			|> validate_resp_schema(schema, "Recipe")
			|> json_response(200)
		end
	end	

	defp create_recipe(_) do
    recipe = fixture(:recipe)
    {:ok, recipe: recipe}
  end

end