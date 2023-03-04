defmodule NameCount.Repo.Migrations.CreateNames do
  use Ecto.Migration

  def change do
    create table(:names) do
      add :name, :string
      add :date, :naive_datetime

      timestamps()
    end
  end
end
