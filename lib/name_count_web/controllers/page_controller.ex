defmodule NameCountWeb.PageController do
  use NameCountWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
