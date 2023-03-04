defmodule NameCount.CountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NameCount.Counts` context.
  """

  @doc """
  Generate a name.
  """
  def name_fixture(attrs \\ %{}) do
    {:ok, name} =
      attrs
      |> Enum.into(%{
        date: ~N[2023-03-02 18:06:00],
        name: "some name"
      })
      |> NameCount.Counts.create_name()

    name
  end
end
