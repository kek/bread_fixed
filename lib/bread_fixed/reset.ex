defmodule BreadFixed.Reset do
  alias BreadFixed.Repo
  alias BreadFixed.Endpoint
  alias BreadFixed.Bread

  def run do
    bread = Repo.get!(Bread, 1)
    params = %{fixed: false}
    changeset = Bread.changeset(bread, params)
    Repo.update(changeset)
    Endpoint.broadcast! "bread:fixed", "set_bread", %{fixed: false}
  end
end
