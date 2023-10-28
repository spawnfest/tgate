defmodule Tgate.Accounts.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          email: String.t(),
          password_hash: String.t(),
          role: String.t(),
          status: String.t(),
          password: String.t() | nil,
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :role, :string, default: "client"
    field :status, :string, default: "pending"

    field :password, :string, virtual: true

    timestamps()
  end

  def registration_changeset(entity, attrs) do
    entity
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:email, max: 254, min: 6)
    |> validate_length(:password, min: 6, max: 50)
    |> put_password_hash()
    |> unique_constraint([:email])
  end

  defp put_password_hash(%{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:password_hash, password)
    |> put_change(:password, nil)
  end

  defp put_password_hash(changeset), do: changeset
end
