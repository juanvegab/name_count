defmodule NameCountWeb.NameController do
  use NameCountWeb, :controller

  alias NameCount.Counts
  alias NameCount.Counts.Name

  action_fallback NameCountWeb.FallbackController

  def index(conn, _params) do
    names = Counts.list_names()
    render(conn, "index.json", names: names)
  end

  def create(conn, %{"name" => name_params}) do
    with {:ok, %Name{} = name} <- Counts.create_name(name_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.name_path(conn, :show, name))
      |> render("show.json", name: name)
    end
  end

  def show(conn, %{"id" => id}) do
    name = Counts.get_name!(id)
    render(conn, "show.json", name: name)
  end

  def update(conn, %{"id" => id, "name" => name_params}) do
    name = Counts.get_name!(id)

    with {:ok, %Name{} = name} <- Counts.update_name(name, name_params) do
      render(conn, "show.json", name: name)
    end
  end

  def delete(conn, %{"id" => id}) do
    name = Counts.get_name!(id)

    with {:ok, %Name{}} <- Counts.delete_name(name) do
      send_resp(conn, :no_content, "")
    end
  end
end
