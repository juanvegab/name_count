defmodule NameCount.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :name, :string
      add :date, :naive_datetime

      timestamps()
    end
  end
end
