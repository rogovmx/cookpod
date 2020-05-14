defmodule Cookpod.Recipes.Recipe do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Cookpod.Recipes.Ingredient

  schema "recipes" do
    field :description, :string
    field :name, :string
    field :picture, Cookpod.Recipes.Picture.Type
    field :state, :string

    has_many :ingridients, Ingredient
    has_many :products, through: [:ingridients, :product]

    embeds_one :meta, Meta do
      field :vegan, :string, default: "none"
    end

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :description, :state])
    |> cast_attachments(attrs, [:picture])
    |> validate_required([:name, :description, :state])
    |> validate_inclusion(:state, Cookpod.Recipes.RecipeStates.states())
    |> unique_constraint(:name)
  end
end
