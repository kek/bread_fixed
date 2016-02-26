defmodule BreadFixed.Repo.Migrations.CreateBread do
  use Ecto.Migration

  def change do
    create table(:bread) do
      add :fixed, :boolean, null: false

      timestamps
    end

  end
end
