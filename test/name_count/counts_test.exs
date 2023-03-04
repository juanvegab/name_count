defmodule NameCount.CountsTest do
  use NameCount.DataCase

  alias NameCount.Counts

  describe "names" do
    alias NameCount.Counts.Name

    import NameCount.CountsFixtures

    @invalid_attrs %{date: nil, name: nil}

    test "list_names/0 returns all names" do
      name = name_fixture()
      assert Counts.list_names() == [name]
    end

    test "get_name!/1 returns the name with given id" do
      name = name_fixture()
      assert Counts.get_name!(name.id) == name
    end

    test "create_name/1 with valid data creates a name" do
      valid_attrs = %{date: ~N[2023-03-02 18:06:00], name: "some name"}

      assert {:ok, %Name{} = name} = Counts.create_name(valid_attrs)
      assert name.date == ~N[2023-03-02 18:06:00]
      assert name.name == "some name"
    end

    test "create_name/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Counts.create_name(@invalid_attrs)
    end

    test "update_name/2 with valid data updates the name" do
      name = name_fixture()
      update_attrs = %{date: ~N[2023-03-03 18:06:00], name: "some updated name"}

      assert {:ok, %Name{} = name} = Counts.update_name(name, update_attrs)
      assert name.date == ~N[2023-03-03 18:06:00]
      assert name.name == "some updated name"
    end

    test "update_name/2 with invalid data returns error changeset" do
      name = name_fixture()
      assert {:error, %Ecto.Changeset{}} = Counts.update_name(name, @invalid_attrs)
      assert name == Counts.get_name!(name.id)
    end

    test "delete_name/1 deletes the name" do
      name = name_fixture()
      assert {:ok, %Name{}} = Counts.delete_name(name)
      assert_raise Ecto.NoResultsError, fn -> Counts.get_name!(name.id) end
    end

    test "change_name/1 returns a name changeset" do
      name = name_fixture()
      assert %Ecto.Changeset{} = Counts.change_name(name)
    end
  end
end
