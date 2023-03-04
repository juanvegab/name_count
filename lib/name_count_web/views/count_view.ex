defmodule NameCountWeb.CountView do
  use NameCountWeb, :view

  def render("index.json", %{names: names}) do
    %{names: names}
  end
end
