defmodule NameCountWeb.NameView do
  use NameCountWeb, :view
  alias NameCountWeb.NameView

  # def render("index.json", %{names: names}) do
  #   %{names: names}
  # end

  def render("index.json", %{names: names}) do
    %{data: render_many(names, NameView, "name.json")}
  end

  def render("show.json", %{name: name}) do
    %{data: render_one(name, NameView, "name.json")}
  end

  def render("name.json", %{name: name}) do
    %{
      id: name.id,
      name: name.name
    }
  end
end
