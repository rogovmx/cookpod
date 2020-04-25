defmodule Cookpod.Repo.Migrations.AddStateToRecipe do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :state, :string
    end
  end
end
