defmodule LiveviewDemo.Games.Counter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "counters" do
    field :count, :integer, default: 3
    field :name, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(counter, attrs) do
    counter
    |> cast(attrs, [:slug, :name, :count])
    |> validate_required([:slug, :name, :count])
    |> validate_format(:slug, ~r/^(?:[A-Za-z0-9\-_.~]|%[0-9A-Fa-f]{2})+$/)
    |> validate_length(:slug, min: 2)
    |> validate_length(:slug, max: 21)
    |> validate_length(:name, min: 2)
    |> validate_length(:name, max: 21)
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end
end
