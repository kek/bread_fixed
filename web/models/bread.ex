defmodule BreadFixed.Bread do
  use BreadFixed.Web, :model

  schema "bread" do
    field :fixed, :boolean, default: false

    timestamps
  end

  @required_fields ~w(fixed)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
