defmodule NameCountWeb.CountController do
  use NameCountWeb, :controller

  alias NameCount.Counts

  def top(conn, %{"max_names" => max_names}) do
    names = Counts.count_names!(max_names)
    render(conn, "index.json", names: names)
  end
end
