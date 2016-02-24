defmodule BreadFixed.Repo.Migrations.CreateBread do
  use Ecto.Migration

  def change do
    create table(:bread) do
      add :fixed, :boolean, default: false
      add :name, :string

      timestamps
    end

  end
end
