defmodule BreadFixed.Bread do
  use BreadFixed.Web, :model

  schema "bread" do
    field :fixed, :boolean, null: false

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

defimpl Poison.Encoder, for: BreadFixed.Bread do
  def encode(model, opts) do
    Poison.Encoder.encode(%{fixed: model.fixed()}, opts)
  end
end
