defmodule BreadFixed.BreadView do
  use BreadFixed.Web, :view

  def render("index.json", %{bread: bread}) do
    %{data: render_many(bread, BreadFixed.BreadView, "bread.json")}
  end

  def render("show.json", %{bread: bread}) do
    %{data: render_one(bread, BreadFixed.BreadView, "bread.json")}
  end

  def render("bread.json", %{bread: bread}) do
    %{id: bread.id,
      fixed: bread.fixed}
  end
end
