defmodule NameCount.NamesTest do
  use NameCount.DataCase

  alias NameCount.Names

  describe "entries" do
    alias NameCount.Names.Entry

    import NameCount.NamesFixtures

    @invalid_attrs %{date: nil, name: nil}

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Names.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Names.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      valid_attrs = %{date: ~N[2023-03-01 20:55:00], name: "some name"}

      assert {:ok, %Entry{} = entry} = Names.create_entry(valid_attrs)
      assert entry.date == ~N[2023-03-01 20:55:00]
      assert entry.name == "some name"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Names.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      update_attrs = %{date: ~N[2023-03-02 20:55:00], name: "some updated name"}

      assert {:ok, %Entry{} = entry} = Names.update_entry(entry, update_attrs)
      assert entry.date == ~N[2023-03-02 20:55:00]
      assert entry.name == "some updated name"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Names.update_entry(entry, @invalid_attrs)
      assert entry == Names.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Names.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Names.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Names.change_entry(entry)
    end
  end
end
