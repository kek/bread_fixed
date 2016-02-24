defmodule BreadFixed.BreadTest do
  use BreadFixed.ModelCase

  alias BreadFixed.Bread

  @valid_attrs %{fixed: true, name: "fooooooooooooooooooooooooools"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bread.changeset(%Bread{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bread.changeset(%Bread{}, @invalid_attrs)
    refute changeset.valid?
  end
end
