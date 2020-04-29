defmodule CookpodWeb.Api.RecipeController do
  use CookpodWeb, :controller
  use PhoenixSwagger

  alias Cookpod.Recipes

  def swagger_definitions do
  	%{
  		Recipe: swagger_schema do
        title("Recipe")
        description("Steps describe how to cook")

        properties do
        	id(:integer, "123", required: true)
        	name(:string, "fghgfh", required: true)
        	description(:string, "delicious", required: true)
        	picture(:string, "a.jpg", required: false)
        end

        example(%{
            id: 123,
            name: "Taco",
            picture: "Taco.jpg",
            description: "Take corn bread and make it"
         })
      end,

	    Recipes: swagger_schema do
        title("Recipes")
        description("many recipes")
	      type :array
	      items Schema.ref(:Recipe)
	    end
  	}
  end

	swagger_path :index do
	  get "/recipes"
	  description "List recipes"
	  response 200, "Success", Schema.array(:Recipes)
	end

  def index(conn, _params) do
  	render(conn, "index.json", recipes: Recipes.list_recipes)
  end

	swagger_path :show do
	  get "/recipes/{id}"
	  description "One recipe"
	  parameter(:id, :path, :integer, "ID", required: true, example: 123)
	  response 200, "Success", Schema.ref(:Recipe)
	end

  def show(conn, %{"id" => id}) do
  	render(conn, "show.json", recipe: Recipes.get_recipe!(id))
  end
end  