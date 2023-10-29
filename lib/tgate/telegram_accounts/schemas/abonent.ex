defmodule Tgate.TelegramAccounts.Schemas.Abonent do
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{
          status: String.t(),
          invite_code: String.t(),
          project_id: non_neg_integer(),
          telegram_id: nil | integer(),
          updated_at: NaiveDateTime.t()
        }

  schema "abonents" do
    field :status, :string
    field :invite_code, :string
    field :project_id, :integer
    field :telegram_id, :integer
    field :updated_at, :naive_datetime
  end

  def confirm_changeset(entity, attrs) do
    entity
    |> cast(attrs, [:invite_code, :status, :telegram_id])
    |> validate_required([:telegram_id, :status])
    |> validate_inclusion(:status, ["active"])
    |> unique_constraint([:project_id, :telegram_id])
  end
end
