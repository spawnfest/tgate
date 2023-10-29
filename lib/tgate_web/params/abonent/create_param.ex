defmodule TgateWeb.Abonent.CreateParam do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :name, :string
  end

  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, max: 256, min: 1)
  end
end
