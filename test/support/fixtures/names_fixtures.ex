defmodule NameCount.NamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NameCount.Names` context.
  """

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        date: ~N[2023-03-01 20:55:00],
        name: "some name"
      })
      |> NameCount.Names.create_entry()

    entry
  end
end
