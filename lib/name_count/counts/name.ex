defmodule NameCount.Counts.Name do
  use Ecto.Schema
  import Ecto.Changeset

  schema "names" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(name, attrs) do
    name
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
