defmodule NameCountWeb.NameControllerTest do
  use NameCountWeb.ConnCase

  import NameCount.CountsFixtures

  alias NameCount.Counts.Name

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all names", %{conn: conn} do
      conn = get(conn, Routes.name_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create name" do
    test "renders name when data is valid", %{conn: conn} do
      conn = post(conn, Routes.name_path(conn, :create), name: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.name_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.name_path(conn, :create), name: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update name" do
    setup [:create_name]

    test "renders name when data is valid", %{conn: conn, name: %Name{id: id} = name} do
      conn = put(conn, Routes.name_path(conn, :update, name), name: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.name_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, name: name} do
      conn = put(conn, Routes.name_path(conn, :update, name), name: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete name" do
    setup [:create_name]

    test "deletes chosen name", %{conn: conn, name: name} do
      conn = delete(conn, Routes.name_path(conn, :delete, name))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.name_path(conn, :show, name))
      end
    end
  end

  defp create_name(_) do
    name = name_fixture()
    %{name: name}
  end
end
