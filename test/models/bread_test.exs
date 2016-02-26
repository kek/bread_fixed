defmodule BreadFixed.BreadTest do
  use BreadFixed.ModelCase

  alias BreadFixed.Bread

  @valid_attrs %{fixed: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bread.changeset(%Bread{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bread.changeset(%Bread{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with invalid attributes for existing record" do
    bread = BreadFixed.Repo.insert!(%BreadFixed.Bread{fixed: false})
    changeset = Bread.changeset(bread, @invalid_attrs)
    refute changeset.valid?
  end
end
