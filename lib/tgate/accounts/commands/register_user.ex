defmodule Tgate.Accounts.Commands.RegisterUser do
  alias Tgate.Accounts.Schemas.User

  alias Tgate.Repo

  @type attrs :: %{
          required(:email) => String.t(),
          required(:password) => String.t()
        }

  @spec execute(attrs :: attrs()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def execute(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
end
