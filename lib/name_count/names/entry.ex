defmodule NameCount.Names.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :date, :naive_datetime, redact: true
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:name, :date])
    |> validate_required([:name, :date])
  end
end
