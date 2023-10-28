defmodule Tgate.Projects.Schemas.Project do
  use Ecto.Schema

  import Ecto.Changeset

  alias Tgate.Projects.Schemas.Abonent
  alias Tgate.Projects.Schemas.Owner

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          name: String.t(),
          owner_id: non_neg_integer(),
          owner: Owner.t() | Ecto.Association.NotLoaded.t(),
          abonents: [Abonent.t()] | Ecto.Association.NotLoaded.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "projects" do
    field :name, :string

    belongs_to :owner, Owner

    has_many :abonents, Abonent, on_delete: :delete_all

    timestamps()
  end

  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name, :owner_id])
    |> validate_required([:name, :owner_id])
    |> validate_length(:name, max: 256)
    |> foreign_key_constraint(:owner_id)
    |> unique_constraint([:owner_id])
  end
end
