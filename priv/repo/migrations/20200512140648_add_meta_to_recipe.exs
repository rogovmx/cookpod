defmodule Cookpod.Repo.Migrations.AddMetaToRecipe do
  use Ecto.Migration

  def change do
  	alter table("recipes") do
  		add :meta, :map
  	end
  end
end
