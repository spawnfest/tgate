defmodule Tgate.Projects.Schemas.Abonent do
  use Ecto.Schema

  import Ecto.Changeset

  alias Tgate.Projects.Schemas.Project

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          name: String.t(),
          status: String.t(),
          invite_code: String.t() | nil,
          telegram_id: integer() | nil,
          project_id: non_neg_integer(),
          project: Project.t() | Ecto.Association.NotLoaded.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "abonents" do
    field :name, :string
    field :status, :string, default: "pending"

    field :invite_code, :string
    field :telegram_id, :integer

    belongs_to :project, Project

    timestamps()
  end

  def invite_changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name, :invite_code, :project_id])
    |> validate_required([:name, :invite_code, :project_id])
    |> foreign_key_constraint(:project_id)
    |> unique_constraint([:project_id, :name])
    |> unique_constraint([:project_id, :telegram_id])
  end

  def deactivate_changeset(entity, attrs) do
    entity
    |> cast(attrs, [:status])
    |> validate_required([:status])
    |> validate_inclusion(:status, ["deactivated"])
  end
end
